const std = @import("std");
const lmdb = @import("lmdbx");

const allocator = std.heap.c_allocator;

pub fn main() !void {
    var stdout_buffer: [4096]u8 = undefined;
    var log = std.fs.File.stdout().writer(&stdout_buffer);

    var options = lmdb.Environment.Options{};
    var path: ?[]const u8 = null;
    var entries: u64 = 0;
    var key_size: usize = 16;
    var value_size: usize = 512;
    var batch: usize = 1000;

    var args = std.process.args();
    _ = args.skip();
    while (args.next()) |arg| {
        if (std.mem.startsWith(u8, arg, "--path=")) {
            path = arg["--path=".len..];
        } else if (std.mem.startsWith(u8, arg, "--entries=")) {
            entries = try parseU64(arg["--entries=".len..]);
        } else if (std.mem.startsWith(u8, arg, "--key-size=")) {
            key_size = try parseUsize(arg["--key-size=".len..]);
        } else if (std.mem.startsWith(u8, arg, "--value-size=")) {
            value_size = try parseUsize(arg["--value-size=".len..]);
        } else if (std.mem.startsWith(u8, arg, "--batch=")) {
            batch = try parseUsize(arg["--batch=".len..]);
        } else if (std.mem.eql(u8, arg, "--safe-nosync")) {
            options.safe_nosync = true;
        } else if (std.mem.eql(u8, arg, "--no-meta-sync")) {
            options.no_meta_sync = true;
        } else if (std.mem.eql(u8, arg, "--unsafe-nosync")) {
            options.unsafe_nosync = true;
        } else if (std.mem.startsWith(u8, arg, "--sync-period-ms=")) {
            options.sync_period_ms = try parseU32(arg["--sync-period-ms=".len..]);
        } else if (std.mem.startsWith(u8, arg, "--sync-bytes=")) {
            options.sync_bytes = try parseUsize(arg["--sync-bytes=".len..]);
        } else {
            try usage(&log.interface);
            return;
        }
    }

    if (path == null or entries == 0 or key_size == 0 or value_size == 0 or batch == 0) {
        try usage(&log.interface);
        return;
    }

    const env = try openPath(path.?, options);
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: {any}", .{e});

    const info = try env.info();
    const flags = try env.flagsInfo();
    const sync_bytes = try env.syncBytes();
    const sync_period = try env.syncPeriod();

    const total_bytes = @as(u128, entries) * @as(u128, key_size + value_size);

    try log.interface.print(
        "generate db: path={s} entries={d} key_size={d} value_size={d} batch={d}\n",
        .{ path.?, entries, key_size, value_size, batch },
    );
    try log.interface.print(
        "approx data bytes: {d}\n",
        .{@as(u64, @intCast(total_bytes))},
    );
    try log.interface.print(
        "env info: map_size={d} db_pagesize={d} sys_pagesize={d} autosync_threshold={d} autosync_period={d} unsync_volume={d} sync_bytes={d} sync_period={d} flags=0x{x} no_meta_sync={} safe_nosync={} unsafe_nosync={} write_map={} exclusive={}\n\n",
        .{
            info.map_size,
            info.db_pagesize,
            info.sys_pagesize,
            info.autosync_threshold,
            info.autosync_period,
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

    const key_buf = try allocator.alloc(u8, key_size);
    defer allocator.free(key_buf);
    const val_buf = try allocator.alloc(u8, value_size);
    defer allocator.free(val_buf);

    var i: u64 = 0;
    while (i < entries) {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch {};
        const db = try txn.database(null, .{});

        var j: usize = 0;
        while (j < batch and i < entries) : (j += 1) {
            fillFromId(key_buf, i);
            fillFromId(val_buf, i ^ 0x9e3779b97f4a7c15);
            try db.set(key_buf, val_buf, .Upsert);
            i += 1;
        }

        try txn.commit();
        if ((i % (batch * 1000)) == 0) {
            try log.interface.print("progress: {d}/{d}\n", .{ i, entries });
            try log.interface.flush();
        }
    }

    try log.interface.print("done: {d} entries\n", .{entries});
    try log.interface.flush();
}

fn openPath(path: []const u8, options: lmdb.Environment.Options) !lmdb.Environment {
    var path_buffer: [std.fs.max_path_bytes]u8 = undefined;
    if (path.len + 1 > path_buffer.len) return error.NameTooLong;
    std.mem.copyForwards(u8, path_buffer[0..path.len], path);
    path_buffer[path.len] = 0;
    return try lmdb.Environment.init(path_buffer[0..path.len :0], options);
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
        \\Usage: gen-db [options]
        \\  --path=PATH          database directory
        \\  --entries=N          number of entries (required)
        \\  --key-size=N         key size in bytes (default 16)
        \\  --value-size=N       value size in bytes (default 512)
        \\  --batch=N            writes per transaction (default 10000)
        \\  --safe-nosync        enable MDBX_SAFE_NOSYNC
        \\  --no-meta-sync       enable MDBX_NOMETASYNC
        \\  --unsafe-nosync      enable MDBX_UTTERLY_NOSYNC
        \\  --sync-period-ms=N   set autosync period in ms
        \\  --sync-bytes=N       set autosync bytes threshold
        \\
    , .{});
}

fn fillFromId(buf: []u8, id: u64) void {
    var x = id + 0x9e3779b97f4a7c15;
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
    var z = x + 0x9e3779b97f4a7c15;
    z = (z ^ (z >> 30)) *% 0xbf58476d1ce4e5b9;
    z = (z ^ (z >> 27)) *% 0x94d049bb133111eb;
    return z ^ (z >> 31);
}
