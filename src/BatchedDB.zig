const std = @import("std");
const c = @import("c.zig");
const errors = @import("errors.zig");
const Environment = @import("Environment.zig");
const BaseTransaction = @import("Transaction.zig");

const throw = errors.throw;

const BatchedDB = @This();

pub const Options = struct {
    /// Sync interval in milliseconds.
    sync_interval_ms: u32 = 2,
    /// If non-zero, trigger early sync when unsynced volume reaches this threshold.
    sync_bytes: u64 = 0,
    /// Max pending callbacks. 0 disables callback queue.
    callback_capacity: usize = 0,
};

env: Environment,
sync_interval_ns: u64,
sync_bytes: u64,
allocator: std.mem.Allocator,
callback_capacity: usize,
callbacks: ?[]CommitWaiter = null,
cb_head: std.atomic.Value(u64) align(std.atomic.cache_line) = std.atomic.Value(u64).init(0),
cb_tail: std.atomic.Value(u64) align(std.atomic.cache_line) = std.atomic.Value(u64).init(0),
stop: std.atomic.Value(bool) align(std.atomic.cache_line) = std.atomic.Value(bool).init(false),
sync_counter: std.atomic.Value(u32) align(std.atomic.cache_line) = std.atomic.Value(u32).init(0),
issued_seq: std.atomic.Value(u64) align(std.atomic.cache_line) = std.atomic.Value(u64).init(0),
durable_seq: std.atomic.Value(u64) align(std.atomic.cache_line) = std.atomic.Value(u64).init(0),
failed_seq: std.atomic.Value(u64) align(std.atomic.cache_line) = std.atomic.Value(u64).init(0),
last_sync_ns: u64,
thread: ?std.Thread = null,

pub fn init(self: *BatchedDB, env: Environment, allocator: std.mem.Allocator, options: Options) !void {
    self.* = BatchedDB{
        .env = env,
        .sync_interval_ns = @as(u64, options.sync_interval_ms) * 1_000_000,
        .sync_bytes = options.sync_bytes,
        .allocator = allocator,
        .callback_capacity = options.callback_capacity,
        .last_sync_ns = 0,
    };

    // Enable SAFE_NOSYNC so that we can control syncing manually
    try throw(c.mdbx_env_set_flags(self.env.ptr, c.MDBX_SAFE_NOSYNC, true));

    const period_ms: u64 = self.sync_interval_ns / 1_000_000;
    const seconds_16dot16: u64 = (period_ms << 16) / 1000;
    try throw(c.mdbx_env_set_option(self.env.ptr, @as(c_uint, @bitCast(c.MDBX_opt_sync_period)), seconds_16dot16));
    if (self.sync_bytes != 0) {
        try throw(c.mdbx_env_set_option(self.env.ptr, @as(c_uint, @bitCast(c.MDBX_opt_sync_bytes)), self.sync_bytes));
    }
    if (self.callback_capacity != 0) {
        self.callbacks = try self.allocator.alloc(CommitWaiter, self.callback_capacity);
        errdefer self.allocator.free(self.callbacks.?);
        for (self.callbacks.?) |*slot| slot.* = .{};
    }
    self.thread = try std.Thread.spawn(.{}, syncLoop, .{self});
}

pub fn deinit(self: *BatchedDB) void {
    self.stop.store(true, .release);
    _ = self.sync_counter.fetchAdd(1, .release);
    std.Thread.Futex.wake(&self.sync_counter, std.math.maxInt(u32));
    if (self.thread) |t| t.join();
    if (self.callbacks) |buf| {
        self.allocator.free(buf);
        self.callbacks = null;
    }
}

pub fn transaction(self: *BatchedDB, options: BaseTransaction.Options) !Transaction {
    const txn = try self.env.transaction(options);
    return .{
        .db = if (options.mode == .ReadWrite) self else null,
        .txn = txn,
    };
}

pub const Transaction = struct {
    db: ?*BatchedDB,
    txn: BaseTransaction,

    pub fn abort(self: Transaction) !void {
        try self.txn.abort();
    }

    pub fn commit(self: Transaction) !void {
        if (self.db) |db| {
            const seq = db.issued_seq.fetchAdd(1, .monotonic) + 1;
            try throw(c.mdbx_txn_commit(self.txn.ptr));
            try db.waitForDurable(seq);
            return;
        }
        try self.txn.commit();
    }

    pub fn commitAsync(self: Transaction, cb: CommitCallback, ctx: ?*anyopaque) !void {
        const db = self.db orelse return error.ReadOnlyTransaction;
        const seq = db.issued_seq.fetchAdd(1, .monotonic) + 1;
        try throw(c.mdbx_txn_commit(self.txn.ptr));
        while (true) {
            if (db.failed_seq.load(.acquire) >= seq) {
                cb(ctx, false);
                return;
            }
            db.enqueueCallback(seq, cb, ctx) catch |e| switch (e) {
                error.CallbackQueueFull => {
                    const cur = db.sync_counter.load(.acquire);
                    std.Thread.Futex.wait(&db.sync_counter, cur);
                    continue;
                },
                else => return e,
            };
            return;
        }
    }

    pub fn inner(self: Transaction) BaseTransaction {
        return self.txn;
    }

    pub fn get(self: Transaction, key: []const u8) !?[]const u8 {
        return try self.txn.get(key);
    }

    pub fn set(self: Transaction, key: []const u8, value: []const u8, flag: @import("Database.zig").SetFlag) !void {
        try self.txn.set(key, value, flag);
    }

    pub fn delete(self: Transaction, key: []const u8) !void {
        try self.txn.delete(key);
    }

    pub fn cursor(self: Transaction) !@import("Cursor.zig") {
        return try self.txn.cursor();
    }

    pub fn database(self: Transaction, name: ?[*:0]const u8, options: @import("Database.zig").Options) !@import("Database.zig") {
        return try self.txn.database(name, options);
    }
};

