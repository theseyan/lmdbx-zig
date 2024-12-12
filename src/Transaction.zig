const std = @import("std");
const c = @import("c.zig");
const errors = @import("errors.zig");
const Environment = @import("Environment.zig");
const Database = @import("Database.zig");
const Cursor = @import("Cursor.zig");

const throw = errors.throw;

const Transaction = @This();

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

/// Abort the transaction
pub fn abort(self: Transaction) !void {
    try throw(c.mdbx_txn_abort(self.ptr));
}

/// Commit the transaction
pub fn commit(self: Transaction) !void {
    try throw(c.mdbx_txn_commit(self.ptr));
}

/// Get a record by key
pub fn get(self: Transaction, key: []const u8) !?[]const u8 {
    const db = try Database.open(self, null, .{});
    return try db.get(key);
}

/// Set a record
pub fn set(self: Transaction, key: []const u8, value: []const u8) !void {
    const db = try Database.open(self, null, .{});
    try db.set(key, value);
}

/// Get a serialized record.
pub fn getSerialized(self: Transaction, key: []const u8, comptime ValueType: type) !?ValueType {
    const db = try Database.open(self, null, .{});
    return try db.getSerialized(key, ValueType);
}

/// Get a serialized record.
/// Allocators are required if points er involved.
pub fn getSerializedAlloc(self: Transaction, key: []const u8, comptime ValueType: type, allocator: std.mem.Allocator) !?ValueType {
    const db = try Database.open(self, null, .{});
    return try db.getSerializedAlloc(key, ValueType, allocator);
}

/// Set a record by serializing Zig structs and values
pub fn setSerialized(self: Transaction, key: []const u8, comptime ValueType: type, value: ValueType, buffer: anytype) !void {
    const db = try Database.open(self, null, .{});
    try db.setSerialized(key, ValueType, value, buffer);
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