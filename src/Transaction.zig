const std = @import("std");
const c = @import("c.zig");
const errors = @import("errors.zig");
const Environment = @import("Environment.zig");
const Database = @import("Database.zig");
const Cursor = @import("Cursor.zig");

const throw = errors.throw;

const Transaction = @This();
pub const Canary = c.MDBX_canary;

/// Transaction init options
pub const Options = struct {
    mode: Mode = .ReadWrite,
    parent: ?Transaction = null,
    txn_try: bool = false
};

/// Mode of this transaction
pub const Mode = enum { ReadOnly, ReadWrite };

ptr: ?*c.MDBX_txn = null,

/// Initialize a transaction
pub fn init(env: Environment, options: Options) !Transaction {
    var txn = Transaction{};

    var flags: c_int = 0;
    switch (options.mode) {
        .ReadOnly => {
            flags |= c.MDBX_RDONLY;
        },
        .ReadWrite => {},
    }
    
    if (options.txn_try) flags |= c.MDBX_TXN_TRY;

    // Get parent transaction if provided
    var parentPtr: ?*c.MDBX_txn = null;
    if (options.parent) |parent| {
        parentPtr = parent.ptr;
    }

    try throw(c.mdbx_txn_begin(env.ptr, parentPtr, flags, &txn.ptr));

    return txn;
}

/// Begin a nested transaction using this transaction as the parent.
pub fn nested(self: Transaction, options: Options) !Transaction {
    var txn = Transaction{};

    var flags: c_int = 0;
    switch (options.mode) {
        .ReadOnly => {
            flags |= c.MDBX_RDONLY;
        },
        .ReadWrite => {},
    }
    if (options.txn_try) flags |= c.MDBX_TXN_TRY;

    const env_ptr = c.mdbx_txn_env(self.ptr) orelse return error.InvalidParentTransaction;
    try throw(c.mdbx_txn_begin(env_ptr, self.ptr, flags, &txn.ptr));
    return txn;
}

/// Abort the transaction
pub fn abort(self: Transaction) !void {
    try throw(c.mdbx_txn_abort(self.ptr));
}

/// Commit the transaction
pub fn commit(self: Transaction) !void {
    try throw(c.mdbx_txn_commit(self.ptr));
}

/// Reset a read-only transaction for later reuse via renew().
pub fn reset(self: Transaction) !void {
    try throw(c.mdbx_txn_reset(self.ptr));
}

/// Renew a reset read-only transaction.
pub fn renew(self: Transaction) !void {
    try throw(c.mdbx_txn_renew(self.ptr));
}

/// Park a read-only transaction.
pub fn park(self: Transaction, autounpark: bool) !void {
    try throw(c.mdbx_txn_park(self.ptr, autounpark));
}

/// Unpark a previously parked read-only transaction.
pub fn unpark(self: Transaction, restart_if_ousted: bool) !void {
    try throw(c.mdbx_txn_unpark(self.ptr, restart_if_ousted));
}

/// Set a user context pointer on this transaction.
pub fn setUserctx(self: Transaction, ctx: ?*anyopaque) !void {
    try throw(c.mdbx_txn_set_userctx(self.ptr, ctx));
}

/// Get the user context pointer from this transaction.
pub fn getUserctx(self: Transaction) ?*anyopaque {
    return c.mdbx_txn_get_userctx(self.ptr);
}

/// Replace a record and optionally return the previous value.
pub fn replace(self: Transaction, key: []const u8, new_value: ?[]const u8, old_value: ?[]const u8, flag: Database.ReplaceFlag) !?[]const u8 {
    const db = try Database.open(self, null, .{});
    return try db.replace(key, new_value, old_value, flag);
}

/// Release all cursors from this transaction.
pub fn releaseAllCursors(self: Transaction, unbind: bool) !void {
    try throw(c.mdbx_txn_release_all_cursors_ex(self.ptr, unbind, null));
}

/// Find entry for key or the next greater key.
pub fn getEqualOrGreat(self: Transaction, key: []const u8) !?Cursor.Entry {
    const db = try Database.open(self, null, .{});
    return try db.getEqualOrGreat(key);
}

