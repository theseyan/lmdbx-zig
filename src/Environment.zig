const std = @import("std");
const c = @import("c.zig");
const errors = @import("errors.zig");
const Transaction = @import("Transaction.zig");

const throw = errors.throw;
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

/// Environment information
pub const Info = struct {
    map_size: usize,
    max_readers: u32,
    num_readers: u32,
    autosync_period: u32,
    autosync_threshold: u64,
    db_pagesize: u32,
    mode: u32,
    sys_pagesize: u32,
    unsync_volume: u64
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
pub fn init(path: [*:0]const u8, options: Options) !Environment {
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

    try throw(c.mdbx_env_open(env.ptr, path, flags, options.mode));

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
    var result: c.MDBX_envinfo = undefined;
    try throw(c.mdbx_env_info_ex(self.ptr, null, &result, @sizeOf(c.MDBX_envinfo)));

    return .{
        .map_size = result.mi_mapsize,
        .max_readers = result.mi_maxreaders,
        .num_readers = result.mi_numreaders,
        .autosync_period = result.mi_autosync_period_seconds16dot16,
        .autosync_threshold = result.mi_autosync_threshold,
        .db_pagesize = result.mi_dxb_pagesize,
        .mode = result.mi_mode,
        .sys_pagesize = result.mi_sys_pagesize,
        .unsync_volume = result.mi_unsync_volume
    };
}

/// Fetch environment flags.
pub fn flagsInfo(self: Environment) !FlagsInfo {
    var flags: c_uint = 0;
    try throw(c.mdbx_env_get_flags(self.ptr, &flags));
    return .{
        .raw = @as(u32, @intCast(flags)),
        .no_meta_sync = (flags & c.MDBX_NOMETASYNC) != 0,
        .safe_nosync = (flags & c.MDBX_SAFE_NOSYNC) != 0,
        .unsafe_nosync = (flags & c.MDBX_UTTERLY_NOSYNC) == c.MDBX_UTTERLY_NOSYNC,
        .sync_durable = (flags & c.MDBX_SYNC_DURABLE) == c.MDBX_SYNC_DURABLE,
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

/// Fetch current autosync period (16.16 seconds).
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
