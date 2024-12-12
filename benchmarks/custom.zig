const std = @import("std");
const mdbx = @import("lmdbx");
const allocator = std.heap.c_allocator;

pub const Person = struct {
    name: []const u8,
    age: u8,
    friends: []const []const u8
};

pub fn main() !void {

    var arr = std.ArrayList([]const u8).init(allocator);
    try arr.append("Sayan");

    const me = Person{
        .name =  "Sayan J Das",
        .age = 69,
        .friends = arr.items
    };

    const env = try mdbx.Environment.init("testdb", .{});
    const txn = try env.transaction(.{});
    const db = try txn.database(null, .{});
    var buffer: [1024]u8 = undefined;
    // var slice: []u8 = &buffer;

    try db.setSerialized("sayan", Person, me, @constCast(&buffer));

    std.debug.print("{any}\n", .{try db.getSerializedAlloc("sayan", Person, allocator)});

}