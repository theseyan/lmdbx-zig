const std = @import("std");
const lmdb = @import("lmdbx");
const tempdir = @import("tempdir.zig");
const allocator = std.heap.c_allocator;

const ns_per_s: u64 = 1_000_000_000;

fn monotonicNs(io: std.Io) i128 {
    return @intCast(std.Io.Clock.awake.now(io).nanoseconds);
}

const BenchKind = enum { Read, Write };

const BenchSpec = struct {
    name: []const u8,
    kind: BenchKind,
    batch: usize,
};

const BenchResult = struct {
    ops: u64,
    completed_ops: u64,
    avg_commit_ns: u64,
    max_commit_ns: u64,
};

const LatencyStats = struct {
    count: std.atomic.Value(u64) = std.atomic.Value(u64).init(0),
    sum_ns: std.atomic.Value(u64) = std.atomic.Value(u64).init(0),
    max_ns: std.atomic.Value(u64) = std.atomic.Value(u64).init(0),
};

const LatencyQueue = struct {
    buf: []u64,
    head: std.atomic.Value(u64) = std.atomic.Value(u64).init(0),
    tail: std.atomic.Value(u64) = std.atomic.Value(u64).init(0),

    fn init(alloc: std.mem.Allocator, cap: usize) !LatencyQueue {
        return .{ .buf = try alloc.alloc(u64, cap) };
    }

    fn deinit(self: *LatencyQueue, alloc: std.mem.Allocator) void {
        alloc.free(self.buf);
    }

    fn tryPush(self: *LatencyQueue, value: u64) bool {
        const cap = self.buf.len;
        const head = self.head.load(.acquire);
        const tail = self.tail.load(.acquire);
        if (tail - head >= cap) return false;
        const idx = @as(usize, @intCast(tail % cap));
        self.buf[idx] = value;
        self.tail.store(tail + 1, .release);
        return true;
    }

    fn tryPop(self: *LatencyQueue) ?u64 {
        const head = self.head.load(.acquire);
        const tail = self.tail.load(.acquire);
        if (head == tail) return null;
        const idx = @as(usize, @intCast(head % self.buf.len));
        const value = self.buf[idx];
        self.head.store(head + 1, .release);
        return value;
    }
};

const CallbackCtx = struct {
    completed: *std.atomic.Value(u64),
    batch: u64,
    latency: *LatencyStats,
    queue: *LatencyQueue,
    io: std.Io = undefined,
};

