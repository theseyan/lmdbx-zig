const std = @import("std");

pub fn build(b: *std.Build) void {
    var target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const IS_DEV = if (optimize == .Debug) true else false;
    const enable_mdbx_debug = b.option(bool, "mdbx-debug", "Compile libmdbx with MDBX_DEBUG=2 (verbose runtime asserts and logs)") orelse false;

    // For Linux GNU targets, always target glibc 2.31 for broad compatibility
    if (target.result.os.tag == .linux and target.result.abi == .gnu) {
        target = b.resolveTargetQuery(.{
            .cpu_arch = target.result.cpu.arch,
            .os_tag = .linux,
            .abi = .gnu,
            .os_version_min = .{ .semver = std.SemanticVersion{ .major = 2, .minor = 31, .patch = 0 } },
            .glibc_version = std.SemanticVersion{ .major = 2, .minor = 31, .patch = 0 },
        });
    }

    const mdbx = b.addModule("lmdbx", .{ .root_source_file = b.path("src/lib.zig") });
    const zbench_dep = b.dependency("zbench", .{});
    const zbench_mod = b.addModule("zbench", .{ .root_source_file = zbench_dep.path("src/zbench.zig") });

    // Add CPU features polyfill until https://github.com/ziglang/zig/pull/20081 gets merged
    const cpuf_dep = b.dependency("cpu_features", .{});

    mdbx.addIncludePath(cpuf_dep.path("cpu_model"));

    if (target.result.cpu.arch == .x86_64 or target.result.cpu.arch == .aarch64) {
        mdbx.addCSourceFile(.{ .file = switch (target.result.cpu.arch) {
            .x86_64 => cpuf_dep.path("cpu_model/x86.c"),
            .aarch64 => cpuf_dep.path("cpu_model/aarch64.c"),
            else => unreachable,
        }, .flags = &.{} });
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
            // "-Wall",
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
            "-Wno-date-time",
            "-ULIBMDBX_EXPORTS",

            // Debug features
            // MDBX_DEBUG=-1 makes LOG_ENABLED() compile to (0), removing all
            // runtime log call sites entirely (incl. NOTICE chatter on stderr).
            if (enable_mdbx_debug) "-DMDBX_DEBUG=2" else "-DMDBX_DEBUG=-1",
            if (enable_mdbx_debug) "-DMDBX_BUILD_FLAGS=\"UNDEBUG\"" else "-DMDBX_BUILD_FLAGS=\"DNDEBUG=1\"",

            // Fix for LLVM 19+ requiring evex512 for AVX-512 512-bit intrinsics (Zig 0.13+)
            // See: https://github.com/ziglang/zig/issues/20414
            if (target.result.cpu.arch == .x86_64) "-includemdbx_avx512_fix.h" else "",

            // Cross compilation to windows breaks without "errno.h"
            if (target.result.os.tag == .windows) "-includeerrno.h" else "",

            // We don't link with MSVC CRT
            if (target.result.os.tag == .windows) "-DMDBX_WITHOUT_MSVC_CRT=1" else "",

            // Link libraries
            switch (target.result.os.tag) {
                .windows => "-lm -lntdll -lwinmm -luser32 -lkernel32 -ladvapi32 -lole32",
                .macos, .openbsd => "-lm",
                else => "-lm -lrt",
            },
        },
    });

    mdbx.pic = true; // Enforce PIC
    mdbx.sanitize_c = .off; // Address sanitization breaks libMDBX

    // Tests
    const test_mod = b.createModule(.{
        .root_source_file = b.path("test/main.zig"),
        .target = target,
        .link_libc = true,
        .imports = &.{.{ .name = "lmdbx", .module = mdbx }},
    });
    const tests = b.addTest(.{
        .root_module = test_mod,
    });
    const test_runner = b.addRunArtifact(tests);

    b.step("test", "Run libMDBX tests").dependOn(&test_runner.step);

    // Benchmarks
    const bench_mod = b.createModule(.{
        .root_source_file = b.path("benchmarks/bench.zig"),
        .target = target,
        .optimize = if (IS_DEV) .Debug else .ReleaseFast,
        .link_libc = true,
        .imports = &.{ .{ .name = "lmdbx", .module = mdbx }, .{ .name = "zbench", .module = zbench_mod } },
    });
    const bench = b.addExecutable(.{
        .name = "lmdbx-bench",
        .root_module = bench_mod,
    });

    b.installArtifact(bench);

    // Linker flags for libMDBX
    bench.link_gc_sections = true;
    bench.link_z_relro = true;

    const bench_runner = b.addRunArtifact(bench);
    if (b.args) |args| {
        bench_runner.addArgs(args);
    }
    b.step("bench", "Run libMDBX benchmarks").dependOn(&bench_runner.step);

    // Multithreaded benchmark
    const bench_mt_mod = b.createModule(.{
        .root_source_file = b.path("benchmarks/multithreaded.zig"),
        .target = target,
        .optimize = .ReleaseFast,
        .link_libc = true,
        .imports = &.{.{ .name = "lmdbx", .module = mdbx }},
    });
    const bench_mt = b.addExecutable(.{
        .name = "lmdbx-bench-mt",
        .root_module = bench_mt_mod,
    });

    b.installArtifact(bench_mt);
    bench_mt.link_gc_sections = true;
    bench_mt.link_z_relro = true;

    const bench_mt_runner = b.addRunArtifact(bench_mt);
    if (b.args) |args| {
        bench_mt_runner.addArgs(args);
    }
    b.step("bench-mt", "Run multithreaded libMDBX benchmark").dependOn(&bench_mt_runner.step);

    // DB generator
    const gen_mod = b.createModule(.{
        .root_source_file = b.path("benchmarks/generate_db.zig"),
        .target = target,
        .optimize = if (IS_DEV) .Debug else .ReleaseFast,
        .link_libc = true,
        .imports = &.{.{ .name = "lmdbx", .module = mdbx }},
    });
    const gen = b.addExecutable(.{
        .name = "lmdbx-generate-db",
        .root_module = gen_mod,
    });
    b.installArtifact(gen);
    gen.link_gc_sections = true;
    gen.link_z_relro = true;
    const gen_runner = b.addRunArtifact(gen);
    if (b.args) |args| {
        gen_runner.addArgs(args);
    }
    b.step("gen-db", "Generate MDBX database").dependOn(&gen_runner.step);
}
