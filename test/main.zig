const std = @import("std");
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const expectEqualSlices = std.testing.expectEqualSlices;

const lmdb = @import("lmdbx");
const utils = @import("utils.zig");
const compare = @import("compare.zig");

const allocator = std.testing.allocator;

var path_buffer: [std.fs.max_path_bytes]u8 = undefined;

fn open(io: std.Io, dir: std.Io.Dir, options: lmdb.Environment.Options) !lmdb.Environment {
    const path_len = try dir.realPath(io, &path_buffer);
    path_buffer[path_len] = 0;
    return try lmdb.Environment.init(path_buffer[0..path_len :0], options);
}

test "basic operations" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .max_dbs = 32 });
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try txn.set("x", "foo", .Upsert);
        try txn.set("y", "bar", .Upsert);
        try txn.set("z", "baz", .Upsert);

        try txn.commit();
    }

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try txn.delete("y");
        try txn.set("x", "FOO", .Upsert);

        try txn.commit();
    }

    {
        const txn = try env.transaction(.{ .mode = .ReadOnly });
        defer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try utils.expectEqualEntries(try txn.database(null, .{}), &.{
            .{ "x", "FOO" },
            .{ "z", "baz" },
        });
    }
}

test "replace operations" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .max_dbs = 8 });
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        var txn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});
        try txn.set("k", "v1", .Upsert);
        try txn.commit();
    }

    {
        var txn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        const db = try txn.database(null, .{});
        const old = try db.replace("k", "v2", null, .Upsert);
        try expect(old != null);
        try expectEqualSlices(u8, "v1", old.?);

        const deleted = try db.replace("k", null, null, .Upsert);
        try expect(deleted == null);

        const v = try db.get("k");
        try expect(v == null);

        try txn.commit();
    }
}

test "database rename" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .max_dbs = 32 });
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        var txn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});
        const old_name: [*:0]const u8 = "old\x00";
        const new_name: [*:0]const u8 = "new\x00";
        const db = txn.database(old_name, .{ .create = true }) catch |e| {
            std.debug.print("open dbi error: {any}\n", .{e});
            return e;
        };
        try db.rename(new_name);
        try txn.commit();
    }

    {
        const txn = try env.transaction(.{ .mode = .ReadOnly });
        defer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});
        const new_name: [*:0]const u8 = "new\x00";
        const db = try txn.database(new_name, .{});
        _ = db;
    }
}

test "estimate range, canary, and sequence" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .max_dbs = 8 });
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        var txn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});
        const db = try txn.database(null, .{});
        try db.set("a", "1", .Upsert);
        try db.set("b", "2", .Upsert);
        try db.set("c", "3", .Upsert);

        const dist = try txn.estimateRange(db, "a", null, "c", null);
        try expect(dist >= 0);

        const seq0 = try db.sequence(1);
        const seq1 = try db.sequence(1);
        try expectEqual(seq0 + 1, seq1);

        const canary = lmdb.Transaction.Canary{ .x = 1, .y = 2, .z = 3, .v = 0 };
        try txn.canaryPut(&canary);
        try txn.commit();
    }

    {
        const txn = try env.transaction(.{ .mode = .ReadOnly });
        defer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});
        const got = try txn.canaryGet();
        try expectEqual(@as(u64, 1), got.x);
        try expectEqual(@as(u64, 2), got.y);
        try expectEqual(@as(u64, 3), got.z);

        const db = try txn.database(null, .{});
        const seq = try db.sequence(0);
        try expect(seq >= 1);
    }
}

