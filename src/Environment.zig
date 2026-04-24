const std = @import("std");
const c = @import("c.zig");
const errors = @import("errors.zig");
const Transaction = @import("Transaction.zig");
const Database = @import("Database.zig");

const throw = errors.throw;
const Error = errors.Error;
const Environment = @This();

/// Options to initialize environment with
pub const Options = struct {
    geometry: ?DatabaseGeometry = null,
    max_dbs: u32 = 0,
    max_readers: u32 = 126,
    read_only: bool = false,
    write_map: bool = false,
    no_sticky_threads: bool = false,
    exclusive: bool = false,
    no_read_ahead: bool = false,
    no_mem_init: bool = false,
    lifo_reclaim: bool = false,
    no_meta_sync: bool = false,
    safe_nosync: bool = false,
    unsafe_nosync: bool = false,
    sync_durable: bool = true,
    /// Autosync period in milliseconds. 0 disables periodic autosync.
    sync_period_ms: u32 = 0,
    /// Autosync threshold in bytes. 0 disables threshold-based autosync.
    sync_bytes: usize = 0,
    mode: u16 = 0o664,
};

/// Environment statistics
pub const Stat = struct {
    psize: u32,
    depth: u32,
    branch_pages: usize,
    leaf_pages: usize,
    overflow_pages: usize,
    entries: usize,
};

/// Geometry slice of `Info`.
pub const Geometry = struct {
    lower: u64,
    upper: u64,
    current: u64,
    shrink: u64,
    grow: u64,
};

/// Page operation statistics returned with `Info`.
pub const PgopStat = struct {
    newly: u64,
    cow: u64,
    clone: u64,
    split: u64,
    merge: u64,
    spill: u64,
    unspill: u64,
    wops: u64,
    prefault: u64,
    mincore: u64,
    msync: u64,
    fsync: u64,
};

/// Environment information
pub const Info = struct {
    geo: Geometry,
    map_size: u64,
    dxb_fsize: u64,
    dxb_fallocated: u64,
    last_pgno: u64,
    recent_txnid: u64,
    latter_reader_txnid: u64,
    self_latter_reader_txnid: u64,
    meta_txnid: [3]u64,
    meta_sign: [3]u64,
    max_readers: u32,
    num_readers: u32,
    db_pagesize: u32,
    sys_pagesize: u32,
    sys_upcblk: u32,
    sys_ioblk: u32,
    unsync_volume: u64,
    autosync_threshold: u64,
    since_sync_seconds_16dot16: u32,
    autosync_period_seconds_16dot16: u32,
    since_reader_check_seconds_16dot16: u32,
    mode: u32,
    pgop_stat: PgopStat,
};

/// Information about a single reader slot.
pub const Reader = struct {
    num: u32,
    slot: u32,
    pid: std.posix.pid_t,
    thread: u64,
    txn_id: u64,
    lag: u64,
    bytes_used: usize,
    bytes_retained: usize,
};

/// Environment flags info
pub const FlagsInfo = struct {
    raw: u32,
    no_meta_sync: bool,
    safe_nosync: bool,
    unsafe_nosync: bool,
    sync_durable: bool,
    write_map: bool,
    exclusive: bool,
};

/// Database geometry options
pub const DatabaseGeometry = struct {
    lower_size: isize = -1,
    upper_size: isize = -1,
    size_now: isize = -1,
    growth_step: isize = -1,
    shrink_threshold: isize = -1,
    pagesize: isize = -1
};

ptr: ?*c.MDBX_env = null,

