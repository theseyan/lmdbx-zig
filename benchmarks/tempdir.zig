const std = @import("std");
const Io = std.Io;

pub const TempDir = struct {
    dir: Io.Dir,
    parent_dir: Io.Dir,
    sub_path: [sub_path_len]u8,

    const random_bytes_count = 12;
    const sub_path_len = std.base64.url_safe.Encoder.calcSize(random_bytes_count);

    pub fn cleanup(self: *TempDir, io: Io) void {
        self.dir.close(io);
        self.parent_dir.deleteTree(io, &self.sub_path) catch {};
        self.parent_dir.close(io);
        self.* = undefined;
    }
};

pub fn tempDir(io: Io, opts: Io.Dir.OpenOptions) !TempDir {
    var random_bytes: [TempDir.random_bytes_count]u8 = undefined;
    io.random(&random_bytes);
    var sub_path: [TempDir.sub_path_len]u8 = undefined;
    _ = std.base64.url_safe.Encoder.encode(&sub_path, &random_bytes);

    const cwd = Io.Dir.cwd();
    var cache_dir = try cwd.createDirPathOpen(io, ".zig-cache", .{});
    defer cache_dir.close(io);
    const parent_dir = try cache_dir.createDirPathOpen(io, "tmp", .{});
    const dir = try parent_dir.createDirPathOpen(io, &sub_path, .{ .open_options = opts });

    return .{
        .dir = dir,
        .parent_dir = parent_dir,
        .sub_path = sub_path,
    };
}