test "cursor helpers and drop" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .max_dbs = 16 });
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        var wtxn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer wtxn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});
        const db = try wtxn.database(null, .{});
        try db.set("a", "1", .Upsert);
        try db.set("c", "3", .Upsert);
        try db.set("e", "5", .Upsert);
        try wtxn.commit();
    }

    {
        var rtxn = try env.transaction(.{ .mode = .ReadOnly });
        errdefer rtxn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});
        const db = try rtxn.database(null, .{});

        const entry = try rtxn.getEqualOrGreat("b");
        try expect(entry != null);
        try expectEqualSlices(u8, "c", entry.?.key);

        var cursor = try db.cursor();
        defer cursor.deinit();

        var ctx_value: u8 = 9;
        try cursor.setUserctx(&ctx_value);
        const ctx_ptr = cursor.getUserctx();
        try expect(ctx_ptr != null);
        try expectEqual(@as(*u8, @ptrCast(ctx_ptr.?)), &ctx_value);

        _ = try cursor.goToFirst();
        try cursor.reset();

        try rtxn.releaseAllCursors(true);
        try rtxn.abort();

        var rtxn2 = try env.transaction(.{ .mode = .ReadOnly });
        errdefer rtxn2.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});
        try cursor.renew(rtxn2);
        _ = try cursor.goToFirst();
        try rtxn2.abort();
    }

    {
        var wtxn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer wtxn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});
        const name: [*:0]const u8 = "dropme\x00";
        const db = try wtxn.database(name, .{ .create = true });
        try db.drop(true);
        try wtxn.commit();
    }

    {
        const rtxn = try env.transaction(.{ .mode = .ReadOnly });
        defer rtxn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});
        const name: [*:0]const u8 = "dropme\x00";
        try std.testing.expectError(error.MDBX_NOTFOUND, rtxn.database(name, .{}));
    }
}

test "nested transactions" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    {
        const env = try open(std.testing.io, tmp.dir, .{});
        defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

        {
            var txn = try env.transaction(.{ .mode = .ReadWrite });
            errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

            try txn.set("k", "v1", .Upsert);

            var child = try txn.nested(.{ .mode = .ReadWrite });
            errdefer child.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

            try child.set("k", "v2", .Upsert);
            try child.commit();

            const val = try txn.get("k");
            try expect(val != null);
            try expectEqualSlices(u8, "v2", val.?);

            try txn.commit();
        }

        {
            const txn = try env.transaction(.{ .mode = .ReadOnly });
            defer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

            const val = try txn.get("k");
            try expect(val != null);
            try expectEqualSlices(u8, "v2", val.?);
        }
    }

    {
        const batched_env = try open(std.testing.io, tmp.dir, .{ .safe_nosync = true, .no_meta_sync = true });
        defer batched_env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

        var bio: lmdb.BatchedDB = undefined;
        try bio.init(std.testing.io, batched_env, allocator, .{ .sync_interval_ms = 1, .sync_bytes = 1 });
        defer bio.deinit();

        var outer = try bio.transaction(.{ .mode = .ReadWrite });
        errdefer outer.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        var child = try outer.nested(.{ .mode = .ReadWrite });
        errdefer child.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try child.set("kb", "vb2", .Upsert);
        try child.commit();

        const cb = struct {
            fn run(ctx: ?*anyopaque, success: bool) void {
                _ = ctx;
                _ = success;
            }
        }.run;
        try std.testing.expectError(error.NestedTransaction, child.commitAsync(cb, null));

        try outer.commit();
    }
}

test "transaction reset renew park and userctx" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        var wtxn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer wtxn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});
        try wtxn.set("k", "v", .Upsert);
        try wtxn.commit();
    }

    var ctx_value: u8 = 42;
    var rtxn = try env.transaction(.{ .mode = .ReadOnly });
    errdefer rtxn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

    try rtxn.setUserctx(&ctx_value);
    const ctx_ptr = rtxn.getUserctx();
    try expect(ctx_ptr != null);
    try expectEqual(@as(*u8, @ptrCast(ctx_ptr.?)), &ctx_value);

    const v1 = try rtxn.get("k");
    try expect(v1 != null);
    try expectEqualSlices(u8, "v", v1.?);

    try rtxn.reset();
    try rtxn.renew();

    try rtxn.park(false);
    try rtxn.unpark(true);

    const v2 = try rtxn.get("k");
    try expect(v2 != null);
    try expectEqualSlices(u8, "v", v2.?);

    try rtxn.abort();
}