/// Initializes an environment
pub fn init(env_path: [*:0]const u8, options: Options) !Environment {
    var env = Environment{};

    // Allocate memory for environment
    try throw(c.mdbx_env_create(&env.ptr));
    errdefer _ = c.mdbx_env_close(env.ptr);

    // If provided, set database geometry
    if (options.geometry != null) {
        try setGeometry(env, options.geometry.?);
    }

    // Max databases and max readers
    try throw(c.mdbx_env_set_maxdbs(env.ptr, options.max_dbs));
    try throw(c.mdbx_env_set_maxreaders(env.ptr, options.max_readers));

    // Set configuration flags
    var flags: c_uint = 0;

    if (options.read_only) flags |= c.MDBX_RDONLY;
    if (options.write_map) flags |= c.MDBX_WRITEMAP;
    if (options.exclusive) flags |= c.MDBX_EXCLUSIVE;
    if (options.no_sticky_threads) flags |= c.MDBX_NOSTICKYTHREADS;
    if (options.no_read_ahead) flags |= c.MDBX_NORDAHEAD;
    if (options.no_mem_init) flags |= c.MDBX_NOMEMINIT;
    if (options.lifo_reclaim) flags |= c.MDBX_LIFORECLAIM;
    if (options.no_meta_sync) flags |= c.MDBX_NOMETASYNC;
    if (options.safe_nosync) flags |= c.MDBX_SAFE_NOSYNC;
    if (options.unsafe_nosync) flags |= c.MDBX_UTTERLY_NOSYNC;
    if (options.sync_durable) flags |= c.MDBX_SYNC_DURABLE;

    try throw(c.mdbx_env_open(env.ptr, env_path, flags, options.mode));

    if (options.sync_period_ms != 0) {
        const seconds_16dot16: u64 = (@as(u64, options.sync_period_ms) << 16) / 1000;
        try throw(c.mdbx_env_set_option(env.ptr, @as(c_uint, @bitCast(c.MDBX_opt_sync_period)), seconds_16dot16));
    }
    if (options.sync_bytes != 0) {
        try throw(c.mdbx_env_set_option(env.ptr, @as(c_uint, @bitCast(c.MDBX_opt_sync_bytes)), options.sync_bytes));
    }

    return env;
}

/// De-initialize the environment
pub fn deinit(self: Environment) !void {
    try throw(c.mdbx_env_close(self.ptr));
}

/// Syncs environment to disk with control flags.
/// Returns true if there is no pending data to flush, false otherwise.
pub fn sync(self: Environment, force: bool, nonblock: bool) !bool {
    const rc = c.mdbx_env_sync_ex(self.ptr, force, nonblock);
    if (rc == c.MDBX_RESULT_TRUE) return true;
    if (rc == 0) return false;
    try throw(rc);
    return false;
}

/// Fetch statistics from a given environment.
pub fn stat(self: Environment) !Stat {
    var result: c.MDBX_stat = undefined;
    try throw(c.mdbx_env_stat_ex(self.ptr, null, &result, @sizeOf(c.MDBX_stat)));

    return .{
        .psize = result.ms_psize,
        .depth = result.ms_depth,
        .branch_pages = result.ms_branch_pages,
        .leaf_pages = result.ms_leaf_pages,
        .overflow_pages = result.ms_overflow_pages,
        .entries = result.ms_entries,
    };
}

/// Fetch information about a given environment
pub fn info(self: Environment) !Info {
    var r: c.MDBX_envinfo = undefined;
    try throw(c.mdbx_env_info_ex(self.ptr, null, &r, @sizeOf(c.MDBX_envinfo)));

    return .{
        .geo = .{
            .lower = r.mi_geo.lower,
            .upper = r.mi_geo.upper,
            .current = r.mi_geo.current,
            .shrink = r.mi_geo.shrink,
            .grow = r.mi_geo.grow,
        },
        .map_size = r.mi_mapsize,
        .dxb_fsize = r.mi_dxb_fsize,
        .dxb_fallocated = r.mi_dxb_fallocated,
        .last_pgno = r.mi_last_pgno,
        .recent_txnid = r.mi_recent_txnid,
        .latter_reader_txnid = r.mi_latter_reader_txnid,
        .self_latter_reader_txnid = r.mi_self_latter_reader_txnid,
        .meta_txnid = r.mi_meta_txnid,
        .meta_sign = r.mi_meta_sign,
        .max_readers = r.mi_maxreaders,
        .num_readers = r.mi_numreaders,
        .db_pagesize = r.mi_dxb_pagesize,
        .sys_pagesize = r.mi_sys_pagesize,
        .sys_upcblk = r.mi_sys_upcblk,
        .sys_ioblk = r.mi_sys_ioblk,
        .unsync_volume = r.mi_unsync_volume,
        .autosync_threshold = r.mi_autosync_threshold,
        .since_sync_seconds_16dot16 = r.mi_since_sync_seconds16dot16,
        .autosync_period_seconds_16dot16 = r.mi_autosync_period_seconds16dot16,
        .since_reader_check_seconds_16dot16 = r.mi_since_reader_check_seconds16dot16,
        .mode = r.mi_mode,
        .pgop_stat = .{
            .newly = r.mi_pgop_stat.newly,
            .cow = r.mi_pgop_stat.cow,
            .clone = r.mi_pgop_stat.clone,
            .split = r.mi_pgop_stat.split,
            .merge = r.mi_pgop_stat.merge,
            .spill = r.mi_pgop_stat.spill,
            .unspill = r.mi_pgop_stat.unspill,
            .wops = r.mi_pgop_stat.wops,
            .prefault = r.mi_pgop_stat.prefault,
            .mincore = r.mi_pgop_stat.mincore,
            .msync = r.mi_pgop_stat.msync,
            .fsync = r.mi_pgop_stat.fsync,
        },
    };
}

