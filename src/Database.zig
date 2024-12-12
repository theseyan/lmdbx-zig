const std = @import("std");
const c = @import("c.zig");
const errors = @import("errors.zig");
const Transaction = @import("Transaction.zig");
const Cursor = @import("Cursor.zig");
const s2s = @import("s2s.zig");

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

/// Get a serialized record.
/// Allocator is required if pointers are involved.
pub fn getSerializedAlloc(self: Database, key: []const u8, comptime ValueType: type, allocator: std.mem.Allocator) !?ValueType {
    const value = try get(self, key) orelse return null;
    var stream = std.io.fixedBufferStream(value);

    // De-serialize the value
    var deserialized: ValueType = undefined;
    deserialized = try s2s.deserializeAlloc(stream.reader(), ValueType, allocator);
    
    return deserialized;
}

/// Get a serialized record.
pub fn getSerialized(self: Database, key: []const u8, comptime ValueType: type) !?ValueType {
    const value = try get(self, key) orelse return null;
    var stream = std.io.fixedBufferStream(value);

    // De-serialize the value
    var deserialized: ValueType = undefined;
    deserialized = try s2s.deserialize(stream.reader(), ValueType);
    
    return deserialized;
}

/// Set a record
pub fn set(self: Database, key: []const u8, value: []const u8) !void {
    var k: c.MDBX_val = .{ .iov_len = key.len, .iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(key.ptr))) };
    var v: c.MDBX_val = .{ .iov_len = value.len, .iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(value.ptr))) };

    try throw(c.mdbx_put(self.txn.ptr, self.dbi, &k, &v, 0));
}

/// Set a record by serializing Zig structs and values
pub fn setSerialized(self: Database, key: []const u8, comptime ValueType: type, value: ValueType, buffer: anytype) !void {
    var stream = std.io.fixedBufferStream(buffer);

    // Serialize the struct
    try s2s.serialize(stream.writer(), ValueType, value);
    const written = stream.getWritten();

    var k: c.MDBX_val = .{ .iov_len = key.len, .iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(key.ptr))) };
    var v: c.MDBX_val = .{ .iov_len = written.len, .iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(written.ptr))) };

    try throw(c.mdbx_put(self.txn.ptr, self.dbi, &k, &v, 0));
}

/// Delete a record by key
pub fn delete(self: Database, key: []const u8) !void {
    var k: c.MDBX_val = .{ .iov_len = key.len, .iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(key.ptr))) };
    try throw(c.mdbx_del(self.txn.ptr, self.dbi, &k, null));
}

/// Get a cursor in this database
pub fn cursor(self: Database) !Cursor {
    return try Cursor.init(self);
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