test "batched io basic and concurrent" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .safe_nosync = true, .no_meta_sync = true });
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    var bio: lmdb.BatchedDB = undefined;
    try bio.init(std.testing.io, env, allocator, .{ .sync_interval_ms = 1, .sync_bytes = 1 });
    defer bio.deinit();

    {
        var txn = try bio.transaction(.{ .mode = .ReadWrite });
        try txn.set("k1", "v1", .Upsert);
        try txn.commit();
    }

    {
        const txn = try env.transaction(.{ .mode = .ReadOnly });
        defer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});
        const v = try txn.get("k1");
        try expect(v != null);
        try expectEqualSlices(u8, "v1", v.?);
    }

    var t1 = try std.Thread.spawn(.{}, struct {
        fn run(bio_ptr: *lmdb.BatchedDB, key: []const u8, value: []const u8) void {
            var txn = bio_ptr.transaction(.{ .mode = .ReadWrite }) catch @panic("batched begin failed");
            txn.set(key, value, .Upsert) catch @panic("batched set failed");
            txn.commit() catch @panic("batched commit failed");
        }
    }.run, .{ &bio, "k2", "v2" });

    var t2 = try std.Thread.spawn(.{}, struct {
        fn run(bio_ptr: *lmdb.BatchedDB, key: []const u8, value: []const u8) void {
            var txn = bio_ptr.transaction(.{ .mode = .ReadWrite }) catch @panic("batched begin failed");
            txn.set(key, value, .Upsert) catch @panic("batched set failed");
            txn.commit() catch @panic("batched commit failed");
        }
    }.run, .{ &bio, "k3", "v3" });

    t1.join();
    t2.join();

    {
        const txn = try env.transaction(.{ .mode = .ReadOnly });
        defer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});
        const v2 = try txn.get("k2");
        const v3 = try txn.get("k3");
        try expect(v2 != null);
        try expect(v3 != null);
        try expectEqualSlices(u8, "v2", v2.?);
        try expectEqualSlices(u8, "v3", v3.?);
    }
}

test "batched transaction reset and userctx" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .safe_nosync = true, .no_meta_sync = true });
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    var bio: lmdb.BatchedDB = undefined;
    try bio.init(std.testing.io, env, allocator, .{ .sync_interval_ms = 1, .sync_bytes = 1 });
    defer bio.deinit();

    {
        var wtxn = try bio.transaction(.{ .mode = .ReadWrite });
        errdefer wtxn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});
        try wtxn.set("k", "v", .Upsert);
        try wtxn.commit();
    }

    var ctx_value: u8 = 7;
    var rtxn = try bio.transaction(.{ .mode = .ReadOnly });
    errdefer rtxn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

    try rtxn.setUserctx(&ctx_value);
    const ctx_ptr = rtxn.getUserctx();
    try expect(ctx_ptr != null);
    try expectEqual(@as(*u8, @ptrCast(ctx_ptr.?)), &ctx_value);

    try rtxn.reset();
    try rtxn.renew();
    try rtxn.park(false);
    try rtxn.unpark(true);

    const v = try rtxn.get("k");
    try expect(v != null);
    try expectEqualSlices(u8, "v", v.?);

    try rtxn.abort();
}

test "batched io commit async callback" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .safe_nosync = true, .no_meta_sync = true });
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    var bio: lmdb.BatchedDB = undefined;
    try bio.init(std.testing.io, env, allocator, .{ .sync_interval_ms = 1, .sync_bytes = 1, .callback_capacity = 16 });
    defer bio.deinit();

    const Ctx = struct {
        called: std.atomic.Value(u32) = std.atomic.Value(u32).init(0),
    };
    var ctx = Ctx{};

    const cb = struct {
        fn run(ptr: ?*anyopaque, success: bool) void {
            const c = @as(*Ctx, @ptrCast(@alignCast(ptr.?)));
            std.debug.assert(success);
            _ = c.called.fetchAdd(1, .acq_rel);
        }
    }.run;

    {
        var txn = try bio.transaction(.{ .mode = .ReadWrite });
        try txn.set("ka", "va", .Upsert);
        try txn.commitAsync(cb, &ctx);
    }
    {
        var txn = try bio.transaction(.{ .mode = .ReadWrite });
        try txn.set("kb", "vb", .Upsert);
        try txn.commitAsync(cb, &ctx);
    }

    // Wait for callbacks to fire (sync thread).
    var spins: u32 = 0;
    while (ctx.called.load(.acquire) < 2 and spins < 1000) : (spins += 1) {
        std.testing.io.sleep(.fromNanoseconds(1_000_000), .awake) catch {};
    }

    try expectEqual(@as(u32, 2), ctx.called.load(.acquire));

    const txn = try env.transaction(.{ .mode = .ReadOnly });
    defer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});
    const va = try txn.get("ka");
    const vb = try txn.get("kb");
    try expectEqualSlices(u8, "va", va.?);
    try expectEqualSlices(u8, "vb", vb.?);
}