/// Fetch environment flags.
pub fn flagsInfo(self: Environment) !FlagsInfo {
    var flags: c_uint = 0;
    try throw(c.mdbx_env_get_flags(self.ptr, &flags));
    const no_meta_sync = (flags & c.MDBX_NOMETASYNC) != 0;
    const safe_nosync = (flags & c.MDBX_SAFE_NOSYNC) != 0;
    const unsafe_nosync = (flags & c.MDBX_UTTERLY_NOSYNC) == c.MDBX_UTTERLY_NOSYNC;
    const sync_durable = !no_meta_sync and !safe_nosync and !unsafe_nosync;
    return .{
        .raw = @as(u32, @intCast(flags)),
        .no_meta_sync = no_meta_sync,
        .safe_nosync = safe_nosync,
        .unsafe_nosync = unsafe_nosync,
        .sync_durable = sync_durable,
        .write_map = (flags & c.MDBX_WRITEMAP) != 0,
        .exclusive = (flags & c.MDBX_EXCLUSIVE) != 0,
    };
}

/// Fetch current autosync bytes threshold.
pub fn syncBytes(self: Environment) !usize {
    var value: u64 = 0;
    try throw(c.mdbx_env_get_option(self.ptr, @as(c_uint, @bitCast(c.MDBX_opt_sync_bytes)), &value));
    return @as(usize, @intCast(value));
}

/// Fetch current autosync period in 16.16 seconds.
pub fn syncPeriod(self: Environment) !u32 {
    var value: u64 = 0;
    try throw(c.mdbx_env_get_option(self.ptr, @as(c_uint, @bitCast(c.MDBX_opt_sync_period)), &value));
    return @as(u32, @intCast(value));
}

/// Set database geomtry (scaling)
pub fn setGeometry(self: Environment, options: DatabaseGeometry) !void {
    try throw(c.mdbx_env_set_geometry(self.ptr, options.lower_size, options.size_now, options.upper_size, options.growth_step, options.shrink_threshold, options.pagesize));
}

/// Start a transaction and get handle
pub fn transaction(self: Environment, options: Transaction.Options) !Transaction {
    return try Transaction.init(self, options);
}

/// Filesystem path that was used to open this environment.
pub fn path(self: Environment) ![:0]const u8 {
    var dest: [*c]const u8 = null;
    try throw(c.mdbx_env_get_path(self.ptr, &dest));
    if (dest == null) return "";
    return std.mem.span(@as([*:0]const u8, @ptrCast(dest)));
}

/// Underlying file descriptor of the environment's data file.
pub fn fd(self: Environment) !std.posix.fd_t {
    var handle: c.mdbx_filehandle_t = undefined;
    try throw(c.mdbx_env_get_fd(self.ptr, &handle));
    return @intCast(handle);
}

/// Maximum allowed key size for a database with the given options.
pub fn maxKeySize(self: Environment, db_options: Database.Options) !usize {
    const r = c.mdbx_env_get_maxkeysize_ex(self.ptr, db_options.toFlags());
    if (r < 0) return Error.MDBX_PROBLEM;
    return @intCast(r);
}