const Precomputed = struct {
    keys: []u8,
    values: []u8,
    count: usize,
    key_size: usize,
    value_size: usize,
};

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    var stdout_buffer: [4096]u8 = undefined;
    var log = std.Io.File.stdout().writer(io, &stdout_buffer);

    var options = lmdb.Environment.Options{
        .exclusive = true
    };
    var threads: usize = 4;
    var duration_s: u64 = 10;
    var keyspace: u64 = 1_000_000;
    var key_size: usize = 16;
    var value_size: usize = 512;
    var db_path: ?[]const u8 = null;
    var use_batched: bool = false;

    var args = init.minimal.args.iterate();
    _ = args.skip(); // program name
    while (args.next()) |arg| {
        if (std.mem.eql(u8, arg, "--safe-nosync")) {
            options.safe_nosync = true;
        } else if (std.mem.eql(u8, arg, "--no-meta-sync")) {
            options.no_meta_sync = true;
        } else if (std.mem.eql(u8, arg, "--unsafe-nosync")) {
            options.unsafe_nosync = true;
        } else if (std.mem.startsWith(u8, arg, "--sync-period-ms=")) {
            options.sync_period_ms = try parseU32(arg["--sync-period-ms=".len..]);
        } else if (std.mem.startsWith(u8, arg, "--sync-bytes=")) {
            options.sync_bytes = try parseUsize(arg["--sync-bytes=".len..]);
        } else if (std.mem.startsWith(u8, arg, "--threads=")) {
            threads = try parseUsize(arg["--threads=".len..]);
        } else if (std.mem.startsWith(u8, arg, "--duration=")) {
            duration_s = try parseU64(arg["--duration=".len..]);
        } else if (std.mem.startsWith(u8, arg, "--keyspace=")) {
            keyspace = try parseU64(arg["--keyspace=".len..]);
        } else if (std.mem.startsWith(u8, arg, "--key-size=")) {
            key_size = try parseUsize(arg["--key-size=".len..]);
        } else if (std.mem.startsWith(u8, arg, "--value-size=")) {
            value_size = try parseUsize(arg["--value-size=".len..]);
        } else if (std.mem.startsWith(u8, arg, "--path=")) {
            db_path = arg["--path=".len..];
        } else if (std.mem.eql(u8, arg, "--batched-db")) {
            use_batched = true;
        } else {
            try usage(&log.interface);
            return;
        }
    }

    if (use_batched) {
        // BatchedDB requires SAFE_NOSYNC; set it so env info reflects actual runtime behavior.
        options.safe_nosync = true;
    }

    if (threads == 0 or keyspace == 0 or duration_s == 0 or key_size == 0 or value_size == 0) {
        try usage(&log.interface);
        return;
    }

    var tmp: ?tempdir.TempDir = null;
    defer if (tmp) |*t| t.cleanup(io);

    const env = if (db_path) |path|
        try openPath(path, options)
    else blk: {
        tmp = try tempdir.tempDir(io, .{});
        break :blk try open(io, tmp.?.dir, options);
    };
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: {any}", .{e});

    const info = try env.info();
    const flags = try env.flagsInfo();
    const sync_bytes = try env.syncBytes();
    const sync_period = try env.syncPeriod();

    try log.interface.print(
        "multithreaded bench: threads={d} duration={d}s keyspace={d} key_size={d} value_size={d}\n",
        .{ threads, duration_s, keyspace, key_size, value_size },
    );
    try log.interface.print(
        "env info: map_size={d} db_pagesize={d} sys_pagesize={d} autosync_threshold={d} autosync_period={d} unsync_volume={d} sync_bytes={d} sync_period={d} flags=0x{x} no_meta_sync={} safe_nosync={} unsafe_nosync={} write_map={} exclusive={}\n\n",
        .{
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
    try log.interface.flush();

    if (db_path == null) {
        try initialize(env, keyspace, key_size, value_size);
    }

    const benches = [_]BenchSpec{
        .{ .name = "get random 1 entry", .kind = .Read, .batch = 1 },
        .{ .name = "get random 100 entries", .kind = .Read, .batch = 100 },
        .{ .name = "set random 1 entry", .kind = .Write, .batch = 1 },
        .{ .name = "set random 100 entries", .kind = .Write, .batch = 100 },
    };

    try log.interface.print(
        "| {s: <30} | {s: >8} | {s: >10} | {s: >10} | {s: >12} | {s: >12} |\n",
        .{ "", "threads", "ops", "ops / s", "avg commit", "max commit" },
    );
    try log.interface.print(
        "| {s:-<30} | {s:->8} | {s:->10} | {s:->10} | {s:->12} | {s:->12} |\n",
        .{ ":", ":", ":", ":", ":", ":" },
    );

    for (benches) |bench| {
        const result = try runBenchmark(io, env, use_batched, options, bench, threads, duration_s, keyspace, key_size, value_size);
        const effective_ops = if (use_batched and bench.kind == .Write) result.completed_ops else result.ops;
        const ops_per_sec = @as(f64, @floatFromInt(effective_ops)) / @as(f64, @floatFromInt(duration_s));
        try log.interface.print(
            "| {s: <30} | {d: >8} | {d: >10} | {d: >10.0} | {d: >10}us | {d: >10}us |\n",
            .{
                bench.name,
                threads,
                effective_ops,
                ops_per_sec,
                result.avg_commit_ns / 1_000,
                result.max_commit_ns / 1_000,
            },
        );
        try log.interface.flush();
    }
}

fn runBenchmark(
    io: std.Io,
    env: lmdb.Environment,
    use_batched: bool,
    options: lmdb.Environment.Options,
    bench: BenchSpec,
    threads: usize,
    duration_s: u64,
    keyspace: u64,
    key_size: usize,
    value_size: usize,
) !BenchResult {
    var batched_io_storage: lmdb.BatchedDB = undefined;
    var batched_io_ptr: ?*lmdb.BatchedDB = null;
    var latency = LatencyStats{};
    if (use_batched and bench.kind == .Write) {
        const cb_capacity = threads * 4096;
        try batched_io_storage.init(io, env, allocator, .{
            .sync_interval_ms = if (options.sync_period_ms != 0) options.sync_period_ms else 5,
            .sync_bytes = if (options.sync_bytes != 0) options.sync_bytes else 0,
            .callback_capacity = cb_capacity,
        });
        batched_io_ptr = &batched_io_storage;
    }
    defer if (batched_io_ptr) |bio| bio.deinit();
    const end_time = monotonicNs(io) + @as(i128, @intCast(duration_s * ns_per_s));
    var total_ops = std.atomic.Value(u64).init(0);
    var total_submitted = std.atomic.Value(u64).init(0);
    var total_completed = std.atomic.Value(u64).init(0);

    const queue_cap: usize = 4096;
    const queues = try allocator.alloc(LatencyQueue, threads);
    defer {
        for (queues) |*q| q.deinit(allocator);
        allocator.free(queues);
    }
    for (queues) |*q| q.* = try LatencyQueue.init(allocator, queue_cap);

    const cb_ctx = try allocator.alloc(CallbackCtx, threads);
    defer allocator.free(cb_ctx);
    for (cb_ctx, 0..) |*ctx, idx| {
        ctx.* = .{
            .completed = &total_completed,
            .batch = @as(u64, @intCast(bench.batch)),
            .latency = &latency,
            .queue = &queues[idx],
        };
    }

    const precompute_count = bench.batch * 1024;
    const precomputed = try allocator.alloc(Precomputed, threads);
    defer {
        for (precomputed) |pc| {
            allocator.free(pc.keys);
            allocator.free(pc.values);
        }
        allocator.free(precomputed);
    }

    for (precomputed, 0..) |*pc, idx| {
        pc.keys = try allocator.alloc(u8, precompute_count * key_size);
        pc.values = try allocator.alloc(u8, precompute_count * value_size);
        pc.count = precompute_count;
        pc.key_size = key_size;
        pc.value_size = value_size;
        var prng = std.Random.DefaultPrng.init(@as(u64, @intCast(idx + 1)));
        var rng = prng.random();
        var i: usize = 0;
        while (i < precompute_count) : (i += 1) {
            const key_id = rng.uintLessThan(u64, keyspace);
            const key_slice = pc.keys[i * key_size ..][0..key_size];
            const value_slice = pc.values[i * value_size ..][0..value_size];
            fillFromId(key_slice, key_id);
            fillFromId(value_slice, key_id ^ 0x9e3779b97f4a7c15);
        }
    }

    const thread_handles = try allocator.alloc(std.Thread, threads);
    defer allocator.free(thread_handles);

    for (thread_handles, 0..) |*handle, idx| {
        handle.* = try std.Thread.spawn(.{}, worker, .{
            io,
            env,
            batched_io_ptr,
            end_time,
            bench,
            precomputed[idx],
            &total_ops,
            &total_submitted,
            &cb_ctx[idx],
            &latency,
        });
    }

    for (thread_handles) |handle| handle.join();
    const ops = total_ops.load(.monotonic);
    var completed = if (use_batched and bench.kind == .Write)
        total_completed.load(.monotonic)
    else
        ops;
    if (use_batched and bench.kind == .Write) {
        const submitted = total_submitted.load(.monotonic);
        const wait_deadline = monotonicNs(io) + @as(i128, 2) * ns_per_s;
        while (completed < submitted and monotonicNs(io) < wait_deadline) {
            io.sleep(.fromNanoseconds(1_000_000), .awake) catch {};
            completed = total_completed.load(.monotonic);
        }
    }
    const count = latency.count.load(.monotonic);
    const avg_commit_ns: u64 = if (count == 0) 0 else latency.sum_ns.load(.monotonic) / count;
    return .{
        .ops = ops,
        .completed_ops = completed,
        .avg_commit_ns = avg_commit_ns,
        .max_commit_ns = latency.max_ns.load(.monotonic),
    };
}

fn worker(
    io: std.Io,
    env: lmdb.Environment,
    batched_io: ?*lmdb.BatchedDB,
    end_time: i128,
    bench: BenchSpec,
    precomputed: Precomputed,
    total_ops: *std.atomic.Value(u64),
    total_submitted: *std.atomic.Value(u64),
    cb_ctx: *CallbackCtx,
    latency: *LatencyStats,
) void {
    var local_ops: u64 = 0;
    var offset: usize = 0;
    const cap = precomputed.count;
    const batch_ops = @as(u64, @intCast(bench.batch));
    const CbWrap = struct {
        fn run(ctx: ?*anyopaque, success: bool) void {
            if (!success) {
                @panic("batched commit sync failed");
            }
            const cctx = @as(*CallbackCtx, @ptrCast(@alignCast(ctx.?)));
            _ = cctx.completed.fetchAdd(cctx.batch, .monotonic);
            const start_ns = cctx.queue.tryPop() orelse return;
            const now_ns = @as(u64, @intCast(monotonicNs(cctx.io)));
            const delta = now_ns - start_ns;
            recordLatency(cctx.latency, delta);
        }
    };
    const cb = CbWrap.run;
    cb_ctx.io = io;

    while (monotonicNs(io) < end_time) {
        var txn_opt: ?lmdb.Transaction = null;
        var batched_opt: ?lmdb.BatchedDB.Transaction = null;

        if (bench.kind == .Write and batched_io != null) {
            batched_opt = batched_io.?.transaction(.{ .mode = .ReadWrite }) catch @panic("batched txn begin failed");
        } else if (bench.kind == .Read) {
            txn_opt = env.transaction(.{ .mode = .ReadOnly }) catch @panic("txn begin failed");
        } else {
            txn_opt = env.transaction(.{ .mode = .ReadWrite }) catch @panic("txn begin failed");
        }

        if (txn_opt) |t| {
            errdefer t.abort() catch {};
        } else if (batched_opt) |bt| {
            errdefer bt.abort() catch {};
        }

        const db = if (batched_opt) |bt|
            bt.database(null, .{}) catch @panic("db open failed")
        else
            (txn_opt.?).database(null, .{}) catch @panic("db open failed");

        var i: usize = 0;
        while (i < bench.batch) : (i += 1) {
            const idx = (offset + i) % cap;
            const key = precomputed.keys[idx * precomputed.key_size ..][0..precomputed.key_size];
            switch (bench.kind) {
                .Read => {
                    const value = db.get(key) catch @panic("db get failed");
                    if (value != null and value.?.len != precomputed.value_size) {
                        @panic("unexpected value size");
                    }
                },
                .Write => {
                    const value = precomputed.values[idx * precomputed.value_size ..][0..precomputed.value_size];
                    db.set(key, value, .Upsert) catch @panic("db set failed");
                },
            }
        }

        if (batched_opt) |bt| {
            const start_ns = @as(u64, @intCast(monotonicNs(io)));
            _ = cb_ctx.queue.tryPush(start_ns);
            bt.commitAsync(cb, cb_ctx) catch |e| std.debug.panic("batched commit async failed: {any}", .{e});
            _ = total_submitted.fetchAdd(batch_ops, .monotonic);
        } else {
            const start_ns = monotonicNs(io);
            txn_opt.?.commit() catch @panic("txn commit failed");
            const end_ns = monotonicNs(io);
            const delta = @as(u64, @intCast(end_ns - start_ns));
            recordLatency(latency, delta);
        }
        local_ops += @as(u64, @intCast(bench.batch));
        offset = (offset + bench.batch) % cap;
    }

    _ = total_ops.fetchAdd(local_ops, .monotonic);
}

fn recordLatency(stats: *LatencyStats, delta_ns: u64) void {
    _ = stats.count.fetchAdd(1, .monotonic);
    _ = stats.sum_ns.fetchAdd(delta_ns, .monotonic);
    var cur_max = stats.max_ns.load(.monotonic);
    while (delta_ns > cur_max) {
        if (stats.max_ns.cmpxchgWeak(cur_max, delta_ns, .monotonic, .monotonic) == null) break;
        cur_max = stats.max_ns.load(.monotonic);
    }
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

fn initialize(env: lmdb.Environment, keyspace: u64, key_size: usize, value_size: usize) !void {
    const txn = try env.transaction(.{ .mode = .ReadWrite });
    errdefer txn.abort() catch {};
    const db = try txn.database(null, .{});

    const key_buf = try allocator.alloc(u8, key_size);
    defer allocator.free(key_buf);
    const val_buf = try allocator.alloc(u8, value_size);
    defer allocator.free(val_buf);

    var i: u64 = 0;
    while (i < keyspace) : (i += 1) {
        fillFromId(key_buf, i);
        fillFromId(val_buf, i ^ 0x9e3779b97f4a7c15);
        try db.set(key_buf, val_buf, .Upsert);
    }
    try txn.commit();
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
        \\Usage: bench-mt [options]
        \\  --threads=N          number of worker threads (default 4)
        \\  --duration=SECONDS   benchmark duration (default 10)
        \\  --keyspace=N         number of keys (default 1_000_000)
        \\  --key-size=N         key size in bytes (default 16)
        \\  --value-size=N       value size in bytes (default 512)
        \\  --path=PATH          open existing database at PATH (no init)
        \\  --batched-db         use BatchedDB for write transactions
        \\  --safe-nosync        enable MDBX_SAFE_NOSYNC
        \\  --no-meta-sync       enable MDBX_NOMETASYNC
        \\  --unsafe-nosync      enable MDBX_UTTERLY_NOSYNC
        \\  --sync-period-ms=N   set autosync period in ms
        \\  --sync-bytes=N       set autosync bytes threshold
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
