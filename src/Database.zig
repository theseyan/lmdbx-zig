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
pub const Options = struct {
    /// Keys are strings to be compared in reverse order (suffix to prefix).
    reverse_key: bool = false,
    /// Allow duplicate keys: multi-value tables.
    dup_sort: bool = false,
    /// Keys are binary integers in native byte order, of fixed size.
    integer_key: bool = false,
    /// With `dup_sort`, all values are the same fixed size.
    dup_fixed: bool = false,
    /// With `dup_sort` and `dup_fixed`, values are integers in native order.
    integer_dup: bool = false,
    /// With `dup_sort`, duplicate values are compared in reverse order.
    reverse_dup: bool = false,
    /// Create the database if it does not exist.
    create: bool = false,
    /// Open an existing handle even if its on-disk flags differ from the requested ones.
    accede: bool = false,

    /// Convert to the raw `MDBX_db_flags_t` bitmask.
    pub fn toFlags(self: Options) c_uint {
        var flags: c_uint = 0;
        if (self.reverse_key) flags |= c.MDBX_REVERSEKEY;
        if (self.dup_sort) flags |= c.MDBX_DUPSORT;
        if (self.integer_key) flags |= c.MDBX_INTEGERKEY;
        if (self.dup_fixed) flags |= c.MDBX_DUPFIXED;
        if (self.integer_dup) flags |= c.MDBX_INTEGERDUP;
        if (self.reverse_dup) flags |= c.MDBX_REVERSEDUP;
        if (self.create) flags |= c.MDBX_CREATE;
        if (self.accede) flags |= c.MDBX_DB_ACCEDE;
        return flags;
    }
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
    Create,
    Update,
    Upsert,
    Append,
    AppendDup,
    /// For `dup_sort` databases: don't insert if the {key,value} pair already exists.
    NoDupData,
    /// For `dup_sort` databases: write a contiguous batch of pre-sorted values for one key.
    MultipleWrite,
};

/// Replace flags
pub const ReplaceFlag = enum {
    Upsert,
    Create,
    Update,
    Append,
    AppendDup,
    CurrentNoOverwrite,
    /// For `dup_sort` databases: replace all duplicate values for the key.
    AllDups,
};

txn: Transaction,
dbi: DBI,