/// Maximum allowed value size for a database with the given options.
pub fn maxValSize(self: Environment, db_options: Database.Options) !usize {
    const r = c.mdbx_env_get_maxvalsize_ex(self.ptr, db_options.toFlags());
    if (r < 0) return Error.MDBX_PROBLEM;
    return @intCast(r);
}

/// Maximum number of named databases this environment was configured for.
pub fn maxDbs(self: Environment) !u32 {
    var dbs: c.MDBX_dbi = 0;
    try throw(c.mdbx_env_get_maxdbs(self.ptr, &dbs));
    return dbs;
}

/// Maximum number of reader slots configured for this environment.
pub fn maxReaders(self: Environment) !u32 {
    var n: c_uint = 0;
    try throw(c.mdbx_env_get_maxreaders(self.ptr, &n));
    return n;
}

/// Check for stale reader slots and return the number cleared.
pub fn readerCheck(self: Environment) !u32 {
    var dead: c_int = 0;
    try throw(c.mdbx_reader_check(self.ptr, &dead));
    return @intCast(dead);
}

const ReaderCollector = struct {
    list: *std.ArrayList(Reader),
    allocator: std.mem.Allocator,
    err: ?anyerror = null,
};

fn readerListCb(
    ctx: ?*anyopaque,
    num: c_int,
    slot: c_int,
    pid: c.mdbx_pid_t,
    thread: c.mdbx_tid_t,
    txnid: u64,
    lag: u64,
    bytes_used: usize,
    bytes_retained: usize,
) callconv(.c) c_int {
    const collector: *ReaderCollector = @ptrCast(@alignCast(ctx));
    collector.list.append(collector.allocator, .{
        .num = @intCast(num),
        .slot = @intCast(slot),
        .pid = pid,
        .thread = @intCast(thread),
        .txn_id = txnid,
        .lag = lag,
        .bytes_used = bytes_used,
        .bytes_retained = bytes_retained,
    }) catch |e| {
        collector.err = e;
        return -1;
    };
    return 0;
}

/// Enumerate currently registered readers. Caller owns the returned slice.
pub fn readerList(self: Environment, alloc: std.mem.Allocator) ![]Reader {
    var list: std.ArrayList(Reader) = .empty;
    errdefer list.deinit(alloc);
    var collector = ReaderCollector{ .list = &list, .allocator = alloc };
    const rc = c.mdbx_reader_list(self.ptr, readerListCb, &collector);
    if (collector.err) |e| return e;
    try throw(rc);
    return try list.toOwnedSlice(alloc);
}

/// Logging verbosity for `setupDebug`.
pub const LogLevel = enum(c_int) {
    fatal = c.MDBX_LOG_FATAL,
    err = c.MDBX_LOG_ERROR,
    warn = c.MDBX_LOG_WARN,
    notice = c.MDBX_LOG_NOTICE,
    verbose = c.MDBX_LOG_VERBOSE,
    debug = c.MDBX_LOG_DEBUG,
    trace = c.MDBX_LOG_TRACE,
    extra = c.MDBX_LOG_EXTRA,
    /// Keep the current value.
    dont_change = c.MDBX_LOG_DONTCHANGE,
};

/// Runtime debug flags for `setupDebug`.
pub const DebugFlags = packed struct(u32) {
    assert: bool = false,
    audit: bool = false,
    jitter: bool = false,
    dump: bool = false,
    legacy_multiopen: bool = false,
    legacy_overlap: bool = false,
    dont_upgrade: bool = false,
    _padding: u25 = 0,

    pub const none: DebugFlags = .{};
    pub const dont_change: DebugFlags = @bitCast(@as(u32, @bitCast(@as(i32, c.MDBX_DBG_DONTCHANGE))));
};

/// Configure runtime debug logging level and flags. Logger is left unchanged.
/// Returns previous combined value.
pub fn setupDebug(log_level: LogLevel, debug_flags: DebugFlags) i32 {
    const flags_int: i32 = @bitCast(@as(u32, @bitCast(debug_flags)));
    return c.mdbx_setup_debug(@intFromEnum(log_level), flags_int, c.MDBX_LOGGER_DONTCHANGE);
}

