const std = @import("std");
const lmdb = @import("lmdbx");
const zbench = @import("zbench");
const tempdir = @import("tempdir.zig");

const allocator = std.heap.c_allocator;
const Args = struct {
    options: lmdb.Environment.Options = .{ .exclusive = true },
    keyspace: u64 = 1_000_000,
    key_size: usize = 16,
    value_size: usize = 512,
    db_path: ?[]const u8 = null,
    time_budget_ms: u64 = 2000,
};

pub fn main(init: std.process.Init) !void {
    var stdout_buffer: [4096]u8 = undefined;
    var log = std.Io.File.stdout().writer(init.io, &stdout_buffer);

    var args = try parseArgs(init, &log.interface);

    try runSingleSuite(init.io, &log.interface, &args);
}

fn runSingleSuite(io: std.Io, w: *std.Io.Writer, args: *const Args) !void {
    const sizes = if (args.db_path != null)
        &[_]u64{args.keyspace}
    else
        &[_]u64{1_000};

    for (sizes) |size| {
        var ctx = try SingleContext.init(io, args, size);
        defer ctx.deinit(io);

        try printEnvInfo(w, ctx.env, "single-threaded bench");
        try w.print("dataset entries={d} key_size={d} value_size={d}\n\n", .{ size, args.key_size, args.value_size });

        var bench = zbench.Benchmark.init(allocator, .{ .time_budget_ns = args.time_budget_ms * 1_000_000 });
        defer bench.deinit();

        const b1 = SingleBench{ .ctx = &ctx, .kind = .GetRandom, .batch = 1 };
        const b2 = SingleBench{ .ctx = &ctx, .kind = .GetRandom, .batch = 100 };
        const b3 = SingleBench{ .ctx = &ctx, .kind = .GetSequential, .batch = 100 };
        const b4 = SingleBench{ .ctx = &ctx, .kind = .Iterate, .batch = 100 };
        const b5 = SingleBench{ .ctx = &ctx, .kind = .SetRandom, .batch = 1 };
        const b6 = SingleBench{ .ctx = &ctx, .kind = .SetRandom, .batch = 100 };
        const b7 = SingleBench{ .ctx = &ctx, .kind = .SetSequential, .batch = 100 };
        const b8 = SingleBench{ .ctx = &ctx, .kind = .SetRandom, .batch = 1000 };
        const b9 = SingleBench{ .ctx = &ctx, .kind = .SetSequential, .batch = 1000 };
        const b10 = SingleBench{ .ctx = &ctx, .kind = .SetRandom, .batch = 50_000 };
        const b11 = SingleBench{ .ctx = &ctx, .kind = .SetSequential, .batch = 50_000 };

        try bench.addParam("get random 1 entry", &b1, .{});
        try bench.addParam("get random 100 entries", &b2, .{});
        try bench.addParam("get sequential 100 entries", &b3, .{});
        try bench.addParam("iterate 100 entries", &b4, .{});
        try bench.addParam("set random 1 entry", &b5, .{});
        try bench.addParam("set random 100 entries", &b6, .{});
        try bench.addParam("set sequential 100 entries", &b7, .{});
        try bench.addParam("set random 1k entries", &b8, .{});
        try bench.addParam("set sequential 1k entries", &b9, .{});
        try bench.addParam("set random 50k entries", &b10, .{});
        try bench.addParam("set sequential 50k entries", &b11, .{});

        try w.flush();
        try bench.run(io, std.Io.File.stdout());
        try w.writeAll("\n");
    }
}

