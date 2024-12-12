const std = @import("std");
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const expectEqualSlices = std.testing.expectEqualSlices;

const lmdb = @import("lmdbx");
const utils = @import("utils.zig");
const compare = @import("compare.zig");

var gpa = std.heap.GeneralPurposeAllocator(.{}){};
var allocator = gpa.allocator();

var path_buffer: [std.fs.MAX_PATH_BYTES]u8 = undefined;

fn open(dir: std.fs.Dir, options: lmdb.Environment.Options) !lmdb.Environment {
    const path = try dir.realpath(".", &path_buffer);
    path_buffer[path.len] = 0;
    return try lmdb.Environment.init(path_buffer[0..path.len :0], options);
}

test "basic operations" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(tmp.dir, .{});
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try txn.set("x", "foo");
        try txn.set("y", "bar");
        try txn.set("z", "baz");

        try txn.commit();
    }

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try txn.delete("y");
        try txn.set("x", "FOO");

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

test "serialized operations" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(tmp.dir, .{});
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    // A shared 4KiB buffer for serializing
    var buffer: [4096]u8 = undefined;

    const Person = struct {
        name: []const u8,
        age: u8,
        friends: []const []const u8
    };

    const me = Person{
        .name =  "Sayan J. Das",
        .age = 69,
        .friends = &[_][]const u8{
            "Friend A", "Friend B", "Friend C"
        }
    };

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try txn.setSerialized("x", Person, me, @constCast(&buffer));
        try txn.setSerialized("y", Person, me, @constCast(&buffer));
        try txn.setSerialized("z", Person, me, @constCast(&buffer));

        try txn.commit();
    }

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try txn.delete("y");
        try txn.setSerialized("x", Person, me, @constCast(&buffer));

        try txn.commit();
    }

    {
        const txn = try env.transaction(.{ .mode = .ReadOnly });
        defer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        const deserStruct: ?Person = try txn.getSerializedAlloc("x", Person, allocator);

        try std.testing.expectEqualStrings("Sayan J. Das", deserStruct.?.name);
    }
}

test "multiple named databases" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(tmp.dir, .{ .max_dbs = 2 });
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        const db = try txn.database("a", .{ .create = true });
        try db.set("x", "foo");

        try txn.commit();
    }

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        const db = try txn.database("b", .{ .create = true });
        try db.set("x", "bar");

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

    try tmp.dir.makeDir("a");
    try tmp.dir.makeDir("b");

    var dir_a = try tmp.dir.openDir("a", .{});
    defer dir_a.close();

    const env_a = try open(dir_a, .{});
    defer env_a.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        const txn = try env_a.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try txn.set("x", "foo");
        try txn.set("y", "bar");
        try txn.set("z", "baz");

        try txn.commit();
    }

    var dir_b = try tmp.dir.openDir("b", .{});
    defer dir_b.close();

    const env_b = try open(dir_b, .{});
    defer env_b.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        const txn = try env_b.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try txn.set("y", "bar");
        try txn.set("z", "qux");
        try txn.commit();
    }

    try expectEqual(try compare.compareEnvironments(env_a, env_b, null, .{}), 2);
    try expectEqual(try compare.compareEnvironments(env_b, env_a, null, .{}), 2);

    {
        const txn = try env_b.transaction(.{ .mode = .ReadWrite });
        errdefer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try txn.set("x", "foo");
        try txn.set("z", "baz");
        try txn.commit();
    }

    try expectEqual(try compare.compareEnvironments(env_a, env_b, null, .{}), 0);
    try expectEqual(try compare.compareEnvironments(env_b, env_a, null, .{}), 0);
}

test "set empty value" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(tmp.dir, .{});
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    const txn = try env.transaction(.{ .mode = .ReadWrite });
    defer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

    try txn.set("a", "");

    if (try txn.get("a")) |value| {
        try expect(value.len == 0);
    } else {
        return error.KeyNotFound;
    }
}

// test "Environment.stat" {
//     var tmp = std.testing.tmpDir(.{});
//     defer tmp.cleanup();

//     const env = try open(tmp.dir, .{});
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

    const env = try open(tmp.dir, .{});
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        defer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try txn.set("a", "foo");
        try txn.set("b", "bar");
        try txn.set("c", "baz");
        try txn.set("d", "qux");

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

    const env = try open(tmp.dir, .{});
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    {
        const txn = try env.transaction(.{ .mode = .ReadWrite });
        defer txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

        try txn.set("a", "foo");
        try txn.set("aa", "bar");
        try txn.set("ab", "baz");
        try txn.set("abb", "qux");

        const cursor = try txn.cursor();
        defer cursor.deinit();

        try utils.expectEqualKeys(try cursor.seek("aba"), "abb");
        try expectEqual(try cursor.seek("b"), null);
    }
}

test "parent transactions" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const env = try open(tmp.dir, .{});
    defer env.deinit() catch |e| std.debug.panic("Failed to deinit env: error {any}", .{e});

    const parent_txn = try env.transaction(.{ .mode = .ReadWrite });
    defer parent_txn.abort() catch |e| std.debug.panic("Failed to abort transaction: error {any}", .{e});

    try parent_txn.set("a", "foo");
    try parent_txn.set("b", "bar");
    try parent_txn.set("c", "baz");

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

        try child_txn.set("c", "baz");
    }

    try expectEqual(@as(?[]const u8, null), try parent_txn.get("c"));
}

// test "resize map" {
//     var tmp = std.testing.tmpDir(.{});
//     defer tmp.cleanup();

//     var map_size: usize = 64 * 4096;

//     const env = try open(tmp.dir, .{ .map_size = map_size });
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
    try txn.set(&key, &value);

    try txn.commit();
}