/// Flags accepted by `Environment.warmup`.
pub const WarmupFlags = packed struct(u32) {
    force: bool = false,
    oomsafe: bool = false,
    lock: bool = false,
    touchlimit: bool = false,
    release: bool = false,
    _padding: u27 = 0,

    pub const default: WarmupFlags = .{};
};

/// Hint the kernel/runtime to warm up the database into the page cache.
pub fn warmup(self: Environment, flags: WarmupFlags, timeout_seconds_16dot16: u32) !void {
    try throw(c.mdbx_env_warmup(self.ptr, null, @bitCast(flags), timeout_seconds_16dot16));
}

/// Copy the environment to another path. When `compact`, free pages are removed.
pub fn copyTo(self: Environment, dest: [*:0]const u8, compact: bool) !void {
    const flags: c.MDBX_copy_flags_t = if (compact) c.MDBX_CP_COMPACT else c.MDBX_CP_DEFAULTS;
    try throw(c.mdbx_env_copy(self.ptr, dest, flags));
}

/// Set application context pointer.
pub fn setUserctx(self: Environment, ctx: ?*anyopaque) !void {
    try throw(c.mdbx_env_set_userctx(self.ptr, ctx));
}

/// Get application context pointer.
pub fn getUserctx(self: Environment) ?*anyopaque {
    return c.mdbx_env_get_userctx(self.ptr);
}

/// Toggle a subset of environment flags after open. Only certain flags may be
/// changed at runtime; mdbx returns an error otherwise.
pub fn setFlags(self: Environment, flags: u32, on: bool) !void {
    try throw(c.mdbx_env_set_flags(self.ptr, flags, on));
}

/// Close the environment without syncing. Cheaper than `deinit` when the caller
/// is certain no unsynced changes are pending.
pub fn closeNoSync(self: Environment) !void {
    try throw(c.mdbx_env_close_ex(self.ptr, true));
}

/// Maximum {key,value} pair size that fits on a single page.
pub fn pairSize4PageMax(self: Environment, db_options: Database.Options) !usize {
    const r = c.mdbx_env_get_pairsize4page_max(self.ptr, db_options.toFlags());
    if (r < 0) return Error.MDBX_PROBLEM;
    return @intCast(r);
}

/// Maximum value size that fits on a single page; per-key for DupSort.
pub fn valSize4PageMax(self: Environment, db_options: Database.Options) !usize {
    const r = c.mdbx_env_get_valsize4page_max(self.ptr, db_options.toFlags());
    if (r < 0) return Error.MDBX_PROBLEM;
    return @intCast(r);
}

/// Tunables exposed via `setOption` / `getOption`. See libmdbx docs.
pub const Option = enum(c_int) {
    max_db = c.MDBX_opt_max_db,
    max_readers = c.MDBX_opt_max_readers,
    sync_bytes = c.MDBX_opt_sync_bytes,
    sync_period = c.MDBX_opt_sync_period,
    rp_augment_limit = c.MDBX_opt_rp_augment_limit,
    loose_limit = c.MDBX_opt_loose_limit,
    dp_reserve_limit = c.MDBX_opt_dp_reserve_limit,
    txn_dp_limit = c.MDBX_opt_txn_dp_limit,
    txn_dp_initial = c.MDBX_opt_txn_dp_initial,
    spill_max_denominator = c.MDBX_opt_spill_max_denominator,
    spill_min_denominator = c.MDBX_opt_spill_min_denominator,
    spill_parent4child_denominator = c.MDBX_opt_spill_parent4child_denominator,
    merge_threshold = c.MDBX_opt_merge_threshold,
    writethrough_threshold = c.MDBX_opt_writethrough_threshold,
    prefault_write_enable = c.MDBX_opt_prefault_write_enable,
    gc_time_limit = c.MDBX_opt_gc_time_limit,
    prefer_waf_insteadof_balance = c.MDBX_opt_prefer_waf_insteadof_balance,
    subpage_limit = c.MDBX_opt_subpage_limit,
    subpage_room_threshold = c.MDBX_opt_subpage_room_threshold,
    subpage_reserve_prereq = c.MDBX_opt_subpage_reserve_prereq,
    subpage_reserve_limit = c.MDBX_opt_subpage_reserve_limit,
    split_reserve = c.MDBX_opt_split_reserve,
};