test "batched io async callback respects failed seq" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .safe_nosync = true, .no_meta_sync = true });
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    var bio: lmdb.BatchedDB = undefined;
    try bio.init(std.testing.io, env, allocator, .{ .sync_interval_ms = 200, .sync_bytes = 1, .callback_capacity = 8 });
    defer bio.deinit();

    const Ctx = struct {
        called: std.atomic.Value(u32) = std.atomic.Value(u32).init(0),
        success: std.atomic.Value(bool) = std.atomic.Value(bool).init(true),
    };
    var ctx = Ctx{};

    const cb = struct {
        fn run(ptr: ?*anyopaque, success: bool) void {
            const c = @as(*Ctx, @ptrCast(@alignCast(ptr.?)));
            c.success.store(success, .release);
            _ = c.called.fetchAdd(1, .acq_rel);
        }
    }.run;

    {
        var txn = try bio.transaction(.{ .mode = .ReadWrite });
        try txn.set("kf", "vf", .Upsert);
        try txn.commitAsync(cb, &ctx);
    }

    const seq = bio.issued_seq.load(.acquire);
    bio.failed_seq.store(seq, .release);

    var spins: u32 = 0;
    while (ctx.called.load(.acquire) < 1 and spins < 2000) : (spins += 1) {
        std.testing.io.sleep(.fromNanoseconds(1_000_000), .awake) catch {};
    }

    try expectEqual(@as(u32, 1), ctx.called.load(.acquire));
    try expectEqual(false, ctx.success.load(.acquire));
}

test "multiple named databases" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .max_dbs = 2 });
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        const db = try txn.database("a", .{ .create = true });
        try db.set("x", "foo", .Upsert);

        try txn.commit();
    }

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        const db = try txn.database("b", .{ .create = true });
        try db.set("x", "bar", .Upsert);

        try txn.commit();
    }

    {
        const txn = try env.transaction(.{ .mode = .ReadOnly });
        defer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        const db = try txn.database("a", .{});
        try utils.expectEqualKeys(try db.get("x"), "foo");
    }

    {
        const txn = try env.transaction(.{ .mode = .ReadOnly });
        defer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        const db = try txn.database("b", .{});
        try utils.expectEqualKeys(try db.get("x"), "bar");
    }
}

test "compareEntries" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    try tmp.dir.createDir(std.testing.io, "a", .default_dir);
    try tmp.dir.createDir(std.testing.io, "b", .default_dir);

    var dir_a = try tmp.dir.openDir(std.testing.io, "a", .{});
    defer dir_a.close(std.testing.io);

    const env_a = try open(std.testing.io, dir_a, .{});
    defer env_a.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        const txn = try env_a.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try txn.set("x", "foo", .Upsert);
        try txn.set("y", "bar", .Upsert);
        try txn.set("z", "baz", .Upsert);

        try txn.commit();
    }

    var dir_b = try tmp.dir.openDir(std.testing.io, "b", .{});
    defer dir_b.close(std.testing.io);

    const env_b = try open(std.testing.io, dir_b, .{});
    defer env_b.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        const txn = try env_b.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try txn.set("y", "bar", .Upsert);
        try txn.set("z", "qux", .Upsert);
        try txn.commit();
    }

    try expectEqual(try compare.compareEnvironments(env_a, env_b, null, .{}), 2);
    try expectEqual(try compare.compareEnvironments(env_b, env_a, null, .{}), 2);

    {
        const txn = try env_b.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try txn.set("x", "foo", .Upsert);
        try txn.set("z", "baz", .Upsert);
        try txn.commit();
    }

    try expectEqual(try compare.compareEnvironments(env_a, env_b, null, .{}), 0);
    try expectEqual(try compare.compareEnvironments(env_b, env_a, null, .{}), 0);
}

test "set empty value" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    const txn = try env.transaction(.{ .mode = .ReadWrite });
    defer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

    try txn.set("a", "", .Upsert);

    if (try txn.get("a")) |value| {
        try expect(value.len == 0);
    } else {
        return error.KeyNotFound;
    }
}

// test "Environment.stat" {
//     var tmp = std.testing.tmpDir(.{});
//     defer tmp.cleanup();

//     const env = try open(std.testing.io, tmp.dir, .{});
//     defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

//     {
//         const txn = try env.transaction(.{ .mode = .ReadWrite });
//         errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

//         try txn.set("a", "foo");
//         try txn.set("b", "bar");
//         try txn.set("c", "baz");
//         try txn.set("a", "aaa");
//         try txn.commit();
//     }

//     {
//         const stat = try env.stat();
//         try expectEqual(@as(usize, 3), stat.entries);
//     }

//     {
//         const txn = try env.transaction(.{ .mode = .ReadWrite });
//         errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