pub const CommitCallback = *const fn (ctx: ?*anyopaque, success: bool) void;

const CommitWaiter = struct {
    seq: u64 = 0,
    cb: CommitCallback = undefined,
    ctx: ?*anyopaque = null,
    ready: std.atomic.Value(bool) = std.atomic.Value(bool).init(false),
};

fn waitForDurable(self: *BatchedDB, seq: u64) !void {
    if (self.durable_seq.load(.acquire) >= seq) {
        return;
    }
    if (self.failed_seq.load(.acquire) >= seq) {
        return error.SyncFailed;
    }

    while (self.durable_seq.load(.acquire) < seq and !self.stop.load(.acquire)) {
        if (self.failed_seq.load(.acquire) >= seq) {
            return error.SyncFailed;
        }
        const cur = self.sync_counter.load(.acquire);
        std.Thread.Futex.wait(&self.sync_counter, cur);
    }
}

fn enqueueCallback(self: *BatchedDB, seq: u64, cb: CommitCallback, ctx: ?*anyopaque) !void {
    const buf = self.callbacks orelse return error.CallbacksDisabled;
    const cap = self.callback_capacity;

    while (true) {
        const head = self.cb_head.load(.acquire);
        const tail = self.cb_tail.load(.monotonic);
        if (tail - head >= cap) return error.CallbackQueueFull;
        if (self.cb_tail.cmpxchgWeak(tail, tail + 1, .acq_rel, .acquire) == null) {
            const idx = @as(usize, @intCast(tail % cap));
            var slot = &buf[idx];
            slot.seq = seq;
            slot.cb = cb;
            slot.ctx = ctx;
            slot.ready.store(true, .release);
            return;
        }
    }
}

fn syncLoop(self: *BatchedDB) void {
    while (true) {
        if (self.stop.load(.acquire)) return;
        if (self.last_sync_ns == 0) {
            self.last_sync_ns = @as(u64, @intCast(std.time.nanoTimestamp()));
        }
        const deadline = self.last_sync_ns + self.sync_interval_ns;
        const now = @as(u64, @intCast(std.time.nanoTimestamp()));
        if (now < deadline) {
            std.Thread.sleep(deadline - now);
        }

        const target = self.issued_seq.load(.monotonic);
        const durable = self.durable_seq.load(.acquire);
        if (target == durable) {
            self.last_sync_ns = @as(u64, @intCast(std.time.nanoTimestamp()));
            _ = self.sync_counter.fetchAdd(1, .release);
            std.Thread.Futex.wake(&self.sync_counter, std.math.maxInt(u32));
            self.drainCallbacks(target, true);
            continue;
        }
        _ = self.env.sync(false, true) catch |err| switch (err) {
            error.MDBX_BUSY => {
                self.last_sync_ns = @as(u64, @intCast(std.time.nanoTimestamp()));
                continue;
            },
            else => {
                std.debug.print("batched io sync error: {any}\n", .{err});
                updateSeqMax(&self.failed_seq, target);
                self.last_sync_ns = @as(u64, @intCast(std.time.nanoTimestamp()));
                _ = self.sync_counter.fetchAdd(1, .release);
                std.Thread.Futex.wake(&self.sync_counter, std.math.maxInt(u32));
                self.drainCallbacks(target, false);
                continue;
            },
        };
        updateSeqMax(&self.durable_seq, target);
        self.last_sync_ns = @as(u64, @intCast(std.time.nanoTimestamp()));

        _ = self.sync_counter.fetchAdd(1, .release);
        std.Thread.Futex.wake(&self.sync_counter, std.math.maxInt(u32));
        self.drainCallbacks(target, true);
    }
}

fn drainCallbacks(self: *BatchedDB, threshold: u64, success: bool) void {
    const buf = self.callbacks orelse return;
    const cap = self.callback_capacity;
    while (true) {
        const head = self.cb_head.load(.monotonic);
        const tail = self.cb_tail.load(.monotonic);
        if (head == tail) break;
        const idx = @as(usize, @intCast(head % cap));
        var slot = &buf[idx];
        if (!slot.ready.load(.acquire)) break;
        if (slot.seq > threshold) break;
        const cb = slot.cb;
        const ctx = slot.ctx;
        const failed = self.failed_seq.load(.acquire);
        const ok = success and slot.seq > failed;
        slot.ready.store(false, .release);
        self.cb_head.store(head + 1, .release);
        cb(ctx, ok);
    }
}

fn updateSeqMax(target: *std.atomic.Value(u64), value: u64) void {
    var cur = target.load(.acquire);
    while (value > cur) {
        if (target.*.cmpxchgWeak(cur, value, .release, .acquire) == null) break;
        cur = target.load(.acquire);
    }
}