/// Generic option setter; see `Option`.
pub fn setOption(self: Environment, opt: Option, value: u64) !void {
    try throw(c.mdbx_env_set_option(self.ptr, @bitCast(@as(c_int, @intFromEnum(opt))), value));
}

/// Generic option getter; see `Option`.
pub fn getOption(self: Environment, opt: Option) !u64 {
    var v: u64 = 0;
    try throw(c.mdbx_env_get_option(self.ptr, @bitCast(@as(c_int, @intFromEnum(opt))), &v));
    return v;
}

// ---------------------------------------------------------------------------
// Static helpers (no env required).
// ---------------------------------------------------------------------------

/// How libmdbx should handle existing files when calling `Environment.deletePath`.
pub const DeleteMode = enum(c_int) {
    /// Delete only the lock file; leave the data file intact.
    just_delete = c.MDBX_ENV_JUST_DELETE,
    /// Wait for any active env handle to drop, then delete files.
    ensure_unused = c.MDBX_ENV_ENSURE_UNUSED,
    /// Wait until exclusive access is acquired, then delete files.
    wait_for_unused = c.MDBX_ENV_WAIT_FOR_UNUSED,
};

/// Delete an environment's files. Returns true if files were found and deleted.
pub fn deletePath(p: [*:0]const u8, mode: DeleteMode) !bool {
    const rc = c.mdbx_env_delete(p, @bitCast(@as(c_int, @intFromEnum(mode))));
    if (rc == c.MDBX_SUCCESS) return true;
    if (rc == c.MDBX_RESULT_TRUE) return false;
    try throw(rc);
    return false;
}

/// Default page size on this system.
pub fn defaultPagesize() usize {
    return c.mdbx_default_pagesize();
}

/// Information about system memory.
pub const SysRamInfo = struct { page_size: usize, total_pages: usize, avail_pages: usize };

pub fn sysRamInfo() !SysRamInfo {
    var ps: isize = 0;
    var tp: isize = 0;
    var ap: isize = 0;
    try throw(c.mdbx_get_sysraminfo(&ps, &tp, &ap));
    return .{
        .page_size = @intCast(ps),
        .total_pages = @intCast(tp),
        .avail_pages = @intCast(ap),
    };
}

/// Min/max allowed DB sizes for a given page size. Use 0 for system default.
pub const SizeLimits = struct { min: usize, max: usize };

pub fn dbSizeLimits(pagesize: usize) SizeLimits {
    const ps: isize = @intCast(pagesize);
    return .{
        .min = @intCast(c.mdbx_limits_dbsize_min(ps)),
        .max = @intCast(c.mdbx_limits_dbsize_max(ps)),
    };
}

pub fn keySizeLimits(pagesize: usize, db_options: Database.Options) SizeLimits {
    const ps: isize = @intCast(pagesize);
    const flags = db_options.toFlags();
    return .{
        .min = @intCast(c.mdbx_limits_keysize_min(flags)),
        .max = @intCast(c.mdbx_limits_keysize_max(ps, flags)),
    };
}

pub fn valSizeLimits(pagesize: usize, db_options: Database.Options) SizeLimits {
    const ps: isize = @intCast(pagesize);
    const flags = db_options.toFlags();
    return .{
        .min = @intCast(c.mdbx_limits_valsize_min(flags)),
        .max = @intCast(c.mdbx_limits_valsize_max(ps, flags)),
    };
}

/// Maximum number of pages a single transaction may touch.
pub fn txnSizeMax(pagesize: usize) usize {
    return @intCast(c.mdbx_limits_txnsize_max(@intCast(pagesize)));
}

/// Human-readable string for an mdbx error code.
pub fn errorString(code: c_int) [:0]const u8 {
    return std.mem.span(@as([*:0]const u8, @ptrCast(c.mdbx_strerror(code))));
}

