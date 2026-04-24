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

/// Set application context on this cursor.
pub fn setUserctx(self: Cursor, ctx: ?*anyopaque) !void {
    try throw(c.mdbx_cursor_set_userctx(self.ptr, ctx));
}

/// Get application context from this cursor.
pub fn getUserctx(self: Cursor) ?*anyopaque {
    return c.mdbx_cursor_get_userctx(self.ptr);
}

/// Renew the cursor for a new transaction.
pub fn renew(self: Cursor, txn: Transaction) !void {
    try throw(c.mdbx_cursor_renew(txn.ptr, self.ptr));
}

/// Reset the cursor.
pub fn reset(self: Cursor) !void {
    try throw(c.mdbx_cursor_reset(self.ptr));
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

/// Result of a bounded-seek operation.
pub const SeekResult = struct {
    /// True when the cursor landed on an exact match for the requested key.
    exact: bool,
    /// Entry the cursor is now positioned on.
    entry: Entry,
};

fn seekBound(self: Cursor, key: []const u8, op: c.MDBX_cursor_op) !?SeekResult {
    var k: c.MDBX_val = .{ .iov_len = key.len, .iov_base = @ptrFromInt(@intFromPtr(key.ptr)) };
    var v: c.MDBX_val = .{ .iov_len = 0, .iov_base = null };
    const rc = c.mdbx_cursor_get(self.ptr, &k, &v, op);
    switch (rc) {
        c.MDBX_NOTFOUND => return null,
        c.MDBX_SUCCESS, c.MDBX_RESULT_TRUE => {},
        else => try throw(rc),
    }
    return .{
        .exact = rc == c.MDBX_SUCCESS,
        .entry = .{
            .key = @as([*]u8, @ptrCast(k.iov_base))[0..k.iov_len],
            .value = @as([*]u8, @ptrCast(v.iov_base))[0..v.iov_len],
        },
    };
}

/// Position on the smallest key >= `key`.
pub fn seekLowerBound(self: Cursor, key: []const u8) !?SeekResult {
    return self.seekBound(key, c.MDBX_SET_LOWERBOUND);
}

/// Position on the smallest key > `key`.
pub fn seekUpperBound(self: Cursor, key: []const u8) !?SeekResult {
    return self.seekBound(key, c.MDBX_SET_UPPERBOUND);
}

fn moveOptional(self: Cursor, op: c.MDBX_cursor_op) !?Entry {
    var k: c.MDBX_val = undefined;
    var v: c.MDBX_val = undefined;
    switch (c.mdbx_cursor_get(self.ptr, &k, &v, op)) {
        c.MDBX_NOTFOUND => return null,
        else => |rc| try throw(rc),
    }
    return .{
        .key = @as([*]u8, @ptrCast(k.iov_base))[0..k.iov_len],
        .value = @as([*]u8, @ptrCast(v.iov_base))[0..v.iov_len],
    };
}

/// Move to the next duplicate value of the current key.
pub fn nextDup(self: Cursor) !?Entry {
    return self.moveOptional(c.MDBX_NEXT_DUP);
}

/// Move to the previous duplicate value of the current key.
pub fn prevDup(self: Cursor) !?Entry {
    return self.moveOptional(c.MDBX_PREV_DUP);
}

/// Move to the first duplicate value of the current key.
pub fn firstDup(self: Cursor) !?Entry {
    return self.moveOptional(c.MDBX_FIRST_DUP);
}

/// Move to the last duplicate value of the current key.
pub fn lastDup(self: Cursor) !?Entry {
    return self.moveOptional(c.MDBX_LAST_DUP);
}

/// Move to the first item of the next key, skipping remaining duplicates.
pub fn nextNoDup(self: Cursor) !?Entry {
    return self.moveOptional(c.MDBX_NEXT_NODUP);
}

/// Move to the last item of the previous key, skipping remaining duplicates of the current key.
pub fn prevNoDup(self: Cursor) !?Entry {
    return self.moveOptional(c.MDBX_PREV_NODUP);
}

/// For DupSort databases, count duplicate values of the current key. Returns 1 otherwise.
pub fn count(self: Cursor) !usize {
    var n: usize = 0;
    try throw(c.mdbx_cursor_count(self.ptr, &n));
    return n;
}

/// Database handle this cursor is bound to.
pub fn dbi(self: Cursor) Database.DBI {
    return c.mdbx_cursor_dbi(self.ptr);
}

/// Compare positions of two cursors bound to the same database.
/// Returns negative / zero / positive. When `ignore_multival`, only the key is compared.
pub fn compare(self: Cursor, other: Cursor, ignore_multival: bool) c_int {
    return c.mdbx_cursor_compare(self.ptr, other.ptr, ignore_multival);
}

/// Copy this cursor's position into `dest`, which must be bound to the same DBI.
pub fn copyTo(self: Cursor, dest: Cursor) !void {
    try throw(c.mdbx_cursor_copy(self.ptr, dest.ptr));
}

/// Allocate an unbound cursor. Use `bind` to attach it to a transaction/DBI.
pub fn create(ctx: ?*anyopaque) !Cursor {
    const ptr = c.mdbx_cursor_create(ctx) orelse return error.NOMEM;
    return .{ .ptr = ptr };
}

/// Bind this cursor to the given database.
pub fn bind(self: Cursor, db: Database) !void {
    try throw(c.mdbx_cursor_bind(db.txn.ptr, self.ptr, db.dbi));
}

/// Unbind this cursor from its current transaction; it can be re-bound later.
pub fn unbind(self: Cursor) !void {
    try throw(c.mdbx_cursor_unbind(self.ptr));
}

/// Transaction this cursor is currently bound to, or null if unbound.
pub fn transaction(self: Cursor) ?Transaction {
    const t = c.mdbx_cursor_txn(self.ptr) orelse return null;
    return .{ .ptr = t };
}

/// Insert/update at this cursor's position.
pub fn put(self: Cursor, key: []const u8, value: []const u8, flag: Database.SetFlag) !void {
    var k: c.MDBX_val = .{ .iov_len = key.len, .iov_base = @ptrFromInt(@intFromPtr(key.ptr)) };
    var v: c.MDBX_val = .{ .iov_len = value.len, .iov_base = @ptrFromInt(@intFromPtr(value.ptr)) };
    var flags: c_uint = 0;
    switch (flag) {
        .Upsert => {},
        .Create => flags |= c.MDBX_NOOVERWRITE,
        .Update => flags |= c.MDBX_CURRENT,
        .Append => flags |= c.MDBX_APPEND,
        .AppendDup => flags |= c.MDBX_APPENDDUP,
        .NoDupData => flags |= c.MDBX_NODUPDATA,
        .MultipleWrite => flags |= c.MDBX_MULTIPLE,
    }
    try throw(c.mdbx_cursor_put(self.ptr, &k, &v, flags));
}

pub const DeleteFlag = enum {
    Current,
    /// DupSort only: delete all duplicate values for the current key.
    AllDups,
    /// DupSort only: delete current entry only if it isn't the last duplicate for its key.
    NoDupData,
};

pub fn del(self: Cursor, flag: DeleteFlag) !void {
    const flags: c_uint = switch (flag) {
        .Current => c.MDBX_CURRENT,
        .AllDups => c.MDBX_ALLDUPS,
        .NoDupData => c.MDBX_NODUPDATA,
    };
    try throw(c.mdbx_cursor_del(self.ptr, flags));
}

/// True when the cursor is past the last entry or before the first.
pub fn eof(self: Cursor) bool {
    return c.mdbx_cursor_eof(self.ptr) == c.MDBX_RESULT_TRUE;
}

pub fn onFirst(self: Cursor) bool {
    return c.mdbx_cursor_on_first(self.ptr) == c.MDBX_RESULT_TRUE;
}

pub fn onLast(self: Cursor) bool {
    return c.mdbx_cursor_on_last(self.ptr) == c.MDBX_RESULT_TRUE;
}

pub fn onFirstDup(self: Cursor) bool {
    return c.mdbx_cursor_on_first_dup(self.ptr) == c.MDBX_RESULT_TRUE;
}

pub fn onLastDup(self: Cursor) bool {
    return c.mdbx_cursor_on_last_dup(self.ptr) == c.MDBX_RESULT_TRUE;
}

/// Estimated item count between this cursor and `other`. Negative if `other` is before.
pub fn estimateDistance(self: Cursor, other: Cursor) !isize {
    var dist: c.ptrdiff_t = 0;
    try throw(c.mdbx_estimate_distance(self.ptr, other.ptr, &dist));
    return dist;
}

/// Estimate how many items would be traversed by performing `op` from the current position.
pub fn estimateMove(self: Cursor, key: ?[]const u8, value: ?[]const u8, op: c.MDBX_cursor_op) !isize {
    var k: c.MDBX_val = .{ .iov_len = 0, .iov_base = null };
    var v: c.MDBX_val = .{ .iov_len = 0, .iov_base = null };
    if (key) |kk| {
        k.iov_len = kk.len;
        k.iov_base = @ptrFromInt(@intFromPtr(kk.ptr));
    }
    if (value) |vv| {
        v.iov_len = vv.len;
        v.iov_base = @ptrFromInt(@intFromPtr(vv.ptr));
    }
    var dist: c.ptrdiff_t = 0;
    try throw(c.mdbx_estimate_move(self.ptr, &k, &v, op, &dist));
    return dist;
}

/// Delete entries from `self`'s position up to `end`'s position. Returns count deleted.
pub fn deleteRange(self: Cursor, end: Cursor, end_inclusive: bool) !u64 {
    var n: u64 = 0;
    try throw(c.mdbx_cursor_delete_range(self.ptr, end.ptr, end_inclusive, &n));
    return n;
}

/// Cursor positioning operation. See libmdbx docs for `MDBX_cursor_op`.
pub const Op = enum(c_int) {
    first = c.MDBX_FIRST,
    first_dup = c.MDBX_FIRST_DUP,
    get_both = c.MDBX_GET_BOTH,
    get_both_range = c.MDBX_GET_BOTH_RANGE,
    get_current = c.MDBX_GET_CURRENT,
    get_multiple = c.MDBX_GET_MULTIPLE,
    last = c.MDBX_LAST,
    last_dup = c.MDBX_LAST_DUP,
    next = c.MDBX_NEXT,
    next_dup = c.MDBX_NEXT_DUP,
    next_multiple = c.MDBX_NEXT_MULTIPLE,
    next_no_dup = c.MDBX_NEXT_NODUP,
    prev = c.MDBX_PREV,
    prev_dup = c.MDBX_PREV_DUP,
    prev_no_dup = c.MDBX_PREV_NODUP,
    set = c.MDBX_SET,
    set_key = c.MDBX_SET_KEY,
    set_range = c.MDBX_SET_RANGE,
    prev_multiple = c.MDBX_PREV_MULTIPLE,
    set_lower_bound = c.MDBX_SET_LOWERBOUND,
    set_upper_bound = c.MDBX_SET_UPPERBOUND,
    to_key_lesser_than = c.MDBX_TO_KEY_LESSER_THAN,
    to_key_lesser_or_equal = c.MDBX_TO_KEY_LESSER_OR_EQUAL,
    to_key_equal = c.MDBX_TO_KEY_EQUAL,
    to_key_greater_or_equal = c.MDBX_TO_KEY_GREATER_OR_EQUAL,
    to_key_greater_than = c.MDBX_TO_KEY_GREATER_THAN,
    to_exact_key_value_lesser_than = c.MDBX_TO_EXACT_KEY_VALUE_LESSER_THAN,
    to_exact_key_value_lesser_or_equal = c.MDBX_TO_EXACT_KEY_VALUE_LESSER_OR_EQUAL,
    to_exact_key_value_equal = c.MDBX_TO_EXACT_KEY_VALUE_EQUAL,
    to_exact_key_value_greater_or_equal = c.MDBX_TO_EXACT_KEY_VALUE_GREATER_OR_EQUAL,
    to_exact_key_value_greater_than = c.MDBX_TO_EXACT_KEY_VALUE_GREATER_THAN,
    to_pair_lesser_than = c.MDBX_TO_PAIR_LESSER_THAN,
    to_pair_lesser_or_equal = c.MDBX_TO_PAIR_LESSER_OR_EQUAL,
    to_pair_equal = c.MDBX_TO_PAIR_EQUAL,
    to_pair_greater_or_equal = c.MDBX_TO_PAIR_GREATER_OR_EQUAL,
    to_pair_greater_than = c.MDBX_TO_PAIR_GREATER_THAN,
};

/// Result returned by a scan predicate.
pub const PredicateResult = enum { stop, continue_, };

/// Predicate invoked for each key/value visited by `scan`/`scanFrom`.
pub fn Predicate(comptime Context: type) type {
    return *const fn (ctx: Context, key: []const u8, value: []const u8) PredicateResult;
}

fn scanThunk(comptime Context: type, comptime pred: Predicate(Context)) *const fn (
    ?*anyopaque,
    [*c]c.MDBX_val,
    [*c]c.MDBX_val,
    ?*anyopaque,
) callconv(.c) c_int {
    return &struct {
        fn cb(ctx: ?*anyopaque, k: [*c]c.MDBX_val, v: [*c]c.MDBX_val, _: ?*anyopaque) callconv(.c) c_int {
            const typed: *Context = @ptrCast(@alignCast(ctx));
            const key_slice = @as([*]u8, @ptrCast(k.*.iov_base))[0..k.*.iov_len];
            const value_slice = @as([*]u8, @ptrCast(v.*.iov_base))[0..v.*.iov_len];
            return switch (pred(typed.*, key_slice, value_slice)) {
                .stop => c.MDBX_RESULT_TRUE,
                .continue_ => c.MDBX_RESULT_FALSE,
            };
        }
    }.cb;
}

/// Iterate the database via `start_op` then repeatedly `turn_op`, calling `pred` for each entry.
/// Returns true if `pred` requested stop, false if iteration ran to the end.
pub fn scan(
    self: Cursor,
    comptime Context: type,
    comptime pred: Predicate(Context),
    ctx: *Context,
    start_op: Op,
    turn_op: Op,
) !bool {
    const cb = scanThunk(Context, pred);
    const rc = c.mdbx_cursor_scan(self.ptr, cb, ctx, @bitCast(@as(c_int, @intFromEnum(start_op))), @bitCast(@as(c_int, @intFromEnum(turn_op))), null);
    if (rc == c.MDBX_RESULT_TRUE) return true;
    if (rc == c.MDBX_NOTFOUND) return false;
    try throw(rc);
    return false;
}

/// Like `scan` but starts from the given (key,value) pair via `from_op`.
pub fn scanFrom(
    self: Cursor,
    comptime Context: type,
    comptime pred: Predicate(Context),
    ctx: *Context,
    from_op: Op,
    from_key: []const u8,
    from_value: []const u8,
    turn_op: Op,
) !bool {
    const cb = scanThunk(Context, pred);
    var k: c.MDBX_val = .{ .iov_len = from_key.len, .iov_base = @ptrFromInt(@intFromPtr(from_key.ptr)) };
    var v: c.MDBX_val = .{ .iov_len = from_value.len, .iov_base = @ptrFromInt(@intFromPtr(from_value.ptr)) };
    const rc = c.mdbx_cursor_scan_from(self.ptr, cb, ctx, @bitCast(@as(c_int, @intFromEnum(from_op))), &k, &v, @bitCast(@as(c_int, @intFromEnum(turn_op))), null);
    if (rc == c.MDBX_RESULT_TRUE) return true;
    if (rc == c.MDBX_NOTFOUND) return false;
    try throw(rc);
    return false;
}