/// Estimate the number of items between two keys.
pub fn estimateRange(
    self: Transaction,
    db: Database,
    begin_key: ?[]const u8,
    begin_data: ?[]const u8,
    end_key: ?[]const u8,
    end_data: ?[]const u8,
) !isize {
    var dist: c.ptrdiff_t = 0;
    var bk: c.MDBX_val = .{ .iov_len = 0, .iov_base = null };
    var bd: c.MDBX_val = .{ .iov_len = 0, .iov_base = null };
    var ek: c.MDBX_val = .{ .iov_len = 0, .iov_base = null };
    var ed: c.MDBX_val = .{ .iov_len = 0, .iov_base = null };

    const bk_ptr: ?*const c.MDBX_val = if (begin_key) |k| blk: {
        bk.iov_len = k.len;
        bk.iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(k.ptr)));
        break :blk &bk;
    } else null;
    const bd_ptr: ?*const c.MDBX_val = if (begin_data) |d| blk: {
        bd.iov_len = d.len;
        bd.iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(d.ptr)));
        break :blk &bd;
    } else null;
    const ek_ptr: ?*const c.MDBX_val = if (end_key) |k| blk: {
        ek.iov_len = k.len;
        ek.iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(k.ptr)));
        break :blk &ek;
    } else null;
    const ed_ptr: ?*const c.MDBX_val = if (end_data) |d| blk: {
        ed.iov_len = d.len;
        ed.iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(d.ptr)));
        break :blk &ed;
    } else null;

    try throw(c.mdbx_estimate_range(self.ptr, db.dbi, bk_ptr, bd_ptr, ek_ptr, ed_ptr, &dist));
    return dist;
}

/// Set canary markers for this transaction/environment.
pub fn canaryPut(self: Transaction, canary: ?*const Canary) !void {
    try throw(c.mdbx_canary_put(self.ptr, canary));
}

/// Get canary markers for this transaction/environment.
pub fn canaryGet(self: Transaction) !Canary {
    var canary: Canary = undefined;
    try throw(c.mdbx_canary_get(self.ptr, &canary));
    return canary;
}

/// Get a record by key
pub fn get(self: Transaction, key: []const u8) !?[]const u8 {
    const db = try Database.open(self, null, .{});
    return try db.get(key);
}

/// Set a record
pub fn set(self: Transaction, key: []const u8, value: []const u8, flag: Database.SetFlag) !void {
    const db = try Database.open(self, null, .{});
    try db.set(key, value, flag);
}

/// Delete a record by key
pub fn delete(self: Transaction, key: []const u8) !void {
    const db = try Database.open(self, null, .{});
    try db.delete(key);
}

/// Get a cursor in this transaction
pub fn cursor(self: Transaction) !Cursor {
    const db = try Database.open(self, null, .{});
    return try Cursor.init(db);
}

/// Open and get a database handle
pub fn database(self: Transaction, name: ?[*:0]const u8, options: Database.Options) !Database {
    return Database.open(self, name, options);
}

/// Information returned by `Transaction.info`.
pub const Info = struct {
    txn_id: u64,
    /// For read-only txns: number of write txns committed since this read started.
    reader_lag: u64,
    /// Bytes used by data and indexes, summed across all DBs.
    space_used: u64,
    /// Soft DB size limit: current map size.
    space_limit_soft: u64,
    /// Hard DB size limit: configured upper bound.
    space_limit_hard: u64,
    /// Bytes that became free in this txn but cannot yet be reused.
    space_retired: u64,
    /// Free space available within the current map.
    space_leftover: u64,
    /// For write txns: bytes of dirty pages held by this txn.
    space_dirty: u64,
};

/// Get information about this transaction.
/// `scan_rlt` is meaningful only for read-only txns; when true the reader lock table is
/// scanned to compute `reader_lag` accurately. Otherwise it is reported as 0.
pub fn info(self: Transaction, scan_rlt: bool) !Info {
    var raw: c.MDBX_txn_info = undefined;
    try throw(c.mdbx_txn_info(self.ptr, &raw, scan_rlt));
    return .{
        .txn_id = raw.txn_id,
        .reader_lag = raw.txn_reader_lag,
        .space_used = raw.txn_space_used,
        .space_limit_soft = raw.txn_space_limit_soft,
        .space_limit_hard = raw.txn_space_limit_hard,
        .space_retired = raw.txn_space_retired,
        .space_leftover = raw.txn_space_leftover,
        .space_dirty = raw.txn_space_dirty,
    };
}

/// Transaction id, or 0 if not active.
pub fn id(self: Transaction) u64 {
    return c.mdbx_txn_id(self.ptr);
}

/// Transaction flags returned by `Transaction.getFlags`.
pub const Flags = struct {
    /// Raw bitmask returned by mdbx; preserved for forward compatibility.
    raw: i32,
    /// Transaction is read-only.
    read_only: bool,
    /// Transaction has finished, committed or aborted, and may not be reused.
    finished: bool,
    /// A previous operation on this transaction failed.
    err: bool,
    /// Transaction has uncommitted dirty pages.
    dirty: bool,
    /// Transaction has spilled dirty pages to disk.
    spilled: bool,
    /// Transaction has an active nested child txn.
    has_child: bool,
    /// Read-only transaction is currently parked.
    parked: bool,
    /// Parked txn will auto-unpark on next access.
    autounpark: bool,
    /// Reader was kicked out by a writer; the transaction is invalid.
    ousted: bool,
    /// Transaction handle has been invalidated.
    invalid: bool,
};