const SingleContext = struct {
    env: lmdb.Environment,
    tmp: ?tempdir.TempDir,
    size: u64,
    key_size: usize,
    value_size: usize,
    rng: std.Random.DefaultPrng,
    key_buf: []u8,
    val_buf: []u8,
    seq_cursor: u64,

    fn init(io: std.Io, args: *const Args, size: u64) !SingleContext {
        var tmp: ?tempdir.TempDir = null;
        const env = if (args.db_path) |path|
            try openPath(path, args.options)
        else blk: {
            tmp = try tempdir.tempDir(io, .{});
            break :blk try open(io, tmp.?.dir, args.options);
        };

        if (args.db_path == null) {
            try initialize(env, size, args.key_size, args.value_size);
        }

        const key_buf = try allocator.alloc(u8, args.key_size);
        errdefer allocator.free(key_buf);
        const val_buf = try allocator.alloc(u8, args.value_size);
        errdefer allocator.free(val_buf);

        return .{
            .env = env,
            .tmp = tmp,
            .size = size,
            .key_size = args.key_size,
            .value_size = args.value_size,
            .rng = std.Random.DefaultPrng.init(0x1234_5678_9abc_def0),
            .key_buf = key_buf,
            .val_buf = val_buf,
            .seq_cursor = 0,
        };
    }

    fn deinit(self: *SingleContext, io: std.Io) void {
        self.env.deinit() catch |e| std.debug.panic("Failed to deinit env: {any}", .{e});
        allocator.free(self.key_buf);
        allocator.free(self.val_buf);
        if (self.tmp) |*t| t.cleanup(io);
    }

};

const SingleKind = enum { GetRandom, GetSequential, SetRandom, SetSequential, Iterate };

const SingleBench = struct {
    ctx: *SingleContext,
    kind: SingleKind,
    batch: usize,

    pub fn run(self: *SingleBench, bench_allocator: std.mem.Allocator) void {
        _ = bench_allocator;
        switch (self.kind) {
            .GetRandom => self.getRandom(),
            .GetSequential => self.getSequential(),
            .SetRandom => self.setRandom(),
            .SetSequential => self.setSequential(),
            .Iterate => self.iterateEntries(),
        }
    }

    fn getRandom(self: *SingleBench) void {
        const txn = self.ctx.env.transaction(.{ .mode = .ReadOnly }) catch @panic("txn begin failed");
        defer txn.abort() catch {};
        var i: usize = 0;
        while (i < self.batch) : (i += 1) {
            const id = self.ctx.rng.random().uintLessThan(u64, self.ctx.size);
            fillFromId(self.ctx.key_buf, id);
            const value = txn.get(self.ctx.key_buf) catch @panic("get failed");
            if (value == null or value.?.len != self.ctx.value_size) {
                @panic("unexpected value");
            }
        }
    }

    fn getSequential(self: *SingleBench) void {
        const txn = self.ctx.env.transaction(.{ .mode = .ReadOnly }) catch @panic("txn begin failed");
        defer txn.abort() catch {};
        var i: usize = 0;
        const start = self.ctx.seq_cursor;
        while (i < self.batch) : (i += 1) {
            const id = (start + i) % self.ctx.size;
            fillFromId(self.ctx.key_buf, id);
            const value = txn.get(self.ctx.key_buf) catch @panic("get failed");
            if (value == null or value.?.len != self.ctx.value_size) {
                @panic("unexpected value");
            }
        }
        self.ctx.seq_cursor = (start + self.batch) % self.ctx.size;
    }

    fn setRandom(self: *SingleBench) void {
        const txn = self.ctx.env.transaction(.{ .mode = .ReadWrite }) catch @panic("txn begin failed");
        errdefer txn.abort() catch {};
        var i: usize = 0;
        while (i < self.batch) : (i += 1) {
            const id = self.ctx.rng.random().uintLessThan(u64, self.ctx.size);
            fillFromId(self.ctx.key_buf, id);
            fillFromId(self.ctx.val_buf, id ^ 0x9e3779b97f4a7c15);
            txn.set(self.ctx.key_buf, self.ctx.val_buf, .Upsert) catch @panic("set failed");
        }
        txn.commit() catch @panic("commit failed");
    }

    fn setSequential(self: *SingleBench) void {
        const txn = self.ctx.env.transaction(.{ .mode = .ReadWrite }) catch @panic("txn begin failed");
        errdefer txn.abort() catch {};
        var i: usize = 0;
        const start = self.ctx.seq_cursor;
        while (i < self.batch) : (i += 1) {
            const id = (start + i) % self.ctx.size;
            fillFromId(self.ctx.key_buf, id);
            fillFromId(self.ctx.val_buf, id ^ 0x9e3779b97f4a7c15);
            txn.set(self.ctx.key_buf, self.ctx.val_buf, .Upsert) catch @panic("set failed");
        }
        self.ctx.seq_cursor = (start + self.batch) % self.ctx.size;
        txn.commit() catch @panic("commit failed");
    }

    fn iterateEntries(self: *SingleBench) void {
        const txn = self.ctx.env.transaction(.{ .mode = .ReadOnly }) catch @panic("txn begin failed");
        defer txn.abort() catch {};
        var cursor = txn.cursor() catch @panic("cursor open failed");
        defer cursor.deinit();
        var count: usize = 0;
        if (cursor.goToFirst() catch @panic("cursor first failed")) |_| {
            count += 1;
            while (count < self.batch) : (count += 1) {
                const res = cursor.goToNext() catch @panic("cursor next failed");
                if (res == null) break;
            }
        }
    }
};