//         try txn.delete("c");
//         try txn.commit();
//     }

//     {
//         const stat = try env.stat();
//         try expectEqual(@as(usize, 2), stat.entries);
//     }
// }

test "Cursor.deleteCurrentKey()" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        defer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try txn.set("a", "foo", .Upsert);
        try txn.set("b", "bar", .Upsert);
        try txn.set("c", "baz", .Upsert);
        try txn.set("d", "qux", .Upsert);

        {
            const cursor = try txn.cursor();
            defer cursor.deinit();

            try cursor.goToKey("c");
            try expectEqualSlices(u8, try cursor.getCurrentValue(), "baz");
            try cursor.deleteCurrentKey();
            try expectEqualSlices(u8, try cursor.getCurrentKey(), "d");
            try utils.expectEqualKeys(try cursor.goToPrevious(), "b");
        }

        try utils.expectEqualEntries(try txn.database(null, .{}), &.{
            .{ "a", "foo" },
            .{ "b", "bar" },
            .{ "d", "qux" },
        });
    }
}

test "Cursor.seek" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        defer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try txn.set("a", "foo", .Upsert);
        try txn.set("aa", "bar", .Upsert);
        try txn.set("ab", "baz", .Upsert);
        try txn.set("abb", "qux", .Upsert);

        const cursor = try txn.cursor();
        defer cursor.deinit();

        try utils.expectEqualKeys(try cursor.seek("aba"), "abb");
        try expectEqual(try cursor.seek("b"), null);
    }
}

test "parent transactions" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    const parent_txn = try env.transaction(.{ .mode = .ReadWrite });
    defer parent_txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

    try parent_txn.set("a", "foo", .Upsert);
    try parent_txn.set("b", "bar", .Upsert);
    try parent_txn.set("c", "baz", .Upsert);

    {
        const child_txn = try env.transaction(.{ .mode = .ReadWrite, .parent = parent_txn });
        errdefer child_txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try child_txn.delete("c");
        try child_txn.commit();
    }

    try expectEqual(@as(?[]const u8, null), try parent_txn.get("c"));

    {
        const child_txn = try env.transaction(.{ .mode = .ReadWrite, .parent = parent_txn });
        defer child_txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try child_txn.set("c", "baz", .Upsert);
    }

    try expectEqual(@as(?[]const u8, null), try parent_txn.get("c"));
}

// test "resize map" {
//     var tmp = std.testing.tmpDir(.{});
//     defer tmp.cleanup();

//     var map_size: usize = 64 * 4096;

//     const env = try open(std.testing.io, tmp.dir, .{ .map_size = map_size });
//     defer env.deinit();

//     var i: u32 = 0;
//     while (i < 10000) : (i += 1) {
//         setEntry(env, i) catch |err| {
//             if (err == lmdb.Error.MDB_MAP_FULL) {
//                 map_size = 2 * map_size;
//                 try env.resize(map_size);
//                 try setEntry(env, i);
//             } else {
//                 return err;
//             }
//         };
//     }

//     const stat = try env.stat();
//     try expectEqual(@as(usize, 10000), stat.entries);
// }

fn setEntry(env: lmdb.Environment, i: u32) !void {
    var key: [4]u8 = undefined;
    var value: [32]u8 = undefined;

    const txn = try env.transaction(.{ .mode = .ReadWrite });
    std.mem.writeInt(u32, &key, i, .big);
    std.crypto.hash.Blake3.hash(&key, &value, .{});
    try txn.set(&key, &value, .Upsert);

    try txn.commit();
}

// -----------------------------------------------------------------------------
// New-API tests (Environment, Transaction, Database, Cursor extensions).
// -----------------------------------------------------------------------------

test "environment: path/maxKeySize/maxValSize/maxDbs/maxReaders" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .max_dbs = 7, .max_readers = 17 });
    defer env.deinit() catch unreachable;

    const p = try env.path();
    try expect(p.len > 0);

    try expect(try env.maxKeySize(.{}) > 0);
    try expect(try env.maxValSize(.{}) > 0);
    try expect(try env.maxKeySize(.{ .dup_sort = true }) > 0);

    try expectEqual(@as(u32, 7), try env.maxDbs());
    try expect(try env.maxReaders() >= 17);

    const fd = try env.fd();
    try expect(fd > 0);
}

