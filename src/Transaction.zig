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