fn initialize(env: lmdb.Environment, entries: u64, key_size: usize, value_size: usize) !void {
    const key_buf = try allocator.alloc(u8, key_size);
    defer allocator.free(key_buf);
    const val_buf = try allocator.alloc(u8, value_size);
    defer allocator.free(val_buf);

    const batch: u64 = 10_000;
    var i: u64 = 0;
    while (i < entries) {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch {};
        const db = try txn.database(null, .{});

        var j: u64 = 0;
        while (j < batch and i < entries) : (j += 1) {
            fillFromId(key_buf, i);
            fillFromId(val_buf, i ^ 0x9e3779b97f4a7c15);
            try db.set(key_buf, val_buf, .Upsert);
            i += 1;
        }

        try txn.commit();
    }
    _ = try env.sync(true, false);
}

fn printEnvInfo(w: *std.Io.Writer, env: lmdb.Environment, label: []const u8) !void {
    const info = try env.info();
    const flags = try env.flagsInfo();
    const sync_bytes = try env.syncBytes();
    const sync_period = try env.syncPeriod();
    try w.print(
        "{s}: map_size={d} db_pagesize={d} sys_pagesize={d} autosync_threshold={d} autosync_period={d} unsync_volume={d} sync_bytes={d} sync_period={d} flags=0x{x} no_meta_sync={} safe_nosync={} unsafe_nosync={} write_map={} exclusive={}\n",
        .{
            label,
            info.map_size,
            info.db_pagesize,
            info.sys_pagesize,
            info.autosync_threshold,
            info.autosync_period_seconds_16dot16,
            info.unsync_volume,
            sync_bytes,
            sync_period,
            flags.raw,
            flags.no_meta_sync,
            flags.safe_nosync,
            flags.unsafe_nosync,
            flags.write_map,
            flags.exclusive,
        },
    );
}

fn open(io: std.Io, dir: std.Io.Dir, options: lmdb.Environment.Options) !lmdb.Environment {
    var path_buffer: [std.fs.max_path_bytes]u8 = undefined;
    const path_len = try dir.realPath(io, &path_buffer);
    path_buffer[path_len] = 0;
    return try lmdb.Environment.init(path_buffer[0..path_len :0], options);
}

fn openPath(path: []const u8, options: lmdb.Environment.Options) !lmdb.Environment {
    var path_buffer: [std.fs.max_path_bytes]u8 = undefined;
    if (path.len + 1 > path_buffer.len) return error.NameTooLong;
    std.mem.copyForwards(u8, path_buffer[0..path.len], path);
    path_buffer[path.len] = 0;
    return try lmdb.Environment.init(path_buffer[0..path.len :0], options);
}