/// Open a database within a transaction
pub fn open(txn: Transaction, name: ?[*:0]const u8, options: Options) !Database {
    var dbi: Database.DBI = 0;
    try throw(c.mdbx_dbi_open(txn.ptr, name, options.toFlags(), &dbi));
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

/// Get a record together with the number of duplicate values for that key.
/// Always 1 for non-DupSort databases. Returns null when the key is absent.
pub const GetExResult = struct { value: []const u8, count: usize };

pub fn getEx(self: Database, key: []const u8) !?GetExResult {
    var k: c.MDBX_val = .{ .iov_len = key.len, .iov_base = @ptrFromInt(@intFromPtr(key.ptr)) };
    var v: c.MDBX_val = .{ .iov_len = 0, .iov_base = null };
    var count: usize = 0;
    switch (c.mdbx_get_ex(self.txn.ptr, self.dbi, &k, &v, &count)) {
        c.MDBX_NOTFOUND => return null,
        else => |rc| try throw(rc),
    }
    return .{
        .value = @as([*]u8, @ptrCast(v.iov_base))[0..v.iov_len],
        .count = count,
    };
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
        .NoDupData => flags |= c.MDBX_NODUPDATA,
        .MultipleWrite => flags |= c.MDBX_MULTIPLE,
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
        .AllDups => flags |= c.MDBX_ALLDUPS,
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
    try throw(c.mdbx_dbi_stat(self.txn.ptr, self.dbi, &result, @sizeOf(c.MDBX_stat)));

    return .{
        .psize = result.ms_psize,
        .depth = result.ms_depth,
        .branch_pages = result.ms_branch_pages,
        .leaf_pages = result.ms_leaf_pages,
        .overflow_pages = result.ms_overflow_pages,
        .entries = result.ms_entries,
    };
}

/// Persisted database flags + transient handle state.
pub const FlagsState = struct {
    options: Options,
    state: State,
};

/// Transient state of a database handle within a transaction.
pub const State = struct {
    /// Page records were modified by this transaction.
    dirty: bool,
    /// The DB handle requires re-validation against the latest meta page.
    stale: bool,
    /// The DB handle is freshly opened in this transaction.
    fresh: bool,
    /// The DB was created by this transaction.
    created: bool,
};

/// Get current persisted flags and transient state of this database handle.
pub fn flagsState(self: Database) !FlagsState {
    var raw_flags: c_uint = 0;
    var raw_state: c_uint = 0;
    try throw(c.mdbx_dbi_flags_ex(self.txn.ptr, self.dbi, &raw_flags, &raw_state));
    return .{
        .options = .{
            .reverse_key = (raw_flags & c.MDBX_REVERSEKEY) != 0,
            .dup_sort = (raw_flags & c.MDBX_DUPSORT) != 0,
            .integer_key = (raw_flags & c.MDBX_INTEGERKEY) != 0,
            .dup_fixed = (raw_flags & c.MDBX_DUPFIXED) != 0,
            .integer_dup = (raw_flags & c.MDBX_INTEGERDUP) != 0,
            .reverse_dup = (raw_flags & c.MDBX_REVERSEDUP) != 0,
            .create = (raw_flags & c.MDBX_CREATE) != 0,
            .accede = (raw_flags & c.MDBX_DB_ACCEDE) != 0,
        },
        .state = .{
            .dirty = (raw_state & c.MDBX_DBI_DIRTY) != 0,
            .stale = (raw_state & c.MDBX_DBI_STALE) != 0,
            .fresh = (raw_state & c.MDBX_DBI_FRESH) != 0,
            .created = (raw_state & c.MDBX_DBI_CREAT) != 0,
        },
    };
}

/// For `dup_sort` databases, return a bitmap of B-tree depths in use across all keys.
pub fn dupSortDepthMask(self: Database) !u32 {
    var mask: u32 = 0;
    try throw(c.mdbx_dbi_dupsort_depthmask(self.txn.ptr, self.dbi, &mask));
    return mask;
}

/// Close the database handle. Use sparingly: handles are normally cached for the env's lifetime.
pub fn close(self: Database) !void {
    const env_ptr = c.mdbx_txn_env(self.txn.ptr) orelse return error.INVAL;
    try throw(c.mdbx_dbi_close(env_ptr, self.dbi));
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

/// Persistent cache slot for `Database.cacheGet`. Initialize once via `.{}` and reuse.
pub const CacheEntry = struct {
    raw: c.MDBX_cache_entry_t = .{},
};

/// Outcome status of a `cacheGet` lookup. See libmdbx docs.
pub const CacheStatus = enum(c_int) {
    err = c.MDBX_CACHE_ERROR,
    behind = c.MDBX_CACHE_BEHIND,
    unable = c.MDBX_CACHE_UNABLE,
    race = c.MDBX_CACHE_RACE,
    dirty = c.MDBX_CACHE_DIRTY,
    hit = c.MDBX_CACHE_HIT,
    confirmed = c.MDBX_CACHE_CONFIRMED,
    refreshed = c.MDBX_CACHE_REFRESHED,
};

/// Result of `Database.cacheGet`.
pub const CacheResult = struct {
    /// Looked-up value, or null when the key is absent.
    value: ?[]const u8,
    /// How the result was obtained: cached, refreshed, etc.
    status: CacheStatus,
    /// Set only when `status == .err`.
    err_code: c_int,
};

/// Variant of `get` that maintains an external cache slot to skip work on hits.
/// `entry` must outlive any reuse and start zero-initialized.
pub fn cacheGet(self: Database, key: []const u8, entry: *CacheEntry) CacheResult {
    var k: c.MDBX_val = .{ .iov_len = key.len, .iov_base = @ptrFromInt(@intFromPtr(key.ptr)) };
    var v: c.MDBX_val = .{ .iov_len = 0, .iov_base = null };
    const r = c.mdbx_cache_get(self.txn.ptr, self.dbi, &k, &v, @ptrCast(&entry.raw));
    const value: ?[]const u8 = if (v.iov_base != null and v.iov_len > 0)
        @as([*]u8, @ptrCast(v.iov_base))[0..v.iov_len]
    else
        null;
    return .{
        .value = value,
        .status = @enumFromInt(r.status),
        .err_code = r.errcode,
    };
}

/// Single-threaded variant of `cacheGet` for callers that guarantee no concurrent access.
pub fn cacheGetSingleThreaded(self: Database, key: []const u8, entry: *CacheEntry) CacheResult {
    var k: c.MDBX_val = .{ .iov_len = key.len, .iov_base = @ptrFromInt(@intFromPtr(key.ptr)) };
    var v: c.MDBX_val = .{ .iov_len = 0, .iov_base = null };
    const r = c.mdbx_cache_get_SingleThreaded(self.txn.ptr, self.dbi, &k, &v, &entry.raw);
    const value: ?[]const u8 = if (v.iov_base != null and v.iov_len > 0)
        @as([*]u8, @ptrCast(v.iov_base))[0..v.iov_len]
    else
        null;
    return .{
        .value = value,
        .status = @enumFromInt(r.status),
        .err_code = r.errcode,
    };
}