/// Inputs to `Environment.defrag`.
pub const DefragOptions = struct {
    /// Minimum number of pages to attempt to relocate. 0 = no minimum.
    defrag_atleast_pages: usize = 0,
    /// Minimum wall-clock time to keep working, in milliseconds. 0 = no minimum.
    time_atleast_ms: u32 = 0,
    /// Number of pages after which defrag may stop early. 0 = no early stop.
    defrag_enough_pages: usize = 0,
    /// Hard upper bound on wall-clock time, in milliseconds. 0 = unbounded.
    time_limit_ms: u32 = 0,
    /// Tolerance for backslide between cycles. -1 = libmdbx default.
    acceptable_backlash: isize = -1,
    /// Preferred batch size in pages for one transaction. -1 = libmdbx default.
    preferred_batch: isize = -1,
};

/// Bitmask of reasons defragmentation finished or was interrupted.
pub const DefragStopReasons = packed struct(u32) {
    step_size: bool = false,
    large_chunk: bool = false,
    discontinued: bool = false,
    laggard_reader: bool = false,
    enough_threshold: bool = false,
    time_limit: bool = false,
    aborted: bool = false,
    err: bool = false,
    _padding: u24 = 0,

    pub fn fromRaw(raw: u32) DefragStopReasons {
        return .{
            .step_size = (raw & c.MDBX_defrag_step_size) != 0,
            .large_chunk = (raw & c.MDBX_defrag_large_chunk) != 0,
            .discontinued = (raw & c.MDBX_defrag_discontinued) != 0,
            .laggard_reader = (raw & c.MDBX_defrag_laggard_reader) != 0,
            .enough_threshold = (raw & c.MDBX_defrag_enough_threshold) != 0,
            .time_limit = (raw & c.MDBX_defrag_time_limit) != 0,
            .aborted = (raw & c.MDBX_defrag_aborted) != 0,
            .err = (raw & c.MDBX_defrag_error) != 0,
        };
    }
};

/// Outcome of `Environment.defrag`.
pub const DefragResult = struct {
    pages_shrinked: isize,
    pages_moved: usize,
    pages_scheduled: usize,
    pages_retained: usize,
    pages_left: usize,
    pages_whole: usize,
    obstructed_pgno: usize,
    obstructed_span: usize,
    obstructed_txnid: u64,
    cycles: u32,
    cycle_progress_permille: u32,
    stopping_reasons: DefragStopReasons,
    spent_time_ms: u64,
};

inline fn ms_to_16dot16(ms: u32) usize {
    return (@as(usize, ms) << 16) / 1000;
}

inline fn dot16_to_ms(v: usize) u64 {
    return (@as(u64, v) * 1000) >> 16;
}

/// Compact the database by relocating pages to the head of the file.
pub fn defrag(self: Environment, options: DefragOptions) !DefragResult {
    var raw: c.MDBX_defrag_result_t = std.mem.zeroes(c.MDBX_defrag_result_t);
    try throw(c.mdbx_env_defrag(
        self.ptr,
        options.defrag_atleast_pages,
        ms_to_16dot16(options.time_atleast_ms),
        options.defrag_enough_pages,
        ms_to_16dot16(options.time_limit_ms),
        options.acceptable_backlash,
        options.preferred_batch,
        null,
        null,
        &raw,
    ));
    return .{
        .pages_shrinked = raw.pages_shrinked,
        .pages_moved = raw.pages_moved,
        .pages_scheduled = raw.pages_scheduled,
        .pages_retained = raw.pages_retained,
        .pages_left = raw.pages_left,
        .pages_whole = raw.pages_whole,
        .obstructed_pgno = raw.obstructed_pgno,
        .obstructed_span = raw.obstructed_span,
        .obstructed_txnid = raw.obstructed_txnid,
        .cycles = raw.cycles,
        .cycle_progress_permille = raw.rough_estimation_cycle_progress_permille,
        .stopping_reasons = DefragStopReasons.fromRaw(raw.stopping_reasons),
        .spent_time_ms = dot16_to_ms(raw.spent_time_dot16),
    };
}
