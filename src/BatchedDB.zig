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
io: std.Io,
sync_interval_ns: u64,
sync_bytes: u64,
allocator: std.mem.Allocator,
callback_capacity: usize,
callbacks: ?[]CommitWaiter = null,

// Callback ring head index.
cb_head: std.atomic.Value(u64) align(std.atomic.cache_line) = std.atomic.Value(u64).init(0),
// Callback ring tail index.
cb_tail: std.atomic.Value(u64) align(std.atomic.cache_line) = std.atomic.Value(u64).init(0),
// Signals the sync thread to exit.
stop: std.atomic.Value(bool) align(std.atomic.cache_line) = std.atomic.Value(bool).init(false),
// Futex word for waiters on durability progress.
sync_counter: std.atomic.Value(u32) align(std.atomic.cache_line) = std.atomic.Value(u32).init(0),
// Futex word for waking the sync thread when sync interval is 0.
sync_signal: std.atomic.Value(u32) align(std.atomic.cache_line) = std.atomic.Value(u32).init(0),
// Monotonic commit sequence for issued write txns.
issued_seq: std.atomic.Value(u64) align(std.atomic.cache_line) = std.atomic.Value(u64).init(0),
// Highest sequence known durable.
durable_seq: std.atomic.Value(u64) align(std.atomic.cache_line) = std.atomic.Value(u64).init(0),
// Highest sequence that failed durability.
failed_seq: std.atomic.Value(u64) align(std.atomic.cache_line) = std.atomic.Value(u64).init(0),

last_sync_ns: u64,
thread: ?std.Thread = null,