test "environment: info exposes geometry, pgop_stat and dxb_fsize" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .max_dbs = 4 });
    defer env.deinit() catch unreachable;

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        try txn.set("a", "alpha", .Upsert);
        try txn.commit();
    }
    _ = try env.sync(true, false);

    const i = try env.info();
    try expect(i.geo.upper >= i.geo.current and i.geo.current >= i.geo.lower);
    try expect(i.db_pagesize > 0);
    try expect(i.sys_pagesize > 0);
    try expect(i.dxb_fsize > 0);
    try expect(i.pgop_stat.newly > 0 or i.pgop_stat.wops > 0);
}

test "environment: readerCheck and readerList" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch unreachable;

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        try txn.set("k", "v", .Upsert);
        try txn.commit();
    }

    const rtxn = try env.transaction(.{ .mode = .ReadOnly });
    defer rtxn.abort() catch unreachable;

    try expectEqual(@as(u32, 0), try env.readerCheck());

    const readers = try env.readerList(allocator);
    defer allocator.free(readers);
    try expect(readers.len >= 1);
    try expect(readers[0].pid > 0);
}

test "transaction: info, id, getFlags, breakTxn" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch unreachable;

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        try txn.set("seed", "value", .Upsert);
        try txn.commit();
    }

    {
        const txn = try env.transaction(.{ .mode = .ReadOnly });
        defer txn.abort() catch unreachable;

        const f = txn.getFlags();
        try expect(f.read_only);
        try expect(!f.dirty);
        try expect(!f.finished);

        try expect(txn.id() > 0);

        const i = try txn.info(true);
        try expect(i.txn_id > 0);
        try expectEqual(@as(u64, 0), i.space_dirty);
        try expect(i.space_limit_hard >= i.space_limit_soft);
    }

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        try txn.set("x", "y", .Upsert);
        try txn.breakTxn();
        const flags_after = txn.getFlags();
        try expect(flags_after.err);
        txn.abort() catch {};
    }
}

test "transaction: commitWithLatency returns sane figures" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch unreachable;

    const txn = try env.transaction(.{ .mode = .ReadWrite });
    try txn.set("key", "val", .Upsert);

    const lat = try txn.commitWithLatency();
    try expect(lat.whole >= lat.write);
}

test "database: flagsState and dupSortDepthMask" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .max_dbs = 4 });
    defer env.deinit() catch unreachable;

    const txn = try env.transaction(.{ .mode = .ReadWrite });
    errdefer txn.abort() catch unreachable;

    const db = try txn.database("dups", .{ .create = true, .dup_sort = true });

    const fs = try db.flagsState();
    try expect(fs.options.dup_sort);
    try expect(fs.state.fresh);
    try expect(fs.state.created);

    try db.set("k", "v1", .Upsert);
    try db.set("k", "v2", .Upsert);
    try db.set("k", "v3", .Upsert);

    const mask = try db.dupSortDepthMask();
    try expect(mask != 0);

    try txn.commit();
}

test "cursor: count for dupsort, dup positioning and nextNoDup" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .max_dbs = 4 });
    defer env.deinit() catch unreachable;

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        const db = try txn.database("d", .{ .create = true, .dup_sort = true });

        try db.set("k1", "a", .Upsert);
        try db.set("k1", "b", .Upsert);
        try db.set("k1", "c", .Upsert);
        try db.set("k2", "x", .Upsert);
        try db.set("k2", "y", .Upsert);

        try txn.commit();
    }

    const txn = try env.transaction(.{ .mode = .ReadOnly });
    defer txn.abort() catch unreachable;

    const db = try txn.database("d", .{ .dup_sort = true });
    const cur = try db.cursor();
    defer cur.deinit();

    _ = try cur.goToFirst();
    try expectEqual(@as(usize, 3), try cur.count());

    const first_dup = (try cur.firstDup()).?;
    try expectEqualSlices(u8, "a", first_dup.value);
    const last_dup = (try cur.lastDup()).?;
    try expectEqualSlices(u8, "c", last_dup.value);

    _ = try cur.firstDup();
    const next = (try cur.nextDup()).?;
    try expectEqualSlices(u8, "b", next.value);

    const skipped = (try cur.nextNoDup()).?;
    try expectEqualSlices(u8, "k2", skipped.key);
    try expectEqual(@as(usize, 2), try cur.count());
}