fn parseArgs(init: std.process.Init, w: *std.Io.Writer) !Args {
    var args = Args{};

    var it = init.minimal.args.iterate();
    _ = it.skip();
    while (it.next()) |arg| {
        if (std.mem.eql(u8, arg, "--safe-nosync")) {
            args.options.safe_nosync = true;
        } else if (std.mem.eql(u8, arg, "--no-meta-sync")) {
            args.options.no_meta_sync = true;
        } else if (std.mem.eql(u8, arg, "--unsafe-nosync")) {
            args.options.unsafe_nosync = true;
        } else if (std.mem.startsWith(u8, arg, "--sync-period-ms=")) {
            args.options.sync_period_ms = try parseU32(arg["--sync-period-ms=".len..]);
        } else if (std.mem.startsWith(u8, arg, "--sync-bytes=")) {
            args.options.sync_bytes = try parseUsize(arg["--sync-bytes=".len..]);
        } else if (std.mem.startsWith(u8, arg, "--keyspace=")) {
            args.keyspace = try parseU64(arg["--keyspace=".len..]);
        } else if (std.mem.startsWith(u8, arg, "--key-size=")) {
            args.key_size = try parseUsize(arg["--key-size=".len..]);
        } else if (std.mem.startsWith(u8, arg, "--value-size=")) {
            args.value_size = try parseUsize(arg["--value-size=".len..]);
        } else if (std.mem.startsWith(u8, arg, "--path=")) {
            args.db_path = arg["--path=".len..];
        } else if (std.mem.startsWith(u8, arg, "--time-budget-ms=")) {
            args.time_budget_ms = try parseU64(arg["--time-budget-ms=".len..]);
        } else if (std.mem.eql(u8, arg, "--help")) {
            try usage(w);
            return error.InvalidArgs;
        } else {
            try usage(w);
            return error.InvalidArgs;
        }
    }

    if (args.keyspace == 0 or args.key_size == 0 or args.value_size == 0) {
        try usage(w);
        return error.InvalidArgs;
    }

    return args;
}

fn parseUsize(bytes: []const u8) !usize {
    return std.fmt.parseUnsigned(usize, bytes, 10);
}

fn parseU32(bytes: []const u8) !u32 {
    return std.fmt.parseUnsigned(u32, bytes, 10);
}

fn parseU64(bytes: []const u8) !u64 {
    return std.fmt.parseUnsigned(u64, bytes, 10);
}

fn usage(w: *std.Io.Writer) !void {
    try w.print(
        \\Usage: bench [options]
        \\  --path=PATH                database directory (optional)
        \\  --keyspace=N               total entries (default 1_000_000)
        \\  --key-size=N               key size in bytes (default 16)
        \\  --value-size=N             value size in bytes (default 512)
        \\  --safe-nosync              enable MDBX_SAFE_NOSYNC
        \\  --no-meta-sync             enable MDBX_NOMETASYNC
        \\  --unsafe-nosync            enable MDBX_UTTERLY_NOSYNC
        \\  --sync-period-ms=N         set autosync period in ms
        \\  --sync-bytes=N             set autosync bytes threshold
        \\  --time-budget-ms=N         zBench time budget per benchmark (default 2000)
        \\  --help                     show this help
        \\
    , .{});
}

fn fillFromId(buf: []u8, id: u64) void {
    var x = id +% 0x9e3779b97f4a7c15;
    var i: usize = 0;
    while (i < buf.len) : (i += 8) {
        x = splitmix64(x);
        const chunk = buf[i..@min(i + 8, buf.len)];
        var tmp: [8]u8 = undefined;
        std.mem.writeInt(u64, &tmp, x, .big);
        std.mem.copyForwards(u8, chunk, tmp[0..chunk.len]);
    }
}

fn splitmix64(x: u64) u64 {
    var z = x +% 0x9e3779b97f4a7c15;
    z = (z ^ (z >> 30)) *% 0xbf58476d1ce4e5b9;
    z = (z ^ (z >> 27)) *% 0x94d049bb133111eb;
    return z ^ (z >> 31);
}