/// Bit-mask of currently active transaction flags.
pub fn getFlags(self: Transaction) Flags {
    const raw = c.mdbx_txn_flags(self.ptr);
    return .{
        .raw = raw,
        .read_only = (raw & c.MDBX_TXN_RDONLY) != 0,
        .finished = (raw & c.MDBX_TXN_FINISHED) != 0,
        .err = (raw & c.MDBX_TXN_ERROR) != 0,
        .dirty = (raw & c.MDBX_TXN_DIRTY) != 0,
        .spilled = (raw & c.MDBX_TXN_SPILLS) != 0,
        .has_child = (raw & c.MDBX_TXN_HAS_CHILD) != 0,
        .parked = (raw & c.MDBX_TXN_PARKED) != 0,
        .autounpark = (raw & c.MDBX_TXN_AUTOUNPARK) != 0,
        .ousted = (raw & c.MDBX_TXN_OUSTED) != 0,
        .invalid = raw == c.MDBX_TXN_INVALID,
    };
}

/// Mark this transaction as broken: it will not commit, only abort.
pub fn breakTxn(self: Transaction) !void {
    try throw(c.mdbx_txn_break(self.ptr));
}

/// Latency breakdown returned by `commitWithLatency`.
pub const CommitLatency = struct {
    preparation: u32,
    gc_wallclock: u32,
    audit: u32,
    write: u32,
    sync: u32,
    ending: u32,
    whole: u32,
    gc_cputime: u32,
};

/// Commit this transaction and return per-stage latencies in 1/65536 of a second.
pub fn commitWithLatency(self: Transaction) !CommitLatency {
    var raw: c.MDBX_commit_latency = undefined;
    try throw(c.mdbx_txn_commit_ex(self.ptr, &raw));
    return .{
        .preparation = raw.preparation,
        .gc_wallclock = raw.gc_wallclock,
        .audit = raw.audit,
        .write = raw.write,
        .sync = raw.sync,
        .ending = raw.ending,
        .whole = raw.whole,
        .gc_cputime = raw.gc_cputime,
    };
}

/// Mid-transaction checkpoint: flushes accumulated writes without ending the txn.
/// `weakening_durability` may include `MDBX_NOMETASYNC` / `MDBX_SAFE_NOSYNC`.
pub fn checkpoint(self: Transaction, weakening_durability: u32) !CommitLatency {
    var raw: c.MDBX_commit_latency = undefined;
    try throw(c.mdbx_txn_checkpoint(self.ptr, weakening_durability, &raw));
    return .{
        .preparation = raw.preparation,
        .gc_wallclock = raw.gc_wallclock,
        .audit = raw.audit,
        .write = raw.write,
        .sync = raw.sync,
        .ending = raw.ending,
        .whole = raw.whole,
        .gc_cputime = raw.gc_cputime,
    };
}

/// For a read-only txn: percentage 0..100 by which the txn lags the latest committed state.
pub fn straggler(self: Transaction) !u8 {
    var pct: c_int = 0;
    try throw(c.mdbx_txn_straggler(self.ptr, &pct));
    if (pct < 0) return 0;
    if (pct > 100) return 100;
    return @intCast(pct);
}

/// Garbage-collection statistics returned by `gcInfo`.
pub const GcInfo = struct {
    pages_total: usize,
    pages_backed: usize,
    pages_allocated: usize,
    pages_gc: usize,
    /// Pages currently reclaimable from the GC.
    gc_reclaimable_pages: usize,
    /// Largest reader-lag, in pages, retaining GC entries.
    max_reader_lag: usize,
    /// Largest single span of pages retained by readers.
    max_retained_pages: usize,
};

/// Inspect the free-page reuse list for this transaction's MVCC snapshot.
pub fn gcInfo(self: Transaction) !GcInfo {
    var raw: c.MDBX_gc_info_t = std.mem.zeroes(c.MDBX_gc_info_t);
    const rc = c.mdbx_gc_info(self.ptr, &raw, @sizeOf(c.MDBX_gc_info_t), null, null);
    if (rc != c.MDBX_NOTFOUND) try throw(rc);
    return .{
        .pages_total = raw.pages_total,
        .pages_backed = raw.pages_backed,
        .pages_allocated = raw.pages_allocated,
        .pages_gc = raw.pages_gc,
        .gc_reclaimable_pages = raw.gc_reclaimable.pages,
        .max_reader_lag = raw.max_reader_lag,
        .max_retained_pages = raw.max_retained_pages,
    };
}