test "cursor: seekLowerBound exact and approximate" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch unreachable;

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        try txn.set("alpha", "1", .Upsert);
        try txn.set("delta", "2", .Upsert);
        try txn.set("kappa", "3", .Upsert);
        try txn.commit();
    }

    const txn = try env.transaction(.{ .mode = .ReadOnly });
    defer txn.abort() catch unreachable;

    const cur = try txn.cursor();
    defer cur.deinit();

    const exact = (try cur.seekLowerBound("delta")).?;
    try expect(exact.exact);
    try expectEqualSlices(u8, "delta", exact.entry.key);
    try expectEqualSlices(u8, "2", exact.entry.value);

    const approx = (try cur.seekLowerBound("c")).?;
    try expect(!approx.exact);
    try expectEqualSlices(u8, "delta", approx.entry.key);

    try expect((try cur.seekLowerBound("z")) == null);

    const upper = (try cur.seekUpperBound("delta")).?;
    try expectEqualSlices(u8, "kappa", upper.entry.key);
}

test "cursor: dbi handle is exposed" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch unreachable;

    const txn = try env.transaction(.{ .mode = .ReadWrite });
    defer txn.abort() catch unreachable;

    const db = try txn.database(null, .{});
    const cur = try db.cursor();
    defer cur.deinit();

    try expectEqual(db.dbi, cur.dbi());
}

test "environment: static helpers" {
    try expect(lmdb.Environment.defaultPagesize() > 0);

    const ram = try lmdb.Environment.sysRamInfo();
    try expect(ram.page_size > 0);
    try expect(ram.total_pages > 0);

    const db_lim = lmdb.Environment.dbSizeLimits(0);
    try expect(db_lim.max > db_lim.min);

    const key_lim = lmdb.Environment.keySizeLimits(0, .{});
    try expect(key_lim.max > 0);

    const val_lim = lmdb.Environment.valSizeLimits(0, .{ .dup_sort = true });
    try expect(val_lim.max > 0);

    try expect(lmdb.Environment.txnSizeMax(0) > 0);

    const msg = lmdb.Environment.errorString(lmdb.c.MDBX_NOTFOUND);
    try expect(msg.len > 0);
}

test "environment: setOption / getOption round-trips" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .max_dbs = 4 });
    defer env.deinit() catch unreachable;

    try env.setOption(.rp_augment_limit, 999);
    try expectEqual(@as(u64, 999), try env.getOption(.rp_augment_limit));
}

test "environment: pairSize4PageMax / valSize4PageMax" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch unreachable;

    try expect(try env.pairSize4PageMax(.{}) > 0);
    try expect(try env.valSize4PageMax(.{ .dup_sort = true }) > 0);
}

test "environment: deletePath removes files" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    {
        const env = try open(std.testing.io, tmp.dir, .{});
        try env.deinit();
    }

    const path_len = try tmp.dir.realPath(std.testing.io, &path_buffer);
    path_buffer[path_len] = 0;
    const found = try lmdb.Environment.deletePath(path_buffer[0..path_len :0], .just_delete);
    try expect(found);
}

test "database: getEx returns dup count" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .max_dbs = 4 });
    defer env.deinit() catch unreachable;

    const txn = try env.transaction(.{ .mode = .ReadWrite });
    errdefer txn.abort() catch unreachable;

    const db = try txn.database("dups", .{ .create = true, .dup_sort = true });
    try db.set("k", "a", .Upsert);
    try db.set("k", "b", .Upsert);
    try db.set("k", "c", .Upsert);

    const r = (try db.getEx("k")).?;
    try expectEqual(@as(usize, 3), r.count);

    try expect(try db.getEx("missing") == null);
    try txn.commit();
}

test "cursor: put with flag, del with flag, position queries" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{ .max_dbs = 4 });
    defer env.deinit() catch unreachable;

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        const db = try txn.database("d", .{ .create = true, .dup_sort = true });
        const cur = try db.cursor();
        defer cur.deinit();

        try cur.put("k", "a", .Upsert);
        try cur.put("k", "b", .Upsert);
        try cur.put("k", "c", .Upsert);
        try cur.put("z", "only", .Upsert);

        _ = try cur.goToFirst();
        try expect(cur.onFirst());
        try expect(cur.onFirstDup());
        try expect(!cur.onLast());

        _ = try cur.lastDup();
        try expect(cur.onLastDup());

        _ = try cur.goToLast();
        try expect(cur.onLast());

        _ = try cur.goToFirst();
        try cur.del(.AllDups);

        try txn.commit();
    }

    {
        const txn = try env.transaction(.{ .mode = .ReadOnly });
        defer txn.abort() catch unreachable;
        const db = try txn.database("d", .{ .dup_sort = true });
        try expect(try db.get("k") == null);
        try expect(try db.get("z") != null);
    }
}

