const std = @import("std");
const c = @import("c.zig");
const errors = @import("errors.zig");
const Transaction = @import("Transaction.zig");
const Database = @import("Database.zig");

const throw = errors.throw;

const Cursor = @This();

ptr: ?*c.MDBX_cursor = null,

/// A database entry
pub const Entry = struct { key: []const u8, value: []const u8 };

/// Initialize a cursor from a database
pub fn init(db: Database) !Cursor {
    var cursor = Cursor{};
    try throw(c.mdbx_cursor_open(db.txn.ptr, db.dbi, &cursor.ptr));
    return cursor;
}

/// De-initialize the cursor
pub fn deinit(self: Cursor) void {
    c.mdbx_cursor_close(self.ptr);
}

/// Get entry at current cursor position
pub fn getCurrentEntry(self: Cursor) !Entry {
    var k: c.MDBX_val = undefined;
    var v: c.MDBX_val = undefined;

    try throw(c.mdbx_cursor_get(self.ptr, &k, &v, c.MDBX_GET_CURRENT));
    return Entry{
        .key = @as([*]u8, @ptrCast(k.iov_base))[0..k.iov_len],
        .value = @as([*]u8, @ptrCast(v.iov_base))[0..v.iov_len],
    };
}

/// Get key at current cursor position
pub fn getCurrentKey(self: Cursor) ![]const u8 {
    var k: c.MDBX_val = undefined;
    try throw(c.mdbx_cursor_get(self.ptr, &k, null, c.MDBX_GET_CURRENT));
    return @as([*]u8, @ptrCast(k.iov_base))[0..k.iov_len];
}

/// Get value at current cursor position
pub fn getCurrentValue(self: Cursor) ![]const u8 {
    var v: c.MDBX_val = undefined;
    try throw(c.mdbx_cursor_get(self.ptr, null, &v, c.MDBX_GET_CURRENT));
    return @as([*]u8, @ptrCast(v.iov_base))[0..v.iov_len];
}

/// Set key and value at current cursor position
pub fn set(self: Cursor, key: []const u8, value: []const u8) !void {
    var k: c.MDBX_val = .{ .iov_len = key.len, .iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(key.ptr))) };
    var v: c.MDBX_val = .{ .iov_len = value.len, .iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(value.ptr))) };

    try throw(c.mdbx_cursor_put(self.ptr, &k, &v, 0));
}

/// Set value at current cursor position
pub fn setCurrentValue(self: Cursor, value: []const u8) !void {
    // Get key at current position first
    var k: c.MDBX_val = undefined;
    try throw(c.mdbx_cursor_get(self.ptr, &k, null, c.MDBX_GET_CURRENT));

    var v: c.MDBX_val = .{ .iov_len = value.len, .iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(value.ptr))) };
    try throw(c.mdbx_cursor_put(self.ptr, &k, &v, c.MDBX_CURRENT));
}

/// Delete record at current cursor position
pub fn deleteCurrentKey(self: Cursor) !void {
    try throw(c.mdbx_cursor_del(self.ptr, c.MDBX_CURRENT));
}

/// Go to next record
pub fn goToNext(self: Cursor) !?[]const u8 {
    var k: c.MDBX_val = undefined;

    switch (c.mdbx_cursor_get(self.ptr, &k, null, c.MDBX_NEXT)) {
        c.MDBX_NOTFOUND => return null,
        else => |rc| try throw(rc),
    }

    return @as([*]u8, @ptrCast(k.iov_base))[0..k.iov_len];
}

/// Go to previous record
pub fn goToPrevious(self: Cursor) !?[]const u8 {
    var k: c.MDBX_val = undefined;

    switch (c.mdbx_cursor_get(self.ptr, &k, null, c.MDBX_PREV)) {
        c.MDBX_NOTFOUND => return null,
        else => |rc| try throw(rc),
    }

    return @as([*]u8, @ptrCast(k.iov_base))[0..k.iov_len];
}

/// Go to last record
pub fn goToLast(self: Cursor) !?[]const u8 {
    var k: c.MDBX_val = undefined;

    switch (c.mdbx_cursor_get(self.ptr, &k, null, c.MDBX_LAST)) {
        c.MDBX_NOTFOUND => return null,
        else => |rc| try throw(rc),
    }

    return @as([*]u8, @ptrCast(k.iov_base))[0..k.iov_len];
}

/// Go to first record
pub fn goToFirst(self: Cursor) !?[]const u8 {
    var k: c.MDBX_val = undefined;

    switch (c.mdbx_cursor_get(self.ptr, &k, null, c.MDBX_FIRST)) {
        c.MDBX_NOTFOUND => return null,
        else => |rc| try throw(rc),
    }

    return @as([*]u8, @ptrCast(k.iov_base))[0..k.iov_len];
}

// Go to record with key
pub fn goToKey(self: Cursor, key: []const u8) !void {
    var k: c.MDBX_val = undefined;
    k.iov_len = key.len;
    k.iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(key.ptr)));

    try throw(c.mdbx_cursor_get(self.ptr, &k, null, c.MDBX_SET_KEY));
}

// Seek to key
pub fn seek(self: Cursor, key: []const u8) !?[]const u8 {
    var k: c.MDBX_val = undefined;
    k.iov_len = key.len;
    k.iov_base = @as([*]u8, @ptrFromInt(@intFromPtr(key.ptr)));

    switch (c.mdbx_cursor_get(self.ptr, &k, null, c.MDBX_SET_RANGE)) {
        c.MDBX_NOTFOUND => return null,
        else => |rc| try throw(rc),
    }

    return @as([*]u8, @ptrCast(k.iov_base))[0..k.iov_len];
}