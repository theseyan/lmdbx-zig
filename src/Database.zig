const std = @import("std");
const c = @import("c.zig");
const errors = @import("errors.zig");
const Transaction = @import("Transaction.zig");
const Cursor = @import("Cursor.zig");

const throw = errors.throw;

const Database = @This();

/// A database handle
pub const DBI = c.MDBX_dbi;

/// Database init options
/// TODO: Duplicate sorted keys
pub const Options = struct {
    reverse_key: bool = false,
    integer_key: bool = false,
    create: bool = false,
};

/// Database statistics
pub const Stat = struct {
    psize: u32,
    depth: u32,
    branch_pages: usize,
    leaf_pages: usize,
    overflow_pages: usize,
    entries: usize,
};

/// Set flags
pub const SetFlag = enum {
    Create, Update, Upsert, Append, AppendDup
};

/// Replace flags
pub const ReplaceFlag = enum {
    Upsert,
    Create,
    Update,
    Append,
    AppendDup,
    CurrentNoOverwrite,
};

txn: Transaction,
dbi: DBI,

/// Open a database within a transaction
pub fn open(txn: Transaction, name: ?[*:0]const u8, options: Options) !Database {
    var dbi: Database.DBI = 0;

    var flags: c_uint = 0;
    if (options.reverse_key) flags |= c.MDBX_REVERSEKEY;
    if (options.integer_key) flags |= c.MDBX_INTEGERKEY;
    if (options.create) flags |= c.MDBX_CREATE;

    try throw(c.mdbx_dbi_open(txn.ptr, name, flags, &dbi));

    return .{ .txn = txn, .dbi = dbi };
}

/// Get a record by key
pub fn get(self: Database, key: []const u8) !?[]const u8 {
    var k: c.MDBX_val = .{ .iov_len = key.len, .iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(key.ptr))) };
    var v: c.MDBX_val = .{ .iov_len = 0, .iov_base = null };

    switch (c.mdbx_get(self.txn.ptr, self.dbi, &k, &v)) {
        c.MDBX_NOTFOUND => return null,
        else => |rc| try throw(rc),
    }

    return @as([*]u8, @ptrCast(v.iov_base))[0..v.iov_len];
}


/// Set a record
pub fn set(self: Database, key: []const u8, value: []const u8, flag: SetFlag) !void {
    var k: c.MDBX_val = .{ .iov_len = key.len, .iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(key.ptr))) };
    var v: c.MDBX_val = .{ .iov_len = value.len, .iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(value.ptr))) };

    var flags: c_uint = 0;
    switch (flag) {
        .Upsert => {},
        .Create => flags |= c.MDBX_NOOVERWRITE,
        .Update => flags |= c.MDBX_CURRENT,
        .Append => flags |= c.MDBX_APPEND,
        .AppendDup => flags |= c.MDBX_APPENDDUP,
    }

    try throw(c.mdbx_put(self.txn.ptr, self.dbi, &k, &v, flags));
}

/// Replace a record and optionally return the previous value.
pub fn replace(self: Database, key: []const u8, new_value: ?[]const u8, old_value: ?[]const u8, flag: ReplaceFlag) !?[]const u8 {
    var k: c.MDBX_val = .{ .iov_len = key.len, .iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(key.ptr))) };
    var new_val = c.MDBX_val{ .iov_len = 0, .iov_base = null };
    var old_val = c.MDBX_val{ .iov_len = 0, .iov_base = null };

    if (new_value == null) {
        if (old_value != null) return error.INVAL;
        try self.delete(key);
        return null;
    }

    if (new_value) |v| {
        new_val.iov_len = v.len;
        new_val.iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(v.ptr)));
    }
    if (old_value) |v| {
        old_val.iov_len = v.len;
        old_val.iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(v.ptr)));
    }

    var flags: c_uint = 0;
    switch (flag) {
        .Upsert => {},
        .Create => flags |= c.MDBX_NOOVERWRITE,
        .Update => flags |= c.MDBX_CURRENT,
        .Append => flags |= c.MDBX_APPEND,
        .AppendDup => flags |= c.MDBX_APPENDDUP,
        .CurrentNoOverwrite => flags |= c.MDBX_CURRENT | c.MDBX_NOOVERWRITE,
    }

    try throw(c.mdbx_replace(self.txn.ptr, self.dbi, &k, &new_val, &old_val, flags));
    if (old_val.iov_base == null) return null;
    return @as([*]u8, @ptrCast(old_val.iov_base))[0..old_val.iov_len];
}


/// Delete a record by key
pub fn delete(self: Database, key: []const u8) !void {
    var k: c.MDBX_val = .{ .iov_len = key.len, .iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(key.ptr))) };
    try throw(c.mdbx_del(self.txn.ptr, self.dbi, &k, null));
}

/// Delete records and optionally drop the DB handle.
pub fn drop(self: Database, delete_dbi: bool) !void {
    try throw(c.mdbx_drop(self.txn.ptr, self.dbi, delete_dbi));
}

/// Get a cursor in this database
pub fn cursor(self: Database) !Cursor {
    return try Cursor.init(self);
}

/// Find entry for key or the next greater key.
pub fn getEqualOrGreat(self: Database, key: []const u8) !?Cursor.Entry {
    var k: c.MDBX_val = .{ .iov_len = key.len, .iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(key.ptr))) };
    var v: c.MDBX_val = .{ .iov_len = 0, .iov_base = null };

    switch (c.mdbx_get_equal_or_great(self.txn.ptr, self.dbi, &k, &v)) {
        c.MDBX_NOTFOUND => return null,
        else => |rc| try throw(rc),
    }

    return Cursor.Entry{
        .key = @as([*]u8, @ptrCast(k.iov_base))[0..k.iov_len],
        .value = @as([*]u8, @ptrCast(v.iov_base))[0..v.iov_len],
    };
}

/// Get statistics about database
pub fn stat(self: Database) !Stat {
    var result: c.MDBX_stat = undefined;
    try throw(c.mdbx_dbi_stat(self.txn.ptr, self.dbi, &result));

    return .{
        .psize = result.ms_psize,
        .depth = result.ms_depth,
        .branch_pages = result.ms_branch_pages,
        .leaf_pages = result.ms_leaf_pages,
        .overflow_pages = result.ms_overflow_pages,
        .entries = result.ms_entries,
    };
}

/// Rename this database.
pub fn rename(self: Database, name: [*:0]const u8) !void {
    try throw(c.mdbx_dbi_rename(self.txn.ptr, self.dbi, name));
}

/// Get or advance the sequence for this database.
pub fn sequence(self: Database, increment: u64) !u64 {
    var result: u64 = 0;
    const rc = c.mdbx_dbi_sequence(self.txn.ptr, self.dbi, &result, increment);
    if (rc == c.MDBX_RESULT_TRUE) return error.SequenceOverflow;
    try throw(rc);
    return result;
}
