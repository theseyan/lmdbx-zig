const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const IS_DEV = if (optimize == .Debug) true else false;

    // Whether the target has avx512bw support
    const has_avx512 = comptime builtin.cpu.features.isEnabled(@intFromEnum(std.Target.x86.Feature.avx512bw));
    
    // For x86 target, we need .evex512 features explicitly because of a Zig compiler bug.
    // Relevant issue: https://github.com/ziglang/zig/issues/20414
    // If target doesn't support avx512bw, disable SIMD optimizations completely.
    // aarch64 always has NEON.
    const target_query = b.resolveTargetQuery(std.Target.Query{
        .cpu_arch = target.result.cpu.arch,
        .os_tag = target.result.os.tag,
        .abi = target.result.abi,
        .cpu_features_add = switch (target.result.cpu.arch) {
            .x86_64 => blk: {
                if (!has_avx512) std.debug.print("Building without SIMD optimizations as target doesn't support avx512bw. This is a Zig compiler bug to be fixed in 0.14.\n", .{});

                break :blk std.Target.x86.featureSet(&[_]std.Target.x86.Feature{
                    if (has_avx512) .evex512 else break :blk std.Target.Cpu.Feature.Set.empty
                });
            },
            .aarch64 => target.result.cpu.features,
            else => std.Target.Cpu.Feature.Set.empty // Unknown CPU
        },
    });

    const mdbx = b.addModule("lmdbx", .{ .root_source_file = b.path("src/lib.zig") });

    // Add CPU features polyfill until https://github.com/ziglang/zig/pull/20081 gets merged
    const cpuf_dep = b.dependency("cpu_features", .{});

    mdbx.addIncludePath(cpuf_dep.path("cpu_model"));

    if (target.result.cpu.arch == .x86_64 or target.result.cpu.arch == .aarch64) {
        mdbx.addCSourceFile(.{
            .file = switch (target.result.cpu.arch) {
                .x86_64 => cpuf_dep.path("cpu_model/x86.c"),
                .aarch64 => cpuf_dep.path("cpu_model/aarch64.c"),
                else => unreachable
            },
            .flags = &.{}
        });
    }

    // libMDBX
    const mdbx_dep = b.dependency("mdbx", .{});
    mdbx.addIncludePath(mdbx_dep.path("."));

    // Add headers needed to compile
    mdbx.addIncludePath(b.path("src/headers"));

    // mdbx.c is amalgated source code
    mdbx.addCSourceFile(.{
        .file = mdbx_dep.path("mdbx.c"),
        .flags = &[_][]const u8{
            "-std=gnu11",
            "-O2",
            "-g",
            "-Wall",
            // These flags are recommended, but breaks Windows compilation
            // "-Werror",
            // "-Wextra",
            // "-Wpedantic",
            "-ffunction-sections",
            "-fvisibility=hidden",
            "-pthread",
            "-Wno-error=attributes",
            "-fno-semantic-interposition",
            "-Wno-unused-command-line-argument",
            "-Wno-tautological-compare",
            "-ULIBMDBX_EXPORTS",

            // Debug features
            if (IS_DEV) "-DMDBX_DEBUG=2" else "-DMDBX_DEBUG=0",
            if (IS_DEV) "-DMDBX_BUILD_FLAGS=\"UNDEBUG\"" else "-DMDBX_BUILD_FLAGS=\"DNDEBUG=1\"",

            // Disable SIMD optimizations if x86 and avx512bw not supported
            if (target.result.cpu.arch == .x86_64 and !has_avx512) "-DMDBX_HAVE_BUILTIN_CPU_SUPPORTS=0" else "",

            // Cross compilation to windows breaks without "errno.h"
            if (target.result.os.tag == .windows) "-includeerrno.h" else "",

            // We don't link with MSVC CRT
            if (target.result.os.tag == .windows) "-DMDBX_WITHOUT_MSVC_CRT=1" else "",

            // Link libraries
            switch (target.result.os.tag) {
                .windows => "-lm -lntdll -lwinmm -luser32 -lkernel32 -ladvapi32 -lole32",
                .macos, .openbsd => "-lm",
                else => "-lm -lrt"
            },
        }
    });

    mdbx.pic = true; // Enforce PIC
    mdbx.sanitize_c = false; // Address sanitization breaks libMDBX

    // Tests
    const tests = b.addTest(.{
        .root_source_file = b.path("test/main.zig"),
        .target = target_query,
    });
    tests.linkLibC();
    tests.root_module.addImport("lmdbx", mdbx);
    const test_runner = b.addRunArtifact(tests);

    b.step("test", "Run libMDBX tests").dependOn(&test_runner.step);

    // Benchmarks
    const bench = b.addExecutable(.{
        .name = "lmdbx-benchmark",
        .root_source_file = b.path("benchmarks/main.zig"),
        .optimize = if (IS_DEV) .Debug else .ReleaseFast,
        .target = target_query,
    });

    bench.linkLibC();
    bench.root_module.addImport("lmdbx", mdbx);

    b.installArtifact(bench);

    // Linker flags for libMDBX
    bench.link_gc_sections = true;
    bench.link_z_relro = true;

    // Enforce LTO
    bench.want_lto = switch (target.result.os.tag) {
        .macos => false, // Cross-compilation breaks on macOS LTO
        else => if (IS_DEV) false else true
    };

    const bench_runner = b.addRunArtifact(bench);
    b.step("bench", "Run libMDBX benchmarks").dependOn(&bench_runner.step);
}
