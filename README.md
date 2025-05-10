# lmdbx-zig

Zig bindings for [libMDBX](https://libmdbx.dqdkfa.ru/) (a fork of LMDB), mostly ported from [zig-lmdb](https://github.com/canvasxyz/zig-lmdb).

Built and tested with Zig version `0.14.0`.

> _libmdbx_ is an extremely fast, compact, powerful, embedded, transactional [key-value database](https://en.wikipedia.org/wiki/Key-value_database) with a specific set of properties and capabilities,
> focused on creating unique lightweight solutions.
> _libmdbx_ is superior to legendary _[LMDB](https://symas.com/lmdb/)_ in
terms of features and reliability, not inferior in performance. In
comparison to _LMDB_, _libmdbx_ make things "just work" perfectly and
out-of-the-box, not silently and catastrophically break down.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [API](#api)
  - [`Environment`](#environment)
  - [`Transaction`](#transaction)
  - [`Database`](#database)
  - [`Cursor`](#cursor)
- [Benchmarks](#benchmarks)

## Installation

```bash
# replace {VERSION} with the latest release eg: v0.1.0
zig fetch https://github.com/theseyan/lmdbx-zig/archive/refs/tags/{VERSION}.tar.gz
```

Copy the hash generated and add lmdbx-zig to `build.zig.zon`:

```zig
.{
    .dependencies = .{
        .lmdbx = .{
            .url = "https://github.com/theseyan/lmdbx-zig/archive/refs/tags/{VERSION}.tar.gz",
            .hash = "{HASH}",
        },
    },
}
```

### Targets

`lmdbx-zig` officially supports cross-compiling to the following target triples:
- `x86_64-linux-gnu`, `x86_64-macos`, `x86_64-windows-gnu`
- `aarch64-linux-gnu`, `aarch64-macos`, `aarch64-windows-gnu`

Successful compilation on other targets is not guaranteed (but might work).

## Usage

A libMDBX environment can either have multiple named databases, or a single unnamed database.

To use a single unnamed database, open a transaction and use the `txn.get`, `txn.set`, `txn.delete`, and `txn.cursor` methods directly.

```zig
const lmdbx = @import("lmdbx");

pub fn main() !void {
    const env = try lmdbx.Environment.init("path/to/db", .{});
    defer env.deinit();

    const txn = try lmdbx.Transaction.init(env, .{ .mode = .ReadWrite });
    errdefer txn.abort();

    try txn.set("aaa", "foo", .Create);
    try txn.set("bbb", "bar", .Upsert);

    try txn.commit();
}
```

To use named databases, open the environment with a non-zero `max_dbs` value. Then open each named database using `Transaction.database`, which returns a `Database` struct with `db.get`/`db.set`/`db.delete`/`db.cursor` methods. You don't have to close databases, but they're only valid during the lifetime of the transaction.

```zig
const lmdbx = @import("lmdbx");

pub fn main() !void {
    const env = try lmdbx.Environment.init("path/to/db", .{ .max_dbs = 2 });
    defer env.deinit();

    const txn = try lmdbx.Transaction.init(env, .{ .mode = .ReadWrite });
    errdefer txn.abort();

    const widgets = try txn.database("widgets", .{ .create = true });
    try widgets.set("aaa", "foo", .Create);

    const gadgets = try txn.database("gadgets", .{ .create = true });
    try gadgets.set("aaa", "bar", .Create);

    try txn.commit();
}
```

## API

### `Environment`

```zig
pub const Environment = struct {
    pub const Options = struct {
        geometry: ?DatabaseGeometry = null,
        max_dbs: u32 = 0,
        max_readers: u32 = 126,
        read_only: bool = false,
        write_map: bool = false,
        no_sticky_threads: bool = false,
        exclusive: bool = false,
        no_read_ahead: bool = false,
        no_mem_init: bool = false,
        lifo_reclaim: bool = false,
        no_meta_sync: bool = false,
        safe_nosync: bool = false,
        mode: u16 = 0o664
    };

    pub const Info = struct {
        map_size: usize,
        max_readers: u32,
        num_readers: u32,
        autosync_period: u32,
        autosync_threshold: u64,
        db_pagesize: u32,
        mode: u32,
        sys_pagesize: u32,
        unsync_volume: u64
    };

    pub const DatabaseGeometry = struct {
        lower_size: isize = -1,
        upper_size: isize = -1,
        size_now: isize = -1,
        growth_step: isize = -1,
        shrink_threshold: isize = -1,
        pagesize: isize = -1
    };

    pub fn init(path: [*:0]const u8, options: Options) !Environment
    pub fn deinit(self: Environment) !void

    pub fn transaction(self: Environment, options: Transaction.Options) !Transaction

    pub fn sync(self: Environment) !void
    pub fn stat(self: Environment) !Stat
    pub fn info(self: Environment) !Info

    pub fn setGeometry(self: Environment, options: DatabaseGeometry) !void
};
```

### `Transaction`

```zig
pub const Transaction = struct {
    pub const Mode = enum { ReadOnly, ReadWrite };

    pub const Options = struct {
        mode: Mode,
        parent: ?Transaction = null,
        txn_try: bool = false
    };

    pub fn init(env: Environment, options: Options) !Transaction
    pub fn abort(self: Transaction) !void
    pub fn commit(self: Transaction) !void

    pub fn get(self: Transaction, key: []const u8) !?[]const u8
    pub fn set(self: Transaction, key: []const u8, value: []const u8, flag: Database.SetFlag) !void
    pub fn delete(self: Transaction, key: []const u8) !void

    pub fn cursor(self: Database) !Cursor
    pub fn database(self: Transaction, name: ?[*:0]const u8, options: Database.Options) !Database
};
```

### `Database`

```zig
pub const Database = struct {
    pub const Options = struct {
        reverse_key: bool = false,
        integer_key: bool = false,
        create: bool = false,
    };

    pub const Stat = struct {
        psize: u32,
        depth: u32,
        branch_pages: usize,
        leaf_pages: usize,
        overflow_pages: usize,
        entries: usize,
    };

    pub const SetFlag = enum {
        Create, Update, Upsert, Append, AppendDup
    };

    pub fn open(txn: Transaction, name: ?[*:0]const u8, options: Options) !Database

    pub fn get(self: Database, key: []const u8) !?[]const u8
    pub fn set(self: Database, key: []const u8, value: []const u8, flag: SetFlag) !void
    pub fn delete(self: Database, key: []const u8) !void

    pub fn cursor(self: Database) !Cursor

    pub fn stat(self: Database) !Stat
};
```

### `Cursor`

```zig
pub const Cursor = struct {
    pub const Entry = struct { key: []const u8, value: []const u8 };

    pub fn init(db: Database) !Cursor
    pub fn deinit(self: Cursor) void

    pub fn getCurrentEntry(self: Cursor) !Entry
    pub fn getCurrentKey(self: Cursor) ![]const u8
    pub fn getCurrentValue(self: Cursor) ![]const u8

    pub fn set(self: Cursor, key: []const u8, value: []const u8) !void
    pub fn setCurrentValue(self: Cursor, value: []const u8) !void
    pub fn deleteCurrentKey(self: Cursor) !void

    pub fn goToNext(self: Cursor) !?[]const u8
    pub fn goToPrevious(self: Cursor) !?[]const u8
    pub fn goToLast(self: Cursor) !?[]const u8
    pub fn goToFirst(self: Cursor) !?[]const u8
    pub fn goToKey(self: Cursor, key: []const u8) !void

    pub fn seek(self: Cursor, key: []const u8) !?[]const u8
};
```

> ⚠️ Always close cursors **before** committing or aborting the transaction.

## Benchmarks

Run the benchmarks:
```
zig build bench
```