test "cursor: estimate distance and range delete" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch unreachable;

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        var i: u8 = 0;
        while (i < 10) : (i += 1) {
            const k = [_]u8{ 'k', '0' + i };
            try txn.set(&k, "v", .Upsert);
        }
        try txn.commit();
    }

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        const begin = try txn.cursor();
        defer begin.deinit();
        const end = try txn.cursor();
        defer end.deinit();

        _ = try begin.seek("k2");
        _ = try end.seek("k7");

        const dist = try begin.estimateDistance(end);
        try expect(@abs(dist) >= 4 and @abs(dist) <= 6);

        const removed = try begin.deleteRange(end, false);
        try expect(removed == 5);

        try txn.commit();
    }
}

test "cursor: create + bind round-trip" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch unreachable;

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        try txn.set("hello", "world", .Upsert);
        try txn.commit();
    }

    const txn = try env.transaction(.{ .mode = .ReadOnly });
    defer txn.abort() catch unreachable;

    const cur = try lmdb.Cursor.create(null);
    defer cur.deinit();
    const db = try txn.database(null, .{});
    try cur.bind(db);

    const k = (try cur.goToFirst()).?;
    try expectEqualSlices(u8, "hello", k);
}

test "transaction: straggler returns 0..100" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch unreachable;

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        try txn.set("k", "v", .Upsert);
        try txn.commit();
    }

    const txn = try env.transaction(.{ .mode = .ReadOnly });
    defer txn.abort() catch unreachable;

    const pct = try txn.straggler();
    try expect(pct <= 100);
}

test "environment: defrag returns a result struct" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch unreachable;

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        var i: u32 = 0;
        while (i < 64) : (i += 1) {
            var kbuf: [8]u8 = undefined;
            const k = std.fmt.bufPrint(&kbuf, "k{d}", .{i}) catch unreachable;
            try txn.set(k, "v", .Upsert);
        }
        try txn.commit();
    }

    const result = try env.defrag(.{ .time_limit_ms = 100 });
    try expect(result.cycles >= 0);
}

test "transaction: gcInfo returns sane fields" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch unreachable;

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        try txn.set("k", "v", .Upsert);
        try txn.commit();
    }

    const txn = try env.transaction(.{ .mode = .ReadOnly });
    defer txn.abort() catch unreachable;

    const info = try txn.gcInfo();
    try expect(info.pages_total >= info.pages_gc);
}

test "cursor: scan visits all entries until predicate stops" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch unreachable;

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        try txn.set("a", "1", .Upsert);
        try txn.set("b", "2", .Upsert);
        try txn.set("c", "3", .Upsert);
        try txn.commit();
    }

    const txn = try env.transaction(.{ .mode = .ReadOnly });
    defer txn.abort() catch unreachable;

    const cur = try lmdb.Cursor.create(null);
    defer cur.deinit();
    try cur.bind(try txn.database(null, .{}));

    const Counter = struct { n: u32 = 0 };
    const pred = struct {
        fn p(ctx: Counter, _: []const u8, _: []const u8) lmdb.Cursor.PredicateResult {
            _ = ctx;
            return .continue_;
        }
    }.p;
    var ctr = Counter{};
    const stopped = try cur.scan(Counter, pred, &ctr, .first, .next);
    try expect(!stopped);

    const stop_pred = struct {
        fn p(_: Counter, key: []const u8, _: []const u8) lmdb.Cursor.PredicateResult {
            return if (std.mem.eql(u8, key, "b")) .stop else .continue_;
        }
    }.p;
    var ctr2 = Counter{};
    const stopped2 = try cur.scan(Counter, stop_pred, &ctr2, .first, .next);
    try expect(stopped2);
}

test "database: cacheGet returns the value" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(std.testing.io, tmp.dir, .{});
    defer env.deinit() catch unreachable;

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        try txn.set("hello", "world", .Upsert);
        try txn.commit();
    }

    const txn = try env.transaction(.{ .mode = .ReadOnly });
    defer txn.abort() catch unreachable;

    const db = try txn.database(null, .{});
    var entry: lmdb.Database.CacheEntry = .{};
    const r = db.cacheGet("hello", &entry);
    try expect(r.status != .err);
    try expect(r.value != null);
    try expectEqualSlices(u8, "world", r.value.?);
}
