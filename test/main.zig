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