pub fn init(self: *BatchedDB, io: std.Io, env: Environment, allocator: std.mem.Allocator, options: Options) !void {
    self.* = BatchedDB{
        .env = env,
        .io = io,
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
    self.io.futexWake(u32, &self.sync_counter.raw, std.math.maxInt(u32));
    _ = self.sync_signal.fetchAdd(1, .release);
    self.io.futexWake(u32, &self.sync_signal.raw, std.math.maxInt(u32));
    if (self.thread) |t| t.join();
    if (self.callbacks) |buf| {
        self.allocator.free(buf);
        self.callbacks = null;
    }
}

pub fn transaction(self: *BatchedDB, options: BaseTransaction.Options) !Transaction {
    const txn = try self.env.transaction(options);
    return .{
        .db = if (options.mode == .ReadWrite and options.parent == null) self else null,
        .txn = txn,
        .is_nested = options.parent != null,
    };
}

pub const Transaction = struct {
    db: ?*BatchedDB,
    txn: BaseTransaction,
    is_nested: bool,

    pub fn abort(self: Transaction) !void {
        try self.txn.abort();
    }

    pub fn commit(self: Transaction) !void {
        if (self.db) |db| {
            const seq = db.issued_seq.fetchAdd(1, .monotonic) + 1;
            try throw(c.mdbx_txn_commit(self.txn.ptr));
            if (db.sync_interval_ns == 0) db.notifySync();
            try db.waitForDurable(seq);
            return;
        }
        try self.txn.commit();
    }

    pub fn commitAsync(self: Transaction, cb: CommitCallback, ctx: ?*anyopaque) !void {
        if (self.is_nested) return error.NestedTransaction;
        const db = self.db orelse return error.ReadOnlyTransaction;
        const seq = db.issued_seq.fetchAdd(1, .monotonic) + 1;
        try throw(c.mdbx_txn_commit(self.txn.ptr));
        if (db.sync_interval_ns == 0) db.notifySync();
        while (true) {
            if (db.failed_seq.load(.acquire) >= seq) {
                cb(ctx, false);
                return;
            }
            db.enqueueCallback(seq, cb, ctx) catch |e| switch (e) {
                error.CallbackQueueFull => {
                    const cur = db.sync_counter.load(.acquire);
                    db.io.futexWaitUncancelable(u32, &db.sync_counter.raw, cur);
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

    pub fn reset(self: Transaction) !void {
        try self.txn.reset();
    }

    pub fn renew(self: Transaction) !void {
        try self.txn.renew();
    }

    pub fn park(self: Transaction, autounpark: bool) !void {
        try self.txn.park(autounpark);
    }

    pub fn unpark(self: Transaction, restart_if_ousted: bool) !void {
        try self.txn.unpark(restart_if_ousted);
    }

    pub fn setUserctx(self: Transaction, ctx: ?*anyopaque) !void {
        try self.txn.setUserctx(ctx);
    }

    pub fn getUserctx(self: Transaction) ?*anyopaque {
        return self.txn.getUserctx();
    }

    pub fn replace(self: Transaction, key: []const u8, new_value: ?[]const u8, old_value: ?[]const u8, flag: @import("Database.zig").ReplaceFlag) !?[]const u8 {
        return try self.txn.replace(key, new_value, old_value, flag);
    }

    pub fn estimateRange(
        self: Transaction,
        db: @import("Database.zig"),
        begin_key: ?[]const u8,
        begin_data: ?[]const u8,
        end_key: ?[]const u8,
        end_data: ?[]const u8,
    ) !isize {
        return try self.txn.estimateRange(db, begin_key, begin_data, end_key, end_data);
    }

    pub fn canaryPut(self: Transaction, canary: ?*const BaseTransaction.Canary) !void {
        try self.txn.canaryPut(canary);
    }

    pub fn canaryGet(self: Transaction) !BaseTransaction.Canary {
        return try self.txn.canaryGet();
    }

    pub fn releaseAllCursors(self: Transaction, unbind: bool) !void {
        try self.txn.releaseAllCursors(unbind);
    }

    pub fn getEqualOrGreat(self: Transaction, key: []const u8) !?@import("Cursor.zig").Entry {
        return try self.txn.getEqualOrGreat(key);
    }

    pub fn nested(self: Transaction, options: BaseTransaction.Options) !Transaction {
        const txn = try self.txn.nested(options);
        return .{
            .db = null,
            .txn = txn,
            .is_nested = true,
        };
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

    pub fn id(self: Transaction) u64 {
        return self.txn.id();
    }

    pub fn info(self: Transaction, scan_rlt: bool) !BaseTransaction.Info {
        return try self.txn.info(scan_rlt);
    }

    pub fn straggler(self: Transaction) !u8 {
        return try self.txn.straggler();
    }

    pub fn checkpoint(self: Transaction, weakening_durability: u32) !BaseTransaction.CommitLatency {
        return try self.txn.checkpoint(weakening_durability);
    }

    pub fn gcInfo(self: Transaction) !BaseTransaction.GcInfo {
        return try self.txn.gcInfo();
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
        self.io.futexWaitUncancelable(u32, &self.sync_counter.raw, cur);
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
    const io = self.io;
    while (true) {
        if (self.stop.load(.acquire)) return;
        if (self.last_sync_ns == 0) {
            self.last_sync_ns = monotonicNs(io);
        }
        const deadline = self.last_sync_ns + self.sync_interval_ns;
        const now = monotonicNs(io);
        if (now < deadline) {
            io.sleep(.fromNanoseconds(@intCast(deadline - now)), .awake) catch {};
        }

        const target = self.issued_seq.load(.monotonic);
        const durable = self.durable_seq.load(.acquire);
        if (target == durable) {
            if (self.sync_interval_ns == 0) {
                const cur = self.sync_signal.load(.acquire);
                io.futexWaitUncancelable(u32, &self.sync_signal.raw, cur);
                continue;
            }
            self.last_sync_ns = monotonicNs(io);
            _ = self.sync_counter.fetchAdd(1, .release);
            io.futexWake(u32, &self.sync_counter.raw, std.math.maxInt(u32));
            self.drainCallbacks(target, true);
            continue;
        }
        _ = self.env.sync(false, true) catch |err| switch (err) {
            error.MDBX_BUSY => {
                self.last_sync_ns = monotonicNs(io);
                continue;
            },
            else => {
                std.debug.print("batched io sync error: {any}\n", .{err});
                updateSeqMax(&self.failed_seq, target);
                self.last_sync_ns = monotonicNs(io);
                _ = self.sync_counter.fetchAdd(1, .release);
                io.futexWake(u32, &self.sync_counter.raw, std.math.maxInt(u32));
                self.drainCallbacks(target, false);
                continue;
            },
        };
        updateSeqMax(&self.durable_seq, target);
        self.last_sync_ns = monotonicNs(io);

        _ = self.sync_counter.fetchAdd(1, .release);
        io.futexWake(u32, &self.sync_counter.raw, std.math.maxInt(u32));
        self.drainCallbacks(target, true);
    }
}

fn notifySync(self: *BatchedDB) void {
    _ = self.sync_signal.fetchAdd(1, .release);
    self.io.futexWake(u32, &self.sync_signal.raw, 1);
}

inline fn monotonicNs(io: std.Io) u64 {
    const ts = std.Io.Clock.awake.now(io);
    return @intCast(ts.nanoseconds);
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
