pub const __builtin_bswap16 = @import("std").zig.c_builtins.__builtin_bswap16;
pub const __builtin_bswap32 = @import("std").zig.c_builtins.__builtin_bswap32;
pub const __builtin_bswap64 = @import("std").zig.c_builtins.__builtin_bswap64;
pub const __builtin_signbit = @import("std").zig.c_builtins.__builtin_signbit;
pub const __builtin_signbitf = @import("std").zig.c_builtins.__builtin_signbitf;
pub const __builtin_popcount = @import("std").zig.c_builtins.__builtin_popcount;
pub const __builtin_ctz = @import("std").zig.c_builtins.__builtin_ctz;
pub const __builtin_clz = @import("std").zig.c_builtins.__builtin_clz;
pub const __builtin_sqrt = @import("std").zig.c_builtins.__builtin_sqrt;
pub const __builtin_sqrtf = @import("std").zig.c_builtins.__builtin_sqrtf;
pub const __builtin_sin = @import("std").zig.c_builtins.__builtin_sin;
pub const __builtin_sinf = @import("std").zig.c_builtins.__builtin_sinf;
pub const __builtin_cos = @import("std").zig.c_builtins.__builtin_cos;
pub const __builtin_cosf = @import("std").zig.c_builtins.__builtin_cosf;
pub const __builtin_exp = @import("std").zig.c_builtins.__builtin_exp;
pub const __builtin_expf = @import("std").zig.c_builtins.__builtin_expf;
pub const __builtin_exp2 = @import("std").zig.c_builtins.__builtin_exp2;
pub const __builtin_exp2f = @import("std").zig.c_builtins.__builtin_exp2f;
pub const __builtin_log = @import("std").zig.c_builtins.__builtin_log;
pub const __builtin_logf = @import("std").zig.c_builtins.__builtin_logf;
pub const __builtin_log2 = @import("std").zig.c_builtins.__builtin_log2;
pub const __builtin_log2f = @import("std").zig.c_builtins.__builtin_log2f;
pub const __builtin_log10 = @import("std").zig.c_builtins.__builtin_log10;
pub const __builtin_log10f = @import("std").zig.c_builtins.__builtin_log10f;
pub const __builtin_abs = @import("std").zig.c_builtins.__builtin_abs;
pub const __builtin_labs = @import("std").zig.c_builtins.__builtin_labs;
pub const __builtin_llabs = @import("std").zig.c_builtins.__builtin_llabs;
pub const __builtin_fabs = @import("std").zig.c_builtins.__builtin_fabs;
pub const __builtin_fabsf = @import("std").zig.c_builtins.__builtin_fabsf;
pub const __builtin_floor = @import("std").zig.c_builtins.__builtin_floor;
pub const __builtin_floorf = @import("std").zig.c_builtins.__builtin_floorf;
pub const __builtin_ceil = @import("std").zig.c_builtins.__builtin_ceil;
pub const __builtin_ceilf = @import("std").zig.c_builtins.__builtin_ceilf;
pub const __builtin_trunc = @import("std").zig.c_builtins.__builtin_trunc;
pub const __builtin_truncf = @import("std").zig.c_builtins.__builtin_truncf;
pub const __builtin_round = @import("std").zig.c_builtins.__builtin_round;
pub const __builtin_roundf = @import("std").zig.c_builtins.__builtin_roundf;
pub const __builtin_strlen = @import("std").zig.c_builtins.__builtin_strlen;
pub const __builtin_strcmp = @import("std").zig.c_builtins.__builtin_strcmp;
pub const __builtin_object_size = @import("std").zig.c_builtins.__builtin_object_size;
pub const __builtin___memset_chk = @import("std").zig.c_builtins.__builtin___memset_chk;
pub const __builtin_memset = @import("std").zig.c_builtins.__builtin_memset;
pub const __builtin___memcpy_chk = @import("std").zig.c_builtins.__builtin___memcpy_chk;
pub const __builtin_memcpy = @import("std").zig.c_builtins.__builtin_memcpy;
pub const __builtin_expect = @import("std").zig.c_builtins.__builtin_expect;
pub const __builtin_nanf = @import("std").zig.c_builtins.__builtin_nanf;
pub const __builtin_huge_valf = @import("std").zig.c_builtins.__builtin_huge_valf;
pub const __builtin_inff = @import("std").zig.c_builtins.__builtin_inff;
pub const __builtin_isnan = @import("std").zig.c_builtins.__builtin_isnan;
pub const __builtin_isinf = @import("std").zig.c_builtins.__builtin_isinf;
pub const __builtin_isinf_sign = @import("std").zig.c_builtins.__builtin_isinf_sign;
pub const __has_builtin = @import("std").zig.c_builtins.__has_builtin;
pub const __builtin_assume = @import("std").zig.c_builtins.__builtin_assume;
pub const __builtin_unreachable = @import("std").zig.c_builtins.__builtin_unreachable;
pub const __builtin_constant_p = @import("std").zig.c_builtins.__builtin_constant_p;
pub const __builtin_mul_overflow = @import("std").zig.c_builtins.__builtin_mul_overflow;
pub const struct___va_list_tag_1 = extern struct {
    gp_offset: c_uint = @import("std").mem.zeroes(c_uint),
    fp_offset: c_uint = @import("std").mem.zeroes(c_uint),
    overflow_arg_area: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    reg_save_area: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const __builtin_va_list = [1]struct___va_list_tag_1;
pub const __gnuc_va_list = __builtin_va_list;
pub const va_list = __builtin_va_list;
pub const ptrdiff_t = c_long;
pub const wchar_t = c_int;
pub const max_align_t = extern struct {
    __clang_max_align_nonce1: c_longlong align(8) = @import("std").mem.zeroes(c_longlong),
    __clang_max_align_nonce2: c_longdouble align(16) = @import("std").mem.zeroes(c_longdouble),
};
pub const __u_char = u8;
pub const __u_short = c_ushort;
pub const __u_int = c_uint;
pub const __u_long = c_ulong;
pub const __int8_t = i8;
pub const __uint8_t = u8;
pub const __int16_t = c_short;
pub const __uint16_t = c_ushort;
pub const __int32_t = c_int;
pub const __uint32_t = c_uint;
pub const __int64_t = c_long;
pub const __uint64_t = c_ulong;
pub const __int_least8_t = __int8_t;
pub const __uint_least8_t = __uint8_t;
pub const __int_least16_t = __int16_t;
pub const __uint_least16_t = __uint16_t;
pub const __int_least32_t = __int32_t;
pub const __uint_least32_t = __uint32_t;
pub const __int_least64_t = __int64_t;
pub const __uint_least64_t = __uint64_t;
pub const __quad_t = c_long;
pub const __u_quad_t = c_ulong;
pub const __intmax_t = c_long;
pub const __uintmax_t = c_ulong;
pub const __dev_t = c_ulong;
pub const __uid_t = c_uint;
pub const __gid_t = c_uint;
pub const __ino_t = c_ulong;
pub const __ino64_t = c_ulong;
pub const __mode_t = c_uint;
pub const __nlink_t = c_ulong;
pub const __off_t = c_long;
pub const __off64_t = c_long;
pub const __pid_t = c_int;
pub const __fsid_t = extern struct {
    __val: [2]c_int = @import("std").mem.zeroes([2]c_int),
};
pub const __clock_t = c_long;
pub const __rlim_t = c_ulong;
pub const __rlim64_t = c_ulong;
pub const __id_t = c_uint;
pub const __time_t = c_long;
pub const __useconds_t = c_uint;
pub const __suseconds_t = c_long;
pub const __suseconds64_t = c_long;
pub const __daddr_t = c_int;
pub const __key_t = c_int;
pub const __clockid_t = c_int;
pub const __timer_t = ?*anyopaque;
pub const __blksize_t = c_long;
pub const __blkcnt_t = c_long;
pub const __blkcnt64_t = c_long;
pub const __fsblkcnt_t = c_ulong;
pub const __fsblkcnt64_t = c_ulong;
pub const __fsfilcnt_t = c_ulong;
pub const __fsfilcnt64_t = c_ulong;
pub const __fsword_t = c_long;
pub const __ssize_t = c_long;
pub const __syscall_slong_t = c_long;
pub const __syscall_ulong_t = c_ulong;
pub const __loff_t = __off64_t;
pub const __caddr_t = [*c]u8;
pub const __intptr_t = c_long;
pub const __socklen_t = c_uint;
pub const __sig_atomic_t = c_int;
pub const int_least8_t = __int_least8_t;
pub const int_least16_t = __int_least16_t;
pub const int_least32_t = __int_least32_t;
pub const int_least64_t = __int_least64_t;
pub const uint_least8_t = __uint_least8_t;
pub const uint_least16_t = __uint_least16_t;
pub const uint_least32_t = __uint_least32_t;
pub const uint_least64_t = __uint_least64_t;
pub const int_fast8_t = i8;
pub const int_fast16_t = c_long;
pub const int_fast32_t = c_long;
pub const int_fast64_t = c_long;
pub const uint_fast8_t = u8;
pub const uint_fast16_t = c_ulong;
pub const uint_fast32_t = c_ulong;
pub const uint_fast64_t = c_ulong;
pub const intmax_t = __intmax_t;
pub const uintmax_t = __uintmax_t;
pub extern fn __assert_fail(__assertion: [*c]const u8, __file: [*c]const u8, __line: c_uint, __function: [*c]const u8) noreturn;
pub extern fn __assert_perror_fail(__errnum: c_int, __file: [*c]const u8, __line: c_uint, __function: [*c]const u8) noreturn;
pub extern fn __assert(__assertion: [*c]const u8, __file: [*c]const u8, __line: c_int) noreturn;
pub extern fn __errno_location() [*c]c_int;
pub const time_t = __time_t;
pub const struct_timespec = extern struct {
    tv_sec: __time_t = @import("std").mem.zeroes(__time_t),
    tv_nsec: __syscall_slong_t = @import("std").mem.zeroes(__syscall_slong_t),
};
pub const pid_t = __pid_t;
pub const struct_sched_param = extern struct {
    sched_priority: c_int = @import("std").mem.zeroes(c_int),
};
pub const __cpu_mask = c_ulong;
pub const cpu_set_t = extern struct {
    __bits: [16]__cpu_mask = @import("std").mem.zeroes([16]__cpu_mask),
};
pub extern fn __sched_cpucount(__setsize: usize, __setp: [*c]const cpu_set_t) c_int;
pub extern fn __sched_cpualloc(__count: usize) [*c]cpu_set_t;
pub extern fn __sched_cpufree(__set: [*c]cpu_set_t) void;
pub extern fn sched_setparam(__pid: __pid_t, __param: [*c]const struct_sched_param) c_int;
pub extern fn sched_getparam(__pid: __pid_t, __param: [*c]struct_sched_param) c_int;
pub extern fn sched_setscheduler(__pid: __pid_t, __policy: c_int, __param: [*c]const struct_sched_param) c_int;
pub extern fn sched_getscheduler(__pid: __pid_t) c_int;
pub extern fn sched_yield() c_int;
pub extern fn sched_get_priority_max(__algorithm: c_int) c_int;
pub extern fn sched_get_priority_min(__algorithm: c_int) c_int;
pub extern fn sched_rr_get_interval(__pid: __pid_t, __t: [*c]struct_timespec) c_int;
pub const clock_t = __clock_t;
pub const struct_tm = extern struct {
    tm_sec: c_int = @import("std").mem.zeroes(c_int),
    tm_min: c_int = @import("std").mem.zeroes(c_int),
    tm_hour: c_int = @import("std").mem.zeroes(c_int),
    tm_mday: c_int = @import("std").mem.zeroes(c_int),
    tm_mon: c_int = @import("std").mem.zeroes(c_int),
    tm_year: c_int = @import("std").mem.zeroes(c_int),
    tm_wday: c_int = @import("std").mem.zeroes(c_int),
    tm_yday: c_int = @import("std").mem.zeroes(c_int),
    tm_isdst: c_int = @import("std").mem.zeroes(c_int),
    tm_gmtoff: c_long = @import("std").mem.zeroes(c_long),
    tm_zone: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const clockid_t = __clockid_t;
pub const timer_t = __timer_t;
pub const struct_itimerspec = extern struct {
    it_interval: struct_timespec = @import("std").mem.zeroes(struct_timespec),
    it_value: struct_timespec = @import("std").mem.zeroes(struct_timespec),
};
pub const struct_sigevent = opaque {};
pub const struct___locale_data_2 = opaque {};
pub const struct___locale_struct = extern struct {
    __locales: [13]?*struct___locale_data_2 = @import("std").mem.zeroes([13]?*struct___locale_data_2),
    __ctype_b: [*c]const c_ushort = @import("std").mem.zeroes([*c]const c_ushort),
    __ctype_tolower: [*c]const c_int = @import("std").mem.zeroes([*c]const c_int),
    __ctype_toupper: [*c]const c_int = @import("std").mem.zeroes([*c]const c_int),
    __names: [13][*c]const u8 = @import("std").mem.zeroes([13][*c]const u8),
};
pub const __locale_t = [*c]struct___locale_struct;
pub const locale_t = __locale_t;
pub extern fn clock() clock_t;
pub extern fn time(__timer: [*c]time_t) time_t;
pub extern fn difftime(__time1: time_t, __time0: time_t) f64;
pub extern fn mktime(__tp: [*c]struct_tm) time_t;
pub extern fn strftime(noalias __s: [*c]u8, __maxsize: usize, noalias __format: [*c]const u8, noalias __tp: [*c]const struct_tm) usize;
pub extern fn strftime_l(noalias __s: [*c]u8, __maxsize: usize, noalias __format: [*c]const u8, noalias __tp: [*c]const struct_tm, __loc: locale_t) usize;
pub extern fn gmtime(__timer: [*c]const time_t) [*c]struct_tm;
pub extern fn localtime(__timer: [*c]const time_t) [*c]struct_tm;
pub extern fn gmtime_r(noalias __timer: [*c]const time_t, noalias __tp: [*c]struct_tm) [*c]struct_tm;
pub extern fn localtime_r(noalias __timer: [*c]const time_t, noalias __tp: [*c]struct_tm) [*c]struct_tm;
pub extern fn asctime(__tp: [*c]const struct_tm) [*c]u8;
pub extern fn ctime(__timer: [*c]const time_t) [*c]u8;
pub extern fn asctime_r(noalias __tp: [*c]const struct_tm, noalias __buf: [*c]u8) [*c]u8;
pub extern fn ctime_r(noalias __timer: [*c]const time_t, noalias __buf: [*c]u8) [*c]u8;
pub extern var __tzname: [2][*c]u8;
pub extern var __daylight: c_int;
pub extern var __timezone: c_long;
pub extern var tzname: [2][*c]u8;
pub extern fn tzset() void;
pub extern var daylight: c_int;
pub extern var timezone: c_long;
pub extern fn timegm(__tp: [*c]struct_tm) time_t;
pub extern fn timelocal(__tp: [*c]struct_tm) time_t;
pub extern fn dysize(__year: c_int) c_int;
pub extern fn nanosleep(__requested_time: [*c]const struct_timespec, __remaining: [*c]struct_timespec) c_int;
pub extern fn clock_getres(__clock_id: clockid_t, __res: [*c]struct_timespec) c_int;
pub extern fn clock_gettime(__clock_id: clockid_t, __tp: [*c]struct_timespec) c_int;
pub extern fn clock_settime(__clock_id: clockid_t, __tp: [*c]const struct_timespec) c_int;
pub extern fn clock_nanosleep(__clock_id: clockid_t, __flags: c_int, __req: [*c]const struct_timespec, __rem: [*c]struct_timespec) c_int;
pub extern fn clock_getcpuclockid(__pid: pid_t, __clock_id: [*c]clockid_t) c_int;
pub extern fn timer_create(__clock_id: clockid_t, noalias __evp: ?*struct_sigevent, noalias __timerid: [*c]timer_t) c_int;
pub extern fn timer_delete(__timerid: timer_t) c_int;
pub extern fn timer_settime(__timerid: timer_t, __flags: c_int, noalias __value: [*c]const struct_itimerspec, noalias __ovalue: [*c]struct_itimerspec) c_int;
pub extern fn timer_gettime(__timerid: timer_t, __value: [*c]struct_itimerspec) c_int;
pub extern fn timer_getoverrun(__timerid: timer_t) c_int;
pub extern fn timespec_get(__ts: [*c]struct_timespec, __base: c_int) c_int;
const struct_unnamed_3 = extern struct {
    __low: c_uint = @import("std").mem.zeroes(c_uint),
    __high: c_uint = @import("std").mem.zeroes(c_uint),
};
pub const __atomic_wide_counter = extern union {
    __value64: c_ulonglong,
    __value32: struct_unnamed_3,
};
pub const struct___pthread_internal_list = extern struct {
    __prev: [*c]struct___pthread_internal_list = @import("std").mem.zeroes([*c]struct___pthread_internal_list),
    __next: [*c]struct___pthread_internal_list = @import("std").mem.zeroes([*c]struct___pthread_internal_list),
};
pub const __pthread_list_t = struct___pthread_internal_list;
pub const struct___pthread_internal_slist = extern struct {
    __next: [*c]struct___pthread_internal_slist = @import("std").mem.zeroes([*c]struct___pthread_internal_slist),
};
pub const __pthread_slist_t = struct___pthread_internal_slist;
pub const struct___pthread_mutex_s = extern struct {
    __lock: c_int = @import("std").mem.zeroes(c_int),
    __count: c_uint = @import("std").mem.zeroes(c_uint),
    __owner: c_int = @import("std").mem.zeroes(c_int),
    __nusers: c_uint = @import("std").mem.zeroes(c_uint),
    __kind: c_int = @import("std").mem.zeroes(c_int),
    __spins: c_short = @import("std").mem.zeroes(c_short),
    __elision: c_short = @import("std").mem.zeroes(c_short),
    __list: __pthread_list_t = @import("std").mem.zeroes(__pthread_list_t),
};
pub const struct___pthread_rwlock_arch_t = extern struct {
    __readers: c_uint = @import("std").mem.zeroes(c_uint),
    __writers: c_uint = @import("std").mem.zeroes(c_uint),
    __wrphase_futex: c_uint = @import("std").mem.zeroes(c_uint),
    __writers_futex: c_uint = @import("std").mem.zeroes(c_uint),
    __pad3: c_uint = @import("std").mem.zeroes(c_uint),
    __pad4: c_uint = @import("std").mem.zeroes(c_uint),
    __cur_writer: c_int = @import("std").mem.zeroes(c_int),
    __shared: c_int = @import("std").mem.zeroes(c_int),
    __rwelision: i8 = @import("std").mem.zeroes(i8),
    __pad1: [7]u8 = @import("std").mem.zeroes([7]u8),
    __pad2: c_ulong = @import("std").mem.zeroes(c_ulong),
    __flags: c_uint = @import("std").mem.zeroes(c_uint),
};
pub const struct___pthread_cond_s = extern struct {
    __wseq: __atomic_wide_counter = @import("std").mem.zeroes(__atomic_wide_counter),
    __g1_start: __atomic_wide_counter = @import("std").mem.zeroes(__atomic_wide_counter),
    __g_refs: [2]c_uint = @import("std").mem.zeroes([2]c_uint),
    __g_size: [2]c_uint = @import("std").mem.zeroes([2]c_uint),
    __g1_orig_size: c_uint = @import("std").mem.zeroes(c_uint),
    __wrefs: c_uint = @import("std").mem.zeroes(c_uint),
    __g_signals: [2]c_uint = @import("std").mem.zeroes([2]c_uint),
};
pub const __tss_t = c_uint;
pub const __thrd_t = c_ulong;
pub const __once_flag = extern struct {
    __data: c_int = @import("std").mem.zeroes(c_int),
};
pub const pthread_t = c_ulong;
pub const pthread_mutexattr_t = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub const pthread_condattr_t = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub const pthread_key_t = c_uint;
pub const pthread_once_t = c_int;
pub const union_pthread_attr_t = extern union {
    __size: [56]u8,
    __align: c_long,
};
pub const pthread_attr_t = union_pthread_attr_t;
pub const pthread_mutex_t = extern union {
    __data: struct___pthread_mutex_s,
    __size: [40]u8,
    __align: c_long,
};
pub const pthread_cond_t = extern union {
    __data: struct___pthread_cond_s,
    __size: [48]u8,
    __align: c_longlong,
};
pub const pthread_rwlock_t = extern union {
    __data: struct___pthread_rwlock_arch_t,
    __size: [56]u8,
    __align: c_long,
};
pub const pthread_rwlockattr_t = extern union {
    __size: [8]u8,
    __align: c_long,
};
pub const pthread_spinlock_t = c_int;
pub const pthread_barrier_t = extern union {
    __size: [32]u8,
    __align: c_long,
};
pub const pthread_barrierattr_t = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub const __jmp_buf = [8]c_long;
pub const __sigset_t = extern struct {
    __val: [16]c_ulong = @import("std").mem.zeroes([16]c_ulong),
};
pub const struct___jmp_buf_tag = extern struct {
    __jmpbuf: __jmp_buf = @import("std").mem.zeroes(__jmp_buf),
    __mask_was_saved: c_int = @import("std").mem.zeroes(c_int),
    __saved_mask: __sigset_t = @import("std").mem.zeroes(__sigset_t),
};
pub const PTHREAD_CREATE_JOINABLE: c_int = 0;
pub const PTHREAD_CREATE_DETACHED: c_int = 1;
const enum_unnamed_4 = c_uint;
pub const PTHREAD_MUTEX_TIMED_NP: c_int = 0;
pub const PTHREAD_MUTEX_RECURSIVE_NP: c_int = 1;
pub const PTHREAD_MUTEX_ERRORCHECK_NP: c_int = 2;
pub const PTHREAD_MUTEX_ADAPTIVE_NP: c_int = 3;
pub const PTHREAD_MUTEX_NORMAL: c_int = 0;
pub const PTHREAD_MUTEX_RECURSIVE: c_int = 1;
pub const PTHREAD_MUTEX_ERRORCHECK: c_int = 2;
pub const PTHREAD_MUTEX_DEFAULT: c_int = 0;
const enum_unnamed_5 = c_uint;
pub const PTHREAD_MUTEX_STALLED: c_int = 0;
pub const PTHREAD_MUTEX_STALLED_NP: c_int = 0;
pub const PTHREAD_MUTEX_ROBUST: c_int = 1;
pub const PTHREAD_MUTEX_ROBUST_NP: c_int = 1;
const enum_unnamed_6 = c_uint;
pub const PTHREAD_PRIO_NONE: c_int = 0;
pub const PTHREAD_PRIO_INHERIT: c_int = 1;
pub const PTHREAD_PRIO_PROTECT: c_int = 2;
const enum_unnamed_7 = c_uint;
pub const PTHREAD_RWLOCK_PREFER_READER_NP: c_int = 0;
pub const PTHREAD_RWLOCK_PREFER_WRITER_NP: c_int = 1;
pub const PTHREAD_RWLOCK_PREFER_WRITER_NONRECURSIVE_NP: c_int = 2;
pub const PTHREAD_RWLOCK_DEFAULT_NP: c_int = 0;
const enum_unnamed_8 = c_uint;
pub const PTHREAD_INHERIT_SCHED: c_int = 0;
pub const PTHREAD_EXPLICIT_SCHED: c_int = 1;
const enum_unnamed_9 = c_uint;
pub const PTHREAD_SCOPE_SYSTEM: c_int = 0;
pub const PTHREAD_SCOPE_PROCESS: c_int = 1;
const enum_unnamed_10 = c_uint;
pub const PTHREAD_PROCESS_PRIVATE: c_int = 0;
pub const PTHREAD_PROCESS_SHARED: c_int = 1;
const enum_unnamed_11 = c_uint;
pub const struct__pthread_cleanup_buffer = extern struct {
    __routine: ?*const fn (?*anyopaque) callconv(.C) void = @import("std").mem.zeroes(?*const fn (?*anyopaque) callconv(.C) void),
    __arg: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    __canceltype: c_int = @import("std").mem.zeroes(c_int),
    __prev: [*c]struct__pthread_cleanup_buffer = @import("std").mem.zeroes([*c]struct__pthread_cleanup_buffer),
};
pub const PTHREAD_CANCEL_ENABLE: c_int = 0;
pub const PTHREAD_CANCEL_DISABLE: c_int = 1;
const enum_unnamed_12 = c_uint;
pub const PTHREAD_CANCEL_DEFERRED: c_int = 0;
pub const PTHREAD_CANCEL_ASYNCHRONOUS: c_int = 1;
const enum_unnamed_13 = c_uint;
pub extern fn pthread_create(noalias __newthread: [*c]pthread_t, noalias __attr: [*c]const pthread_attr_t, __start_routine: ?*const fn (?*anyopaque) callconv(.C) ?*anyopaque, noalias __arg: ?*anyopaque) c_int;
pub extern fn pthread_exit(__retval: ?*anyopaque) noreturn;
pub extern fn pthread_join(__th: pthread_t, __thread_return: [*c]?*anyopaque) c_int;
pub extern fn pthread_detach(__th: pthread_t) c_int;
pub extern fn pthread_self() pthread_t;
pub extern fn pthread_equal(__thread1: pthread_t, __thread2: pthread_t) c_int;
pub extern fn pthread_attr_init(__attr: [*c]pthread_attr_t) c_int;
pub extern fn pthread_attr_destroy(__attr: [*c]pthread_attr_t) c_int;
pub extern fn pthread_attr_getdetachstate(__attr: [*c]const pthread_attr_t, __detachstate: [*c]c_int) c_int;
pub extern fn pthread_attr_setdetachstate(__attr: [*c]pthread_attr_t, __detachstate: c_int) c_int;
pub extern fn pthread_attr_getguardsize(__attr: [*c]const pthread_attr_t, __guardsize: [*c]usize) c_int;
pub extern fn pthread_attr_setguardsize(__attr: [*c]pthread_attr_t, __guardsize: usize) c_int;
pub extern fn pthread_attr_getschedparam(noalias __attr: [*c]const pthread_attr_t, noalias __param: [*c]struct_sched_param) c_int;
pub extern fn pthread_attr_setschedparam(noalias __attr: [*c]pthread_attr_t, noalias __param: [*c]const struct_sched_param) c_int;
pub extern fn pthread_attr_getschedpolicy(noalias __attr: [*c]const pthread_attr_t, noalias __policy: [*c]c_int) c_int;
pub extern fn pthread_attr_setschedpolicy(__attr: [*c]pthread_attr_t, __policy: c_int) c_int;
pub extern fn pthread_attr_getinheritsched(noalias __attr: [*c]const pthread_attr_t, noalias __inherit: [*c]c_int) c_int;
pub extern fn pthread_attr_setinheritsched(__attr: [*c]pthread_attr_t, __inherit: c_int) c_int;
pub extern fn pthread_attr_getscope(noalias __attr: [*c]const pthread_attr_t, noalias __scope: [*c]c_int) c_int;
pub extern fn pthread_attr_setscope(__attr: [*c]pthread_attr_t, __scope: c_int) c_int;
pub extern fn pthread_attr_getstackaddr(noalias __attr: [*c]const pthread_attr_t, noalias __stackaddr: [*c]?*anyopaque) c_int;
pub extern fn pthread_attr_setstackaddr(__attr: [*c]pthread_attr_t, __stackaddr: ?*anyopaque) c_int;
pub extern fn pthread_attr_getstacksize(noalias __attr: [*c]const pthread_attr_t, noalias __stacksize: [*c]usize) c_int;
pub extern fn pthread_attr_setstacksize(__attr: [*c]pthread_attr_t, __stacksize: usize) c_int;
pub extern fn pthread_attr_getstack(noalias __attr: [*c]const pthread_attr_t, noalias __stackaddr: [*c]?*anyopaque, noalias __stacksize: [*c]usize) c_int;
pub extern fn pthread_attr_setstack(__attr: [*c]pthread_attr_t, __stackaddr: ?*anyopaque, __stacksize: usize) c_int;
pub extern fn pthread_setschedparam(__target_thread: pthread_t, __policy: c_int, __param: [*c]const struct_sched_param) c_int;
pub extern fn pthread_getschedparam(__target_thread: pthread_t, noalias __policy: [*c]c_int, noalias __param: [*c]struct_sched_param) c_int;
pub extern fn pthread_setschedprio(__target_thread: pthread_t, __prio: c_int) c_int;
pub extern fn pthread_once(__once_control: [*c]pthread_once_t, __init_routine: ?*const fn () callconv(.C) void) c_int;
pub extern fn pthread_setcancelstate(__state: c_int, __oldstate: [*c]c_int) c_int;
pub extern fn pthread_setcanceltype(__type: c_int, __oldtype: [*c]c_int) c_int;
pub extern fn pthread_cancel(__th: pthread_t) c_int;
pub extern fn pthread_testcancel() void;
pub const struct___cancel_jmp_buf_tag = extern struct {
    __cancel_jmp_buf: __jmp_buf = @import("std").mem.zeroes(__jmp_buf),
    __mask_was_saved: c_int = @import("std").mem.zeroes(c_int),
};
pub const __pthread_unwind_buf_t = extern struct {
    __cancel_jmp_buf: [1]struct___cancel_jmp_buf_tag = @import("std").mem.zeroes([1]struct___cancel_jmp_buf_tag),
    __pad: [4]?*anyopaque = @import("std").mem.zeroes([4]?*anyopaque),
};
pub const struct___pthread_cleanup_frame = extern struct {
    __cancel_routine: ?*const fn (?*anyopaque) callconv(.C) void = @import("std").mem.zeroes(?*const fn (?*anyopaque) callconv(.C) void),
    __cancel_arg: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    __do_it: c_int = @import("std").mem.zeroes(c_int),
    __cancel_type: c_int = @import("std").mem.zeroes(c_int),
};
pub extern fn __pthread_register_cancel(__buf: [*c]__pthread_unwind_buf_t) void;
pub extern fn __pthread_unregister_cancel(__buf: [*c]__pthread_unwind_buf_t) void;
pub extern fn __pthread_unwind_next(__buf: [*c]__pthread_unwind_buf_t) noreturn;
pub extern fn __sigsetjmp(__env: [*c]struct___jmp_buf_tag, __savemask: c_int) c_int;
pub extern fn pthread_mutex_init(__mutex: [*c]pthread_mutex_t, __mutexattr: [*c]const pthread_mutexattr_t) c_int;
pub extern fn pthread_mutex_destroy(__mutex: [*c]pthread_mutex_t) c_int;
pub extern fn pthread_mutex_trylock(__mutex: [*c]pthread_mutex_t) c_int;
pub extern fn pthread_mutex_lock(__mutex: [*c]pthread_mutex_t) c_int;
pub extern fn pthread_mutex_timedlock(noalias __mutex: [*c]pthread_mutex_t, noalias __abstime: [*c]const struct_timespec) c_int;
pub extern fn pthread_mutex_unlock(__mutex: [*c]pthread_mutex_t) c_int;
pub extern fn pthread_mutex_getprioceiling(noalias __mutex: [*c]const pthread_mutex_t, noalias __prioceiling: [*c]c_int) c_int;
pub extern fn pthread_mutex_setprioceiling(noalias __mutex: [*c]pthread_mutex_t, __prioceiling: c_int, noalias __old_ceiling: [*c]c_int) c_int;
pub extern fn pthread_mutex_consistent(__mutex: [*c]pthread_mutex_t) c_int;
pub extern fn pthread_mutexattr_init(__attr: [*c]pthread_mutexattr_t) c_int;
pub extern fn pthread_mutexattr_destroy(__attr: [*c]pthread_mutexattr_t) c_int;
pub extern fn pthread_mutexattr_getpshared(noalias __attr: [*c]const pthread_mutexattr_t, noalias __pshared: [*c]c_int) c_int;
pub extern fn pthread_mutexattr_setpshared(__attr: [*c]pthread_mutexattr_t, __pshared: c_int) c_int;
pub extern fn pthread_mutexattr_gettype(noalias __attr: [*c]const pthread_mutexattr_t, noalias __kind: [*c]c_int) c_int;
pub extern fn pthread_mutexattr_settype(__attr: [*c]pthread_mutexattr_t, __kind: c_int) c_int;
pub extern fn pthread_mutexattr_getprotocol(noalias __attr: [*c]const pthread_mutexattr_t, noalias __protocol: [*c]c_int) c_int;
pub extern fn pthread_mutexattr_setprotocol(__attr: [*c]pthread_mutexattr_t, __protocol: c_int) c_int;
pub extern fn pthread_mutexattr_getprioceiling(noalias __attr: [*c]const pthread_mutexattr_t, noalias __prioceiling: [*c]c_int) c_int;
pub extern fn pthread_mutexattr_setprioceiling(__attr: [*c]pthread_mutexattr_t, __prioceiling: c_int) c_int;
pub extern fn pthread_mutexattr_getrobust(__attr: [*c]const pthread_mutexattr_t, __robustness: [*c]c_int) c_int;
pub extern fn pthread_mutexattr_setrobust(__attr: [*c]pthread_mutexattr_t, __robustness: c_int) c_int;
pub extern fn pthread_rwlock_init(noalias __rwlock: [*c]pthread_rwlock_t, noalias __attr: [*c]const pthread_rwlockattr_t) c_int;
pub extern fn pthread_rwlock_destroy(__rwlock: [*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlock_rdlock(__rwlock: [*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlock_tryrdlock(__rwlock: [*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlock_timedrdlock(noalias __rwlock: [*c]pthread_rwlock_t, noalias __abstime: [*c]const struct_timespec) c_int;
pub extern fn pthread_rwlock_wrlock(__rwlock: [*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlock_trywrlock(__rwlock: [*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlock_timedwrlock(noalias __rwlock: [*c]pthread_rwlock_t, noalias __abstime: [*c]const struct_timespec) c_int;
pub extern fn pthread_rwlock_unlock(__rwlock: [*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlockattr_init(__attr: [*c]pthread_rwlockattr_t) c_int;
pub extern fn pthread_rwlockattr_destroy(__attr: [*c]pthread_rwlockattr_t) c_int;
pub extern fn pthread_rwlockattr_getpshared(noalias __attr: [*c]const pthread_rwlockattr_t, noalias __pshared: [*c]c_int) c_int;
pub extern fn pthread_rwlockattr_setpshared(__attr: [*c]pthread_rwlockattr_t, __pshared: c_int) c_int;
pub extern fn pthread_rwlockattr_getkind_np(noalias __attr: [*c]const pthread_rwlockattr_t, noalias __pref: [*c]c_int) c_int;
pub extern fn pthread_rwlockattr_setkind_np(__attr: [*c]pthread_rwlockattr_t, __pref: c_int) c_int;
pub extern fn pthread_cond_init(noalias __cond: [*c]pthread_cond_t, noalias __cond_attr: [*c]const pthread_condattr_t) c_int;
pub extern fn pthread_cond_destroy(__cond: [*c]pthread_cond_t) c_int;
pub extern fn pthread_cond_signal(__cond: [*c]pthread_cond_t) c_int;
pub extern fn pthread_cond_broadcast(__cond: [*c]pthread_cond_t) c_int;
pub extern fn pthread_cond_wait(noalias __cond: [*c]pthread_cond_t, noalias __mutex: [*c]pthread_mutex_t) c_int;
pub extern fn pthread_cond_timedwait(noalias __cond: [*c]pthread_cond_t, noalias __mutex: [*c]pthread_mutex_t, noalias __abstime: [*c]const struct_timespec) c_int;
pub extern fn pthread_condattr_init(__attr: [*c]pthread_condattr_t) c_int;
pub extern fn pthread_condattr_destroy(__attr: [*c]pthread_condattr_t) c_int;
pub extern fn pthread_condattr_getpshared(noalias __attr: [*c]const pthread_condattr_t, noalias __pshared: [*c]c_int) c_int;
pub extern fn pthread_condattr_setpshared(__attr: [*c]pthread_condattr_t, __pshared: c_int) c_int;
pub extern fn pthread_condattr_getclock(noalias __attr: [*c]const pthread_condattr_t, noalias __clock_id: [*c]__clockid_t) c_int;
pub extern fn pthread_condattr_setclock(__attr: [*c]pthread_condattr_t, __clock_id: __clockid_t) c_int;
pub extern fn pthread_spin_init(__lock: [*c]volatile pthread_spinlock_t, __pshared: c_int) c_int;
pub extern fn pthread_spin_destroy(__lock: [*c]volatile pthread_spinlock_t) c_int;
pub extern fn pthread_spin_lock(__lock: [*c]volatile pthread_spinlock_t) c_int;
pub extern fn pthread_spin_trylock(__lock: [*c]volatile pthread_spinlock_t) c_int;
pub extern fn pthread_spin_unlock(__lock: [*c]volatile pthread_spinlock_t) c_int;
pub extern fn pthread_barrier_init(noalias __barrier: [*c]pthread_barrier_t, noalias __attr: [*c]const pthread_barrierattr_t, __count: c_uint) c_int;
pub extern fn pthread_barrier_destroy(__barrier: [*c]pthread_barrier_t) c_int;
pub extern fn pthread_barrier_wait(__barrier: [*c]pthread_barrier_t) c_int;
pub extern fn pthread_barrierattr_init(__attr: [*c]pthread_barrierattr_t) c_int;
pub extern fn pthread_barrierattr_destroy(__attr: [*c]pthread_barrierattr_t) c_int;
pub extern fn pthread_barrierattr_getpshared(noalias __attr: [*c]const pthread_barrierattr_t, noalias __pshared: [*c]c_int) c_int;
pub extern fn pthread_barrierattr_setpshared(__attr: [*c]pthread_barrierattr_t, __pshared: c_int) c_int;
pub extern fn pthread_key_create(__key: [*c]pthread_key_t, __destr_function: ?*const fn (?*anyopaque) callconv(.C) void) c_int;
pub extern fn pthread_key_delete(__key: pthread_key_t) c_int;
pub extern fn pthread_getspecific(__key: pthread_key_t) ?*anyopaque;
pub extern fn pthread_setspecific(__key: pthread_key_t, __pointer: ?*const anyopaque) c_int;
pub extern fn pthread_getcpuclockid(__thread_id: pthread_t, __clock_id: [*c]__clockid_t) c_int;
pub extern fn pthread_atfork(__prepare: ?*const fn () callconv(.C) void, __parent: ?*const fn () callconv(.C) void, __child: ?*const fn () callconv(.C) void) c_int;
pub const u_char = __u_char;
pub const u_short = __u_short;
pub const u_int = __u_int;
pub const u_long = __u_long;
pub const quad_t = __quad_t;
pub const u_quad_t = __u_quad_t;
pub const fsid_t = __fsid_t;
pub const loff_t = __loff_t;
pub const ino_t = __ino_t;
pub const dev_t = __dev_t;
pub const gid_t = __gid_t;
pub const mode_t = __mode_t;
pub const nlink_t = __nlink_t;
pub const uid_t = __uid_t;
pub const off_t = __off_t;
pub const id_t = __id_t;
pub const daddr_t = __daddr_t;
pub const caddr_t = __caddr_t;
pub const key_t = __key_t;
pub const ulong = c_ulong;
pub const ushort = c_ushort;
pub const uint = c_uint;
pub const u_int8_t = __uint8_t;
pub const u_int16_t = __uint16_t;
pub const u_int32_t = __uint32_t;
pub const u_int64_t = __uint64_t;
pub const register_t = c_long;
pub fn __bswap_16(arg___bsx: __uint16_t) callconv(.C) __uint16_t {
    var __bsx = arg___bsx;
    _ = &__bsx;
    return @as(__uint16_t, @bitCast(@as(c_short, @truncate(((@as(c_int, @bitCast(@as(c_uint, __bsx))) >> @intCast(8)) & @as(c_int, 255)) | ((@as(c_int, @bitCast(@as(c_uint, __bsx))) & @as(c_int, 255)) << @intCast(8))))));
}
pub fn __bswap_32(arg___bsx: __uint32_t) callconv(.C) __uint32_t {
    var __bsx = arg___bsx;
    _ = &__bsx;
    return ((((__bsx & @as(c_uint, 4278190080)) >> @intCast(24)) | ((__bsx & @as(c_uint, 16711680)) >> @intCast(8))) | ((__bsx & @as(c_uint, 65280)) << @intCast(8))) | ((__bsx & @as(c_uint, 255)) << @intCast(24));
}
pub fn __bswap_64(arg___bsx: __uint64_t) callconv(.C) __uint64_t {
    var __bsx = arg___bsx;
    _ = &__bsx;
    return @as(__uint64_t, @bitCast(@as(c_ulong, @truncate(((((((((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 18374686479671623680)) >> @intCast(56)) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 71776119061217280)) >> @intCast(40))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 280375465082880)) >> @intCast(24))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 1095216660480)) >> @intCast(8))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 4278190080)) << @intCast(8))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 16711680)) << @intCast(24))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 65280)) << @intCast(40))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 255)) << @intCast(56))))));
}
pub fn __uint16_identity(arg___x: __uint16_t) callconv(.C) __uint16_t {
    var __x = arg___x;
    _ = &__x;
    return __x;
}
pub fn __uint32_identity(arg___x: __uint32_t) callconv(.C) __uint32_t {
    var __x = arg___x;
    _ = &__x;
    return __x;
}
pub fn __uint64_identity(arg___x: __uint64_t) callconv(.C) __uint64_t {
    var __x = arg___x;
    _ = &__x;
    return __x;
}
pub const sigset_t = __sigset_t;
pub const struct_timeval = extern struct {
    tv_sec: __time_t = @import("std").mem.zeroes(__time_t),
    tv_usec: __suseconds_t = @import("std").mem.zeroes(__suseconds_t),
};
pub const suseconds_t = __suseconds_t;
pub const __fd_mask = c_long;
pub const fd_set = extern struct {
    __fds_bits: [16]__fd_mask = @import("std").mem.zeroes([16]__fd_mask),
};
pub const fd_mask = __fd_mask;
pub extern fn select(__nfds: c_int, noalias __readfds: [*c]fd_set, noalias __writefds: [*c]fd_set, noalias __exceptfds: [*c]fd_set, noalias __timeout: [*c]struct_timeval) c_int;
pub extern fn pselect(__nfds: c_int, noalias __readfds: [*c]fd_set, noalias __writefds: [*c]fd_set, noalias __exceptfds: [*c]fd_set, noalias __timeout: [*c]const struct_timespec, noalias __sigmask: [*c]const __sigset_t) c_int;
pub const blksize_t = __blksize_t;
pub const blkcnt_t = __blkcnt_t;
pub const fsblkcnt_t = __fsblkcnt_t;
pub const fsfilcnt_t = __fsfilcnt_t;
pub const struct_iovec = extern struct {
    iov_base: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    iov_len: usize = @import("std").mem.zeroes(usize),
};
pub extern fn readv(__fd: c_int, __iovec: [*c]const struct_iovec, __count: c_int) isize;
pub extern fn writev(__fd: c_int, __iovec: [*c]const struct_iovec, __count: c_int) isize;
pub extern fn preadv(__fd: c_int, __iovec: [*c]const struct_iovec, __count: c_int, __offset: __off_t) isize;
pub extern fn pwritev(__fd: c_int, __iovec: [*c]const struct_iovec, __count: c_int, __offset: __off_t) isize;
pub const mdbx_filehandle_t = c_int;
pub const mdbx_pid_t = pid_t;
pub const mdbx_tid_t = pthread_t;
pub const mdbx_mode_t = mode_t;
const struct_unnamed_14 = extern struct {
    datetime: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    tree: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    commit: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    describe: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const struct_MDBX_version_info = extern struct {
    major: u8 = @import("std").mem.zeroes(u8),
    minor: u8 = @import("std").mem.zeroes(u8),
    release: u16 = @import("std").mem.zeroes(u16),
    revision: u32 = @import("std").mem.zeroes(u32),
    git: struct_unnamed_14 = @import("std").mem.zeroes(struct_unnamed_14),
    sourcery: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub extern const mdbx_version: struct_MDBX_version_info;
pub const struct_MDBX_build_info = extern struct {
    datetime: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    target: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    options: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    compiler: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    flags: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub extern const mdbx_build: struct_MDBX_build_info;
pub const struct_MDBX_env = opaque {};
pub const MDBX_env = struct_MDBX_env;
pub const struct_MDBX_txn = opaque {};
pub const MDBX_txn = struct_MDBX_txn;
pub const MDBX_dbi = u32;
pub const struct_MDBX_cursor = opaque {};
pub const MDBX_cursor = struct_MDBX_cursor;
pub const MDBX_val = struct_iovec;
pub const MDBX_MAX_DBI: c_int = 32765;
pub const MDBX_MAXDATASIZE: c_int = 2147418112;
pub const MDBX_MIN_PAGESIZE: c_int = 256;
pub const MDBX_MAX_PAGESIZE: c_int = 65536;
pub const enum_MDBX_constants = c_uint;
pub const MDBX_LOG_FATAL: c_int = 0;
pub const MDBX_LOG_ERROR: c_int = 1;
pub const MDBX_LOG_WARN: c_int = 2;
pub const MDBX_LOG_NOTICE: c_int = 3;
pub const MDBX_LOG_VERBOSE: c_int = 4;
pub const MDBX_LOG_DEBUG: c_int = 5;
pub const MDBX_LOG_TRACE: c_int = 6;
pub const MDBX_LOG_EXTRA: c_int = 7;
pub const MDBX_LOG_DONTCHANGE: c_int = -1;
pub const enum_MDBX_log_level = c_int;
pub const MDBX_log_level_t = enum_MDBX_log_level;
pub const MDBX_DBG_NONE: c_int = 0;
pub const MDBX_DBG_ASSERT: c_int = 1;
pub const MDBX_DBG_AUDIT: c_int = 2;
pub const MDBX_DBG_JITTER: c_int = 4;
pub const MDBX_DBG_DUMP: c_int = 8;
pub const MDBX_DBG_LEGACY_MULTIOPEN: c_int = 16;
pub const MDBX_DBG_LEGACY_OVERLAP: c_int = 32;
pub const MDBX_DBG_DONT_UPGRADE: c_int = 64;
pub const MDBX_DBG_DONTCHANGE: c_int = -1;
pub const enum_MDBX_debug_flags = c_int;
pub const MDBX_debug_flags_t = enum_MDBX_debug_flags;
pub const MDBX_debug_func = fn (MDBX_log_level_t, [*c]const u8, c_int, [*c]const u8, [*c]struct___va_list_tag_1) callconv(.C) void;
pub extern fn mdbx_setup_debug(log_level: MDBX_log_level_t, debug_flags: MDBX_debug_flags_t, logger: ?*const MDBX_debug_func) c_int;
pub const MDBX_debug_func_nofmt = fn (MDBX_log_level_t, [*c]const u8, c_int, [*c]const u8, c_uint) callconv(.C) void;
pub extern fn mdbx_setup_debug_nofmt(log_level: MDBX_log_level_t, debug_flags: MDBX_debug_flags_t, logger: ?*const MDBX_debug_func_nofmt, logger_buffer: [*c]u8, logger_buffer_size: usize) c_int;
pub const MDBX_assert_func = fn (?*const MDBX_env, [*c]const u8, [*c]const u8, c_uint) callconv(.C) void;
pub extern fn mdbx_env_set_assert(env: ?*MDBX_env, func: ?*const MDBX_assert_func) c_int;
pub extern fn mdbx_dump_val(key: [*c]const MDBX_val, buf: [*c]u8, bufsize: usize) [*c]const u8;
pub extern fn mdbx_panic(fmt: [*c]const u8, ...) noreturn;
pub extern fn mdbx_assert_fail(env: ?*const MDBX_env, msg: [*c]const u8, func: [*c]const u8, line: c_uint) noreturn;
pub const MDBX_ENV_DEFAULTS: c_int = 0;
pub const MDBX_VALIDATION: c_int = 8192;
pub const MDBX_NOSUBDIR: c_int = 16384;
pub const MDBX_RDONLY: c_int = 131072;
pub const MDBX_EXCLUSIVE: c_int = 4194304;
pub const MDBX_ACCEDE: c_int = 1073741824;
pub const MDBX_WRITEMAP: c_int = 524288;
pub const MDBX_NOSTICKYTHREADS: c_int = 2097152;
pub const MDBX_NOTLS: c_int = 2097152;
pub const MDBX_NORDAHEAD: c_int = 8388608;
pub const MDBX_NOMEMINIT: c_int = 16777216;
pub const MDBX_COALESCE: c_int = 33554432;
pub const MDBX_LIFORECLAIM: c_int = 67108864;
pub const MDBX_PAGEPERTURB: c_int = 134217728;
pub const MDBX_SYNC_DURABLE: c_int = 0;
pub const MDBX_NOMETASYNC: c_int = 262144;
pub const MDBX_SAFE_NOSYNC: c_int = 65536;
pub const MDBX_MAPASYNC: c_int = 65536;
pub const MDBX_UTTERLY_NOSYNC: c_int = 1114112;
pub const enum_MDBX_env_flags = c_uint;
pub const MDBX_env_flags_t = enum_MDBX_env_flags;
pub const MDBX_TXN_READWRITE: c_int = 0;
pub const MDBX_TXN_RDONLY: c_int = 131072;
pub const MDBX_TXN_RDONLY_PREPARE: c_int = 16908288;
pub const MDBX_TXN_TRY: c_int = 268435456;
pub const MDBX_TXN_NOMETASYNC: c_int = 262144;
pub const MDBX_TXN_NOSYNC: c_int = 65536;
pub const MDBX_TXN_INVALID: c_int = -2147483648;
pub const MDBX_TXN_FINISHED: c_int = 1;
pub const MDBX_TXN_ERROR: c_int = 2;
pub const MDBX_TXN_DIRTY: c_int = 4;
pub const MDBX_TXN_SPILLS: c_int = 8;
pub const MDBX_TXN_HAS_CHILD: c_int = 16;
pub const MDBX_TXN_PARKED: c_int = 32;
pub const MDBX_TXN_AUTOUNPARK: c_int = 64;
pub const MDBX_TXN_OUSTED: c_int = 128;
pub const MDBX_TXN_BLOCKED: c_int = 51;
pub const enum_MDBX_txn_flags = c_int;
pub const MDBX_txn_flags_t = enum_MDBX_txn_flags;
pub const MDBX_DB_DEFAULTS: c_int = 0;
pub const MDBX_REVERSEKEY: c_int = 2;
pub const MDBX_DUPSORT: c_int = 4;
pub const MDBX_INTEGERKEY: c_int = 8;
pub const MDBX_DUPFIXED: c_int = 16;
pub const MDBX_INTEGERDUP: c_int = 32;
pub const MDBX_REVERSEDUP: c_int = 64;
pub const MDBX_CREATE: c_int = 262144;
pub const MDBX_DB_ACCEDE: c_int = 1073741824;
pub const enum_MDBX_db_flags = c_uint;
pub const MDBX_db_flags_t = enum_MDBX_db_flags;
pub const MDBX_UPSERT: c_int = 0;
pub const MDBX_NOOVERWRITE: c_int = 16;
pub const MDBX_NODUPDATA: c_int = 32;
pub const MDBX_CURRENT: c_int = 64;
pub const MDBX_ALLDUPS: c_int = 128;
pub const MDBX_RESERVE: c_int = 65536;
pub const MDBX_APPEND: c_int = 131072;
pub const MDBX_APPENDDUP: c_int = 262144;
pub const MDBX_MULTIPLE: c_int = 524288;
pub const enum_MDBX_put_flags = c_uint;
pub const MDBX_put_flags_t = enum_MDBX_put_flags;
pub const MDBX_CP_DEFAULTS: c_int = 0;
pub const MDBX_CP_COMPACT: c_int = 1;
pub const MDBX_CP_FORCE_DYNAMIC_SIZE: c_int = 2;
pub const MDBX_CP_DONT_FLUSH: c_int = 4;
pub const MDBX_CP_THROTTLE_MVCC: c_int = 8;
pub const MDBX_CP_DISPOSE_TXN: c_int = 16;
pub const MDBX_CP_RENEW_TXN: c_int = 32;
pub const enum_MDBX_copy_flags = c_uint;
pub const MDBX_copy_flags_t = enum_MDBX_copy_flags;
pub const MDBX_FIRST: c_int = 0;
pub const MDBX_FIRST_DUP: c_int = 1;
pub const MDBX_GET_BOTH: c_int = 2;
pub const MDBX_GET_BOTH_RANGE: c_int = 3;
pub const MDBX_GET_CURRENT: c_int = 4;
pub const MDBX_GET_MULTIPLE: c_int = 5;
pub const MDBX_LAST: c_int = 6;
pub const MDBX_LAST_DUP: c_int = 7;
pub const MDBX_NEXT: c_int = 8;
pub const MDBX_NEXT_DUP: c_int = 9;
pub const MDBX_NEXT_MULTIPLE: c_int = 10;
pub const MDBX_NEXT_NODUP: c_int = 11;
pub const MDBX_PREV: c_int = 12;
pub const MDBX_PREV_DUP: c_int = 13;
pub const MDBX_PREV_NODUP: c_int = 14;
pub const MDBX_SET: c_int = 15;
pub const MDBX_SET_KEY: c_int = 16;
pub const MDBX_SET_RANGE: c_int = 17;
pub const MDBX_PREV_MULTIPLE: c_int = 18;
pub const MDBX_SET_LOWERBOUND: c_int = 19;
pub const MDBX_SET_UPPERBOUND: c_int = 20;
pub const MDBX_TO_KEY_LESSER_THAN: c_int = 21;
pub const MDBX_TO_KEY_LESSER_OR_EQUAL: c_int = 22;
pub const MDBX_TO_KEY_EQUAL: c_int = 23;
pub const MDBX_TO_KEY_GREATER_OR_EQUAL: c_int = 24;
pub const MDBX_TO_KEY_GREATER_THAN: c_int = 25;
pub const MDBX_TO_EXACT_KEY_VALUE_LESSER_THAN: c_int = 26;
pub const MDBX_TO_EXACT_KEY_VALUE_LESSER_OR_EQUAL: c_int = 27;
pub const MDBX_TO_EXACT_KEY_VALUE_EQUAL: c_int = 28;
pub const MDBX_TO_EXACT_KEY_VALUE_GREATER_OR_EQUAL: c_int = 29;
pub const MDBX_TO_EXACT_KEY_VALUE_GREATER_THAN: c_int = 30;
pub const MDBX_TO_PAIR_LESSER_THAN: c_int = 31;
pub const MDBX_TO_PAIR_LESSER_OR_EQUAL: c_int = 32;
pub const MDBX_TO_PAIR_EQUAL: c_int = 33;
pub const MDBX_TO_PAIR_GREATER_OR_EQUAL: c_int = 34;
pub const MDBX_TO_PAIR_GREATER_THAN: c_int = 35;
pub const enum_MDBX_cursor_op = c_uint;
pub const MDBX_cursor_op = enum_MDBX_cursor_op;
pub const MDBX_SUCCESS: c_int = 0;
pub const MDBX_RESULT_FALSE: c_int = 0;
pub const MDBX_RESULT_TRUE: c_int = -1;
pub const MDBX_KEYEXIST: c_int = -30799;
pub const MDBX_FIRST_LMDB_ERRCODE: c_int = -30799;
pub const MDBX_NOTFOUND: c_int = -30798;
pub const MDBX_PAGE_NOTFOUND: c_int = -30797;
pub const MDBX_CORRUPTED: c_int = -30796;
pub const MDBX_PANIC: c_int = -30795;
pub const MDBX_VERSION_MISMATCH: c_int = -30794;
pub const MDBX_INVALID: c_int = -30793;
pub const MDBX_MAP_FULL: c_int = -30792;
pub const MDBX_DBS_FULL: c_int = -30791;
pub const MDBX_READERS_FULL: c_int = -30790;
pub const MDBX_TXN_FULL: c_int = -30788;
pub const MDBX_CURSOR_FULL: c_int = -30787;
pub const MDBX_PAGE_FULL: c_int = -30786;
pub const MDBX_UNABLE_EXTEND_MAPSIZE: c_int = -30785;
pub const MDBX_INCOMPATIBLE: c_int = -30784;
pub const MDBX_BAD_RSLOT: c_int = -30783;
pub const MDBX_BAD_TXN: c_int = -30782;
pub const MDBX_BAD_VALSIZE: c_int = -30781;
pub const MDBX_BAD_DBI: c_int = -30780;
pub const MDBX_PROBLEM: c_int = -30779;
pub const MDBX_LAST_LMDB_ERRCODE: c_int = -30779;
pub const MDBX_BUSY: c_int = -30778;
pub const MDBX_FIRST_ADDED_ERRCODE: c_int = -30778;
pub const MDBX_EMULTIVAL: c_int = -30421;
pub const MDBX_EBADSIGN: c_int = -30420;
pub const MDBX_WANNA_RECOVERY: c_int = -30419;
pub const MDBX_EKEYMISMATCH: c_int = -30418;
pub const MDBX_TOO_LARGE: c_int = -30417;
pub const MDBX_THREAD_MISMATCH: c_int = -30416;
pub const MDBX_TXN_OVERLAPPING: c_int = -30415;
pub const MDBX_BACKLOG_DEPLETED: c_int = -30414;
pub const MDBX_DUPLICATED_CLK: c_int = -30413;
pub const MDBX_DANGLING_DBI: c_int = -30412;
pub const MDBX_OUSTED: c_int = -30411;
pub const MDBX_MVCC_RETARDED: c_int = -30410;
pub const MDBX_LAST_ADDED_ERRCODE: c_int = -30410;
pub const MDBX_ENODATA: c_int = 61;
pub const MDBX_EINVAL: c_int = 22;
pub const MDBX_EACCESS: c_int = 13;
pub const MDBX_ENOMEM: c_int = 12;
pub const MDBX_EROFS: c_int = 30;
pub const MDBX_ENOSYS: c_int = 38;
pub const MDBX_EIO: c_int = 5;
pub const MDBX_EPERM: c_int = 1;
pub const MDBX_EINTR: c_int = 4;
pub const MDBX_ENOFILE: c_int = 2;
pub const MDBX_EREMOTE: c_int = 15;
pub const MDBX_EDEADLK: c_int = 35;
pub const enum_MDBX_error = c_int;
pub const MDBX_error_t = enum_MDBX_error;
pub fn MDBX_MAP_RESIZED_is_deprecated() callconv(.C) c_int {
    return MDBX_UNABLE_EXTEND_MAPSIZE;
}
pub extern fn mdbx_strerror(errnum: c_int) [*c]const u8;
pub extern fn mdbx_strerror_r(errnum: c_int, buf: [*c]u8, buflen: usize) [*c]const u8;
pub extern fn mdbx_liberr2str(errnum: c_int) [*c]const u8;
pub extern fn mdbx_env_create(penv: [*c]?*MDBX_env) c_int;
pub const MDBX_opt_max_db: c_int = 0;
pub const MDBX_opt_max_readers: c_int = 1;
pub const MDBX_opt_sync_bytes: c_int = 2;
pub const MDBX_opt_sync_period: c_int = 3;
pub const MDBX_opt_rp_augment_limit: c_int = 4;
pub const MDBX_opt_loose_limit: c_int = 5;
pub const MDBX_opt_dp_reserve_limit: c_int = 6;
pub const MDBX_opt_txn_dp_limit: c_int = 7;
pub const MDBX_opt_txn_dp_initial: c_int = 8;
pub const MDBX_opt_spill_max_denominator: c_int = 9;
pub const MDBX_opt_spill_min_denominator: c_int = 10;
pub const MDBX_opt_spill_parent4child_denominator: c_int = 11;
pub const MDBX_opt_merge_threshold_16dot16_percent: c_int = 12;
pub const MDBX_opt_writethrough_threshold: c_int = 13;
pub const MDBX_opt_prefault_write_enable: c_int = 14;
pub const MDBX_opt_gc_time_limit: c_int = 15;
pub const MDBX_opt_prefer_waf_insteadof_balance: c_int = 16;
pub const MDBX_opt_subpage_limit: c_int = 17;
pub const MDBX_opt_subpage_room_threshold: c_int = 18;
pub const MDBX_opt_subpage_reserve_prereq: c_int = 19;
pub const MDBX_opt_subpage_reserve_limit: c_int = 20;
pub const enum_MDBX_option = c_uint;
pub const MDBX_option_t = enum_MDBX_option;
pub extern fn mdbx_env_set_option(env: ?*MDBX_env, option: MDBX_option_t, value: u64) c_int;
pub extern fn mdbx_env_get_option(env: ?*const MDBX_env, option: MDBX_option_t, pvalue: [*c]u64) c_int;
pub extern fn mdbx_env_open(env: ?*MDBX_env, pathname: [*c]const u8, flags: MDBX_env_flags_t, mode: mdbx_mode_t) c_int;
pub const MDBX_ENV_JUST_DELETE: c_int = 0;
pub const MDBX_ENV_ENSURE_UNUSED: c_int = 1;
pub const MDBX_ENV_WAIT_FOR_UNUSED: c_int = 2;
pub const enum_MDBX_env_delete_mode = c_uint;
pub const MDBX_env_delete_mode_t = enum_MDBX_env_delete_mode;
pub extern fn mdbx_env_delete(pathname: [*c]const u8, mode: MDBX_env_delete_mode_t) c_int;
pub extern fn mdbx_env_copy(env: ?*MDBX_env, dest: [*c]const u8, flags: MDBX_copy_flags_t) c_int;
pub extern fn mdbx_txn_copy2pathname(txn: ?*MDBX_txn, dest: [*c]const u8, flags: MDBX_copy_flags_t) c_int;
pub extern fn mdbx_env_copy2fd(env: ?*MDBX_env, fd: mdbx_filehandle_t, flags: MDBX_copy_flags_t) c_int;
pub extern fn mdbx_txn_copy2fd(txn: ?*MDBX_txn, fd: mdbx_filehandle_t, flags: MDBX_copy_flags_t) c_int;
pub const struct_MDBX_stat = extern struct {
    ms_psize: u32 = @import("std").mem.zeroes(u32),
    ms_depth: u32 = @import("std").mem.zeroes(u32),
    ms_branch_pages: u64 = @import("std").mem.zeroes(u64),
    ms_leaf_pages: u64 = @import("std").mem.zeroes(u64),
    ms_overflow_pages: u64 = @import("std").mem.zeroes(u64),
    ms_entries: u64 = @import("std").mem.zeroes(u64),
    ms_mod_txnid: u64 = @import("std").mem.zeroes(u64),
};
pub const MDBX_stat = struct_MDBX_stat;
pub extern fn mdbx_env_stat_ex(env: ?*const MDBX_env, txn: ?*const MDBX_txn, stat: [*c]MDBX_stat, bytes: usize) c_int;
pub fn mdbx_env_stat(arg_env: ?*const MDBX_env, arg_stat: [*c]MDBX_stat, arg_bytes: usize) callconv(.C) c_int {
    var env = arg_env;
    _ = &env;
    var stat = arg_stat;
    _ = &stat;
    var bytes = arg_bytes;
    _ = &bytes;
    return mdbx_env_stat_ex(env, null, stat, bytes);
}
const struct_unnamed_15 = extern struct {
    lower: u64 = @import("std").mem.zeroes(u64),
    upper: u64 = @import("std").mem.zeroes(u64),
    current: u64 = @import("std").mem.zeroes(u64),
    shrink: u64 = @import("std").mem.zeroes(u64),
    grow: u64 = @import("std").mem.zeroes(u64),
};
const struct_unnamed_17 = extern struct {
    x: u64 = @import("std").mem.zeroes(u64),
    y: u64 = @import("std").mem.zeroes(u64),
};
const struct_unnamed_16 = extern struct {
    current: struct_unnamed_17 = @import("std").mem.zeroes(struct_unnamed_17),
    meta: [3]struct_unnamed_17 = @import("std").mem.zeroes([3]struct_unnamed_17),
};
const struct_unnamed_18 = extern struct {
    newly: u64 = @import("std").mem.zeroes(u64),
    cow: u64 = @import("std").mem.zeroes(u64),
    clone: u64 = @import("std").mem.zeroes(u64),
    split: u64 = @import("std").mem.zeroes(u64),
    merge: u64 = @import("std").mem.zeroes(u64),
    spill: u64 = @import("std").mem.zeroes(u64),
    unspill: u64 = @import("std").mem.zeroes(u64),
    wops: u64 = @import("std").mem.zeroes(u64),
    prefault: u64 = @import("std").mem.zeroes(u64),
    mincore: u64 = @import("std").mem.zeroes(u64),
    msync: u64 = @import("std").mem.zeroes(u64),
    fsync: u64 = @import("std").mem.zeroes(u64),
};
const struct_unnamed_19 = extern struct {
    x: u64 = @import("std").mem.zeroes(u64),
    y: u64 = @import("std").mem.zeroes(u64),
};
pub const struct_MDBX_envinfo = extern struct {
    mi_geo: struct_unnamed_15 = @import("std").mem.zeroes(struct_unnamed_15),
    mi_mapsize: u64 = @import("std").mem.zeroes(u64),
    mi_last_pgno: u64 = @import("std").mem.zeroes(u64),
    mi_recent_txnid: u64 = @import("std").mem.zeroes(u64),
    mi_latter_reader_txnid: u64 = @import("std").mem.zeroes(u64),
    mi_self_latter_reader_txnid: u64 = @import("std").mem.zeroes(u64),
    mi_meta_txnid: [3]u64 = @import("std").mem.zeroes([3]u64),
    mi_meta_sign: [3]u64 = @import("std").mem.zeroes([3]u64),
    mi_maxreaders: u32 = @import("std").mem.zeroes(u32),
    mi_numreaders: u32 = @import("std").mem.zeroes(u32),
    mi_dxb_pagesize: u32 = @import("std").mem.zeroes(u32),
    mi_sys_pagesize: u32 = @import("std").mem.zeroes(u32),
    mi_bootid: struct_unnamed_16 = @import("std").mem.zeroes(struct_unnamed_16),
    mi_unsync_volume: u64 = @import("std").mem.zeroes(u64),
    mi_autosync_threshold: u64 = @import("std").mem.zeroes(u64),
    mi_since_sync_seconds16dot16: u32 = @import("std").mem.zeroes(u32),
    mi_autosync_period_seconds16dot16: u32 = @import("std").mem.zeroes(u32),
    mi_since_reader_check_seconds16dot16: u32 = @import("std").mem.zeroes(u32),
    mi_mode: u32 = @import("std").mem.zeroes(u32),
    mi_pgop_stat: struct_unnamed_18 = @import("std").mem.zeroes(struct_unnamed_18),
    mi_dxbid: struct_unnamed_19 = @import("std").mem.zeroes(struct_unnamed_19),
};
pub const MDBX_envinfo = struct_MDBX_envinfo;
pub extern fn mdbx_env_info_ex(env: ?*const MDBX_env, txn: ?*const MDBX_txn, info: [*c]MDBX_envinfo, bytes: usize) c_int;
pub fn mdbx_env_info(arg_env: ?*const MDBX_env, arg_info: [*c]MDBX_envinfo, arg_bytes: usize) callconv(.C) c_int {
    var env = arg_env;
    _ = &env;
    var info = arg_info;
    _ = &info;
    var bytes = arg_bytes;
    _ = &bytes;
    return mdbx_env_info_ex(env, null, info, bytes);
}
pub extern fn mdbx_env_sync_ex(env: ?*MDBX_env, force: bool, nonblock: bool) c_int;
pub fn mdbx_env_sync(arg_env: ?*MDBX_env) callconv(.C) c_int {
    var env = arg_env;
    _ = &env;
    return mdbx_env_sync_ex(env, @as(c_int, 1) != 0, @as(c_int, 0) != 0);
}
pub fn mdbx_env_sync_poll(arg_env: ?*MDBX_env) callconv(.C) c_int {
    var env = arg_env;
    _ = &env;
    return mdbx_env_sync_ex(env, @as(c_int, 0) != 0, @as(c_int, 1) != 0);
}
pub fn mdbx_env_set_syncbytes(arg_env: ?*MDBX_env, arg_threshold: usize) callconv(.C) c_int {
    var env = arg_env;
    _ = &env;
    var threshold = arg_threshold;
    _ = &threshold;
    return mdbx_env_set_option(env, @as(c_uint, @bitCast(MDBX_opt_sync_bytes)), threshold);
}
pub fn mdbx_env_get_syncbytes(arg_env: ?*const MDBX_env, arg_threshold: [*c]usize) callconv(.C) c_int {
    var env = arg_env;
    _ = &env;
    var threshold = arg_threshold;
    _ = &threshold;
    var rc: c_int = MDBX_EINVAL;
    _ = &rc;
    if (threshold != null) {
        var proxy: u64 = 0;
        _ = &proxy;
        rc = mdbx_env_get_option(env, @as(c_uint, @bitCast(MDBX_opt_sync_bytes)), &proxy);
        _ = blk: {
            _ = @sizeOf(c_int);
            break :blk blk_1: {
                break :blk_1 if (proxy <= @as(c_ulong, 18446744073709551615)) {} else {
                    __assert_fail("proxy <= SIZE_MAX", "mdbx.h", @as(c_uint, @bitCast(@as(c_int, 3080))), "int mdbx_env_get_syncbytes(const MDBX_env *, size_t *)");
                };
            };
        };
        threshold.* = @as(usize, @bitCast(proxy));
    }
    return rc;
}
pub fn mdbx_env_set_syncperiod(arg_env: ?*MDBX_env, arg_seconds_16dot16: c_uint) callconv(.C) c_int {
    var env = arg_env;
    _ = &env;
    var seconds_16dot16 = arg_seconds_16dot16;
    _ = &seconds_16dot16;
    return mdbx_env_set_option(env, @as(c_uint, @bitCast(MDBX_opt_sync_period)), @as(u64, @bitCast(@as(c_ulong, seconds_16dot16))));
}
pub fn mdbx_env_get_syncperiod(arg_env: ?*const MDBX_env, arg_period_seconds_16dot16: [*c]c_uint) callconv(.C) c_int {
    var env = arg_env;
    _ = &env;
    var period_seconds_16dot16 = arg_period_seconds_16dot16;
    _ = &period_seconds_16dot16;
    var rc: c_int = MDBX_EINVAL;
    _ = &rc;
    if (period_seconds_16dot16 != null) {
        var proxy: u64 = 0;
        _ = &proxy;
        rc = mdbx_env_get_option(env, @as(c_uint, @bitCast(MDBX_opt_sync_period)), &proxy);
        _ = blk: {
            _ = @sizeOf(c_int);
            break :blk blk_1: {
                break :blk_1 if (proxy <= @as(u64, @bitCast(@as(c_ulong, @as(c_uint, 4294967295))))) {} else {
                    __assert_fail("proxy <= UINT32_MAX", "mdbx.h", @as(c_uint, @bitCast(@as(c_int, 3145))), "int mdbx_env_get_syncperiod(const MDBX_env *, unsigned int *)");
                };
            };
        };
        period_seconds_16dot16.* = @as(c_uint, @bitCast(@as(c_uint, @truncate(proxy))));
    }
    return rc;
}
pub extern fn mdbx_env_close_ex(env: ?*MDBX_env, dont_sync: bool) c_int;
pub fn mdbx_env_close(arg_env: ?*MDBX_env) callconv(.C) c_int {
    var env = arg_env;
    _ = &env;
    return mdbx_env_close_ex(env, @as(c_int, 0) != 0);
}
pub extern fn mdbx_env_resurrect_after_fork(env: ?*MDBX_env) c_int;
pub const MDBX_warmup_default: c_int = 0;
pub const MDBX_warmup_force: c_int = 1;
pub const MDBX_warmup_oomsafe: c_int = 2;
pub const MDBX_warmup_lock: c_int = 4;
pub const MDBX_warmup_touchlimit: c_int = 8;
pub const MDBX_warmup_release: c_int = 16;
pub const enum_MDBX_warmup_flags = c_uint;
pub const MDBX_warmup_flags_t = enum_MDBX_warmup_flags;
pub extern fn mdbx_env_warmup(env: ?*const MDBX_env, txn: ?*const MDBX_txn, flags: MDBX_warmup_flags_t, timeout_seconds_16dot16: c_uint) c_int;
pub extern fn mdbx_env_set_flags(env: ?*MDBX_env, flags: MDBX_env_flags_t, onoff: bool) c_int;
pub extern fn mdbx_env_get_flags(env: ?*const MDBX_env, flags: [*c]c_uint) c_int;
pub extern fn mdbx_env_get_path(env: ?*const MDBX_env, dest: [*c][*c]const u8) c_int;
pub extern fn mdbx_env_get_fd(env: ?*const MDBX_env, fd: [*c]mdbx_filehandle_t) c_int;
pub extern fn mdbx_env_set_geometry(env: ?*MDBX_env, size_lower: isize, size_now: isize, size_upper: isize, growth_step: isize, shrink_threshold: isize, pagesize: isize) c_int;
pub fn mdbx_env_set_mapsize(arg_env: ?*MDBX_env, arg_size: usize) callconv(.C) c_int {
    var env = arg_env;
    _ = &env;
    var size = arg_size;
    _ = &size;
    return mdbx_env_set_geometry(env, @as(isize, @bitCast(size)), @as(isize, @bitCast(size)), @as(isize, @bitCast(size)), @as(isize, @bitCast(@as(c_long, -@as(c_int, 1)))), @as(isize, @bitCast(@as(c_long, -@as(c_int, 1)))), @as(isize, @bitCast(@as(c_long, -@as(c_int, 1)))));
}
pub extern fn mdbx_is_readahead_reasonable(volume: usize, redundancy: isize) c_int;
pub fn mdbx_limits_pgsize_min() callconv(.C) isize {
    return @as(isize, @bitCast(@as(c_long, MDBX_MIN_PAGESIZE)));
}
pub fn mdbx_limits_pgsize_max() callconv(.C) isize {
    return @as(isize, @bitCast(@as(c_long, MDBX_MAX_PAGESIZE)));
}
pub extern fn mdbx_limits_dbsize_min(pagesize: isize) isize;
pub extern fn mdbx_limits_dbsize_max(pagesize: isize) isize;
pub extern fn mdbx_limits_keysize_max(pagesize: isize, flags: MDBX_db_flags_t) isize;
pub extern fn mdbx_limits_keysize_min(flags: MDBX_db_flags_t) isize;
pub extern fn mdbx_limits_valsize_max(pagesize: isize, flags: MDBX_db_flags_t) isize;
pub extern fn mdbx_limits_valsize_min(flags: MDBX_db_flags_t) isize;
pub extern fn mdbx_limits_pairsize4page_max(pagesize: isize, flags: MDBX_db_flags_t) isize;
pub extern fn mdbx_limits_valsize4page_max(pagesize: isize, flags: MDBX_db_flags_t) isize;
pub extern fn mdbx_limits_txnsize_max(pagesize: isize) isize;
pub fn mdbx_env_set_maxreaders(arg_env: ?*MDBX_env, arg_readers: c_uint) callconv(.C) c_int {
    var env = arg_env;
    _ = &env;
    var readers = arg_readers;
    _ = &readers;
    return mdbx_env_set_option(env, @as(c_uint, @bitCast(MDBX_opt_max_readers)), @as(u64, @bitCast(@as(u64, readers))));
}
pub fn mdbx_env_get_maxreaders(arg_env: ?*const MDBX_env, arg_readers: [*c]c_uint) callconv(.C) c_int {
    var env = arg_env;
    _ = &env;
    var readers = arg_readers;
    _ = &readers;
    var rc: c_int = MDBX_EINVAL;
    _ = &rc;
    if (readers != null) {
        var proxy: u64 = 0;
        _ = &proxy;
        rc = mdbx_env_get_option(env, @as(c_uint, @bitCast(MDBX_opt_max_readers)), &proxy);
        readers.* = @as(c_uint, @bitCast(@as(c_uint, @truncate(proxy))));
    }
    return rc;
}
pub fn mdbx_env_set_maxdbs(arg_env: ?*MDBX_env, arg_dbs: MDBX_dbi) callconv(.C) c_int {
    var env = arg_env;
    _ = &env;
    var dbs = arg_dbs;
    _ = &dbs;
    return mdbx_env_set_option(env, @as(c_uint, @bitCast(MDBX_opt_max_db)), @as(u64, @bitCast(@as(u64, dbs))));
}
pub fn mdbx_env_get_maxdbs(arg_env: ?*const MDBX_env, arg_dbs: [*c]MDBX_dbi) callconv(.C) c_int {
    var env = arg_env;
    _ = &env;
    var dbs = arg_dbs;
    _ = &dbs;
    var rc: c_int = MDBX_EINVAL;
    _ = &rc;
    if (dbs != null) {
        var proxy: u64 = 0;
        _ = &proxy;
        rc = mdbx_env_get_option(env, @as(c_uint, @bitCast(MDBX_opt_max_db)), &proxy);
        dbs.* = @as(MDBX_dbi, @bitCast(@as(c_uint, @truncate(proxy))));
    }
    return rc;
}
pub extern fn mdbx_default_pagesize() usize;
pub extern fn mdbx_get_sysraminfo(page_size: [*c]isize, total_pages: [*c]isize, avail_pages: [*c]isize) c_int;
pub extern fn mdbx_env_get_maxkeysize_ex(env: ?*const MDBX_env, flags: MDBX_db_flags_t) c_int;
pub extern fn mdbx_env_get_maxvalsize_ex(env: ?*const MDBX_env, flags: MDBX_db_flags_t) c_int;
pub extern fn mdbx_env_get_maxkeysize(env: ?*const MDBX_env) c_int;
pub extern fn mdbx_env_get_pairsize4page_max(env: ?*const MDBX_env, flags: MDBX_db_flags_t) c_int;
pub extern fn mdbx_env_get_valsize4page_max(env: ?*const MDBX_env, flags: MDBX_db_flags_t) c_int;
pub extern fn mdbx_env_set_userctx(env: ?*MDBX_env, ctx: ?*anyopaque) c_int;
pub extern fn mdbx_env_get_userctx(env: ?*const MDBX_env) ?*anyopaque;
pub extern fn mdbx_txn_begin_ex(env: ?*MDBX_env, parent: ?*MDBX_txn, flags: MDBX_txn_flags_t, txn: [*c]?*MDBX_txn, context: ?*anyopaque) c_int;
pub fn mdbx_txn_begin(arg_env: ?*MDBX_env, arg_parent: ?*MDBX_txn, arg_flags: MDBX_txn_flags_t, arg_txn: [*c]?*MDBX_txn) callconv(.C) c_int {
    var env = arg_env;
    _ = &env;
    var parent = arg_parent;
    _ = &parent;
    var flags = arg_flags;
    _ = &flags;
    var txn = arg_txn;
    _ = &txn;
    return mdbx_txn_begin_ex(env, parent, flags, txn, @as(?*anyopaque, @ptrFromInt(@as(c_int, 0))));
}
pub extern fn mdbx_txn_set_userctx(txn: ?*MDBX_txn, ctx: ?*anyopaque) c_int;
pub extern fn mdbx_txn_get_userctx(txn: ?*const MDBX_txn) ?*anyopaque;
pub const struct_MDBX_txn_info = extern struct {
    txn_id: u64 = @import("std").mem.zeroes(u64),
    txn_reader_lag: u64 = @import("std").mem.zeroes(u64),
    txn_space_used: u64 = @import("std").mem.zeroes(u64),
    txn_space_limit_soft: u64 = @import("std").mem.zeroes(u64),
    txn_space_limit_hard: u64 = @import("std").mem.zeroes(u64),
    txn_space_retired: u64 = @import("std").mem.zeroes(u64),
    txn_space_leftover: u64 = @import("std").mem.zeroes(u64),
    txn_space_dirty: u64 = @import("std").mem.zeroes(u64),
};
pub const MDBX_txn_info = struct_MDBX_txn_info;
pub extern fn mdbx_txn_info(txn: ?*const MDBX_txn, info: [*c]MDBX_txn_info, scan_rlt: bool) c_int;
pub extern fn mdbx_txn_env(txn: ?*const MDBX_txn) ?*MDBX_env;
pub extern fn mdbx_txn_flags(txn: ?*const MDBX_txn) MDBX_txn_flags_t;
pub extern fn mdbx_txn_id(txn: ?*const MDBX_txn) u64;
const struct_unnamed_20 = extern struct {
    wloops: u32 = @import("std").mem.zeroes(u32),
    coalescences: u32 = @import("std").mem.zeroes(u32),
    wipes: u32 = @import("std").mem.zeroes(u32),
    flushes: u32 = @import("std").mem.zeroes(u32),
    kicks: u32 = @import("std").mem.zeroes(u32),
    work_counter: u32 = @import("std").mem.zeroes(u32),
    work_rtime_monotonic: u32 = @import("std").mem.zeroes(u32),
    work_xtime_cpu: u32 = @import("std").mem.zeroes(u32),
    work_rsteps: u32 = @import("std").mem.zeroes(u32),
    work_xpages: u32 = @import("std").mem.zeroes(u32),
    work_majflt: u32 = @import("std").mem.zeroes(u32),
    self_counter: u32 = @import("std").mem.zeroes(u32),
    self_rtime_monotonic: u32 = @import("std").mem.zeroes(u32),
    self_xtime_cpu: u32 = @import("std").mem.zeroes(u32),
    self_rsteps: u32 = @import("std").mem.zeroes(u32),
    self_xpages: u32 = @import("std").mem.zeroes(u32),
    self_majflt: u32 = @import("std").mem.zeroes(u32),
};
pub const struct_MDBX_commit_latency = extern struct {
    preparation: u32 = @import("std").mem.zeroes(u32),
    gc_wallclock: u32 = @import("std").mem.zeroes(u32),
    audit: u32 = @import("std").mem.zeroes(u32),
    write: u32 = @import("std").mem.zeroes(u32),
    sync: u32 = @import("std").mem.zeroes(u32),
    ending: u32 = @import("std").mem.zeroes(u32),
    whole: u32 = @import("std").mem.zeroes(u32),
    gc_cputime: u32 = @import("std").mem.zeroes(u32),
    gc_prof: struct_unnamed_20 = @import("std").mem.zeroes(struct_unnamed_20),
};
pub const MDBX_commit_latency = struct_MDBX_commit_latency;
pub extern fn mdbx_txn_commit_ex(txn: ?*MDBX_txn, latency: [*c]MDBX_commit_latency) c_int;
pub fn mdbx_txn_commit(arg_txn: ?*MDBX_txn) callconv(.C) c_int {
    var txn = arg_txn;
    _ = &txn;
    return mdbx_txn_commit_ex(txn, null);
}
pub extern fn mdbx_txn_abort(txn: ?*MDBX_txn) c_int;
pub extern fn mdbx_txn_break(txn: ?*MDBX_txn) c_int;
pub extern fn mdbx_txn_reset(txn: ?*MDBX_txn) c_int;
pub extern fn mdbx_txn_park(txn: ?*MDBX_txn, autounpark: bool) c_int;
pub extern fn mdbx_txn_unpark(txn: ?*MDBX_txn, restart_if_ousted: bool) c_int;
pub extern fn mdbx_txn_renew(txn: ?*MDBX_txn) c_int;
pub const struct_MDBX_canary = extern struct {
    x: u64 = @import("std").mem.zeroes(u64),
    y: u64 = @import("std").mem.zeroes(u64),
    z: u64 = @import("std").mem.zeroes(u64),
    v: u64 = @import("std").mem.zeroes(u64),
};
pub const MDBX_canary = struct_MDBX_canary;
pub extern fn mdbx_canary_put(txn: ?*MDBX_txn, canary: [*c]const MDBX_canary) c_int;
pub extern fn mdbx_canary_get(txn: ?*const MDBX_txn, canary: [*c]MDBX_canary) c_int;
pub const MDBX_cmp_func = fn ([*c]const MDBX_val, [*c]const MDBX_val) callconv(.C) c_int;
pub extern fn mdbx_dbi_open(txn: ?*MDBX_txn, name: [*c]const u8, flags: MDBX_db_flags_t, dbi: [*c]MDBX_dbi) c_int;
pub extern fn mdbx_dbi_open2(txn: ?*MDBX_txn, name: [*c]const MDBX_val, flags: MDBX_db_flags_t, dbi: [*c]MDBX_dbi) c_int;
pub extern fn mdbx_dbi_open_ex(txn: ?*MDBX_txn, name: [*c]const u8, flags: MDBX_db_flags_t, dbi: [*c]MDBX_dbi, keycmp: ?*const MDBX_cmp_func, datacmp: ?*const MDBX_cmp_func) c_int;
pub extern fn mdbx_dbi_open_ex2(txn: ?*MDBX_txn, name: [*c]const MDBX_val, flags: MDBX_db_flags_t, dbi: [*c]MDBX_dbi, keycmp: ?*const MDBX_cmp_func, datacmp: ?*const MDBX_cmp_func) c_int;
pub extern fn mdbx_dbi_rename(txn: ?*MDBX_txn, dbi: MDBX_dbi, name: [*c]const u8) c_int;
pub extern fn mdbx_dbi_rename2(txn: ?*MDBX_txn, dbi: MDBX_dbi, name: [*c]const MDBX_val) c_int;
pub const MDBX_table_enum_func = fn (?*anyopaque, ?*const MDBX_txn, [*c]const MDBX_val, MDBX_db_flags_t, [*c]const struct_MDBX_stat, MDBX_dbi) callconv(.C) c_int;
pub extern fn mdbx_enumerate_tables(txn: ?*const MDBX_txn, func: ?*const MDBX_table_enum_func, ctx: ?*anyopaque) c_int;
pub extern fn mdbx_key_from_jsonInteger(json_integer: i64) u64;
pub extern fn mdbx_key_from_double(ieee754_64bit: f64) u64;
pub extern fn mdbx_key_from_ptrdouble(ieee754_64bit: [*c]const f64) u64;
pub extern fn mdbx_key_from_float(ieee754_32bit: f32) u32;
pub extern fn mdbx_key_from_ptrfloat(ieee754_32bit: [*c]const f32) u32;
pub fn mdbx_key_from_int64(@"i64": i64) callconv(.C) u64 {
    _ = &@"i64";
    return @as(c_ulong, 9223372036854775808) +% @as(c_ulong, @bitCast(@"i64"));
}
pub fn mdbx_key_from_int32(@"i32": i32) callconv(.C) u32 {
    _ = &@"i32";
    return @as(c_uint, 2147483648) +% @as(c_uint, @bitCast(@"i32"));
}
pub extern fn mdbx_jsonInteger_from_key(MDBX_val) i64;
pub extern fn mdbx_double_from_key(MDBX_val) f64;
pub extern fn mdbx_float_from_key(MDBX_val) f32;
pub extern fn mdbx_int32_from_key(MDBX_val) i32;
pub extern fn mdbx_int64_from_key(MDBX_val) i64;
pub extern fn mdbx_dbi_stat(txn: ?*const MDBX_txn, dbi: MDBX_dbi, stat: [*c]MDBX_stat, bytes: usize) c_int;
pub extern fn mdbx_dbi_dupsort_depthmask(txn: ?*const MDBX_txn, dbi: MDBX_dbi, mask: [*c]u32) c_int;
pub const MDBX_DBI_DIRTY: c_int = 1;
pub const MDBX_DBI_STALE: c_int = 2;
pub const MDBX_DBI_FRESH: c_int = 4;
pub const MDBX_DBI_CREAT: c_int = 8;
pub const enum_MDBX_dbi_state = c_uint;
pub const MDBX_dbi_state_t = enum_MDBX_dbi_state;
pub extern fn mdbx_dbi_flags_ex(txn: ?*const MDBX_txn, dbi: MDBX_dbi, flags: [*c]c_uint, state: [*c]c_uint) c_int;
pub fn mdbx_dbi_flags(arg_txn: ?*const MDBX_txn, arg_dbi: MDBX_dbi, arg_flags: [*c]c_uint) callconv(.C) c_int {
    var txn = arg_txn;
    _ = &txn;
    var dbi = arg_dbi;
    _ = &dbi;
    var flags = arg_flags;
    _ = &flags;
    var state: c_uint = undefined;
    _ = &state;
    return mdbx_dbi_flags_ex(txn, dbi, flags, &state);
}
pub extern fn mdbx_dbi_close(env: ?*MDBX_env, dbi: MDBX_dbi) c_int;
pub extern fn mdbx_drop(txn: ?*MDBX_txn, dbi: MDBX_dbi, del: bool) c_int;
pub extern fn mdbx_get(txn: ?*const MDBX_txn, dbi: MDBX_dbi, key: [*c]const MDBX_val, data: [*c]MDBX_val) c_int;
pub extern fn mdbx_get_ex(txn: ?*const MDBX_txn, dbi: MDBX_dbi, key: [*c]MDBX_val, data: [*c]MDBX_val, values_count: [*c]usize) c_int;
pub extern fn mdbx_get_equal_or_great(txn: ?*const MDBX_txn, dbi: MDBX_dbi, key: [*c]MDBX_val, data: [*c]MDBX_val) c_int;
pub extern fn mdbx_put(txn: ?*MDBX_txn, dbi: MDBX_dbi, key: [*c]const MDBX_val, data: [*c]MDBX_val, flags: MDBX_put_flags_t) c_int;
pub extern fn mdbx_replace(txn: ?*MDBX_txn, dbi: MDBX_dbi, key: [*c]const MDBX_val, new_data: [*c]MDBX_val, old_data: [*c]MDBX_val, flags: MDBX_put_flags_t) c_int;
pub const MDBX_preserve_func = ?*const fn (?*anyopaque, [*c]MDBX_val, ?*const anyopaque, usize) callconv(.C) c_int;
pub extern fn mdbx_replace_ex(txn: ?*MDBX_txn, dbi: MDBX_dbi, key: [*c]const MDBX_val, new_data: [*c]MDBX_val, old_data: [*c]MDBX_val, flags: MDBX_put_flags_t, preserver: MDBX_preserve_func, preserver_context: ?*anyopaque) c_int;
pub extern fn mdbx_del(txn: ?*MDBX_txn, dbi: MDBX_dbi, key: [*c]const MDBX_val, data: [*c]const MDBX_val) c_int;
pub extern fn mdbx_cursor_create(context: ?*anyopaque) ?*MDBX_cursor;
pub extern fn mdbx_cursor_set_userctx(cursor: ?*MDBX_cursor, ctx: ?*anyopaque) c_int;
pub extern fn mdbx_cursor_get_userctx(cursor: ?*const MDBX_cursor) ?*anyopaque;
pub extern fn mdbx_cursor_bind(txn: ?*const MDBX_txn, cursor: ?*MDBX_cursor, dbi: MDBX_dbi) c_int;
pub extern fn mdbx_cursor_unbind(cursor: ?*MDBX_cursor) c_int;
pub extern fn mdbx_cursor_reset(cursor: ?*MDBX_cursor) c_int;
pub extern fn mdbx_cursor_open(txn: ?*const MDBX_txn, dbi: MDBX_dbi, cursor: [*c]?*MDBX_cursor) c_int;
pub extern fn mdbx_cursor_close(cursor: ?*MDBX_cursor) void;
pub extern fn mdbx_txn_release_all_cursors(txn: ?*const MDBX_txn, unbind: bool) c_int;
pub extern fn mdbx_cursor_renew(txn: ?*const MDBX_txn, cursor: ?*MDBX_cursor) c_int;
pub extern fn mdbx_cursor_txn(cursor: ?*const MDBX_cursor) ?*MDBX_txn;
pub extern fn mdbx_cursor_dbi(cursor: ?*const MDBX_cursor) MDBX_dbi;
pub extern fn mdbx_cursor_copy(src: ?*const MDBX_cursor, dest: ?*MDBX_cursor) c_int;
pub extern fn mdbx_cursor_compare(left: ?*const MDBX_cursor, right: ?*const MDBX_cursor, ignore_multival: bool) c_int;
pub extern fn mdbx_cursor_get(cursor: ?*MDBX_cursor, key: [*c]MDBX_val, data: [*c]MDBX_val, op: MDBX_cursor_op) c_int;
pub extern fn mdbx_cursor_ignord(cursor: ?*MDBX_cursor) c_int;
pub const MDBX_predicate_func = fn (?*anyopaque, [*c]MDBX_val, [*c]MDBX_val, ?*anyopaque) callconv(.C) c_int;
pub extern fn mdbx_cursor_scan(cursor: ?*MDBX_cursor, predicate: ?*const MDBX_predicate_func, context: ?*anyopaque, start_op: MDBX_cursor_op, turn_op: MDBX_cursor_op, arg: ?*anyopaque) c_int;
pub extern fn mdbx_cursor_scan_from(cursor: ?*MDBX_cursor, predicate: ?*const MDBX_predicate_func, context: ?*anyopaque, from_op: MDBX_cursor_op, from_key: [*c]MDBX_val, from_value: [*c]MDBX_val, turn_op: MDBX_cursor_op, arg: ?*anyopaque) c_int;
pub extern fn mdbx_cursor_get_batch(cursor: ?*MDBX_cursor, count: [*c]usize, pairs: [*c]MDBX_val, limit: usize, op: MDBX_cursor_op) c_int;
pub extern fn mdbx_cursor_put(cursor: ?*MDBX_cursor, key: [*c]const MDBX_val, data: [*c]MDBX_val, flags: MDBX_put_flags_t) c_int;
pub extern fn mdbx_cursor_del(cursor: ?*MDBX_cursor, flags: MDBX_put_flags_t) c_int;
pub extern fn mdbx_cursor_count(cursor: ?*const MDBX_cursor, pcount: [*c]usize) c_int;
pub extern fn mdbx_cursor_eof(cursor: ?*const MDBX_cursor) c_int;
pub extern fn mdbx_cursor_on_first(cursor: ?*const MDBX_cursor) c_int;
pub extern fn mdbx_cursor_on_first_dup(cursor: ?*const MDBX_cursor) c_int;
pub extern fn mdbx_cursor_on_last(cursor: ?*const MDBX_cursor) c_int;
pub extern fn mdbx_cursor_on_last_dup(cursor: ?*const MDBX_cursor) c_int;
pub extern fn mdbx_estimate_distance(first: ?*const MDBX_cursor, last: ?*const MDBX_cursor, distance_items: [*c]ptrdiff_t) c_int;
pub extern fn mdbx_estimate_move(cursor: ?*const MDBX_cursor, key: [*c]MDBX_val, data: [*c]MDBX_val, move_op: MDBX_cursor_op, distance_items: [*c]ptrdiff_t) c_int;
pub extern fn mdbx_estimate_range(txn: ?*const MDBX_txn, dbi: MDBX_dbi, begin_key: [*c]const MDBX_val, begin_data: [*c]const MDBX_val, end_key: [*c]const MDBX_val, end_data: [*c]const MDBX_val, distance_items: [*c]ptrdiff_t) c_int;
pub extern fn mdbx_is_dirty(txn: ?*const MDBX_txn, ptr: ?*const anyopaque) c_int;
pub extern fn mdbx_dbi_sequence(txn: ?*MDBX_txn, dbi: MDBX_dbi, result: [*c]u64, increment: u64) c_int;
pub extern fn mdbx_cmp(txn: ?*const MDBX_txn, dbi: MDBX_dbi, a: [*c]const MDBX_val, b: [*c]const MDBX_val) c_int;
pub extern fn mdbx_get_keycmp(flags: MDBX_db_flags_t) ?*const MDBX_cmp_func;
pub extern fn mdbx_dcmp(txn: ?*const MDBX_txn, dbi: MDBX_dbi, a: [*c]const MDBX_val, b: [*c]const MDBX_val) c_int;
pub extern fn mdbx_get_datacmp(flags: MDBX_db_flags_t) ?*const MDBX_cmp_func;
pub const MDBX_reader_list_func = fn (?*anyopaque, c_int, c_int, mdbx_pid_t, mdbx_tid_t, u64, u64, usize, usize) callconv(.C) c_int;
pub extern fn mdbx_reader_list(env: ?*const MDBX_env, func: ?*const MDBX_reader_list_func, ctx: ?*anyopaque) c_int;
pub extern fn mdbx_reader_check(env: ?*MDBX_env, dead: [*c]c_int) c_int;
pub extern fn mdbx_txn_straggler(txn: ?*const MDBX_txn, percent: [*c]c_int) c_int;
pub extern fn mdbx_thread_register(env: ?*const MDBX_env) c_int;
pub extern fn mdbx_thread_unregister(env: ?*const MDBX_env) c_int;
pub const MDBX_hsr_func = fn (?*const MDBX_env, ?*const MDBX_txn, mdbx_pid_t, mdbx_tid_t, u64, c_uint, usize, c_int) callconv(.C) c_int;
pub extern fn mdbx_env_set_hsr(env: ?*MDBX_env, hsr_callback: ?*const MDBX_hsr_func) c_int;
pub extern fn mdbx_env_get_hsr(env: ?*const MDBX_env) ?*const MDBX_hsr_func;
pub extern fn mdbx_txn_lock(env: ?*MDBX_env, dont_wait: bool) c_int;
pub extern fn mdbx_txn_unlock(env: ?*MDBX_env) c_int;
pub extern fn mdbx_env_open_for_recovery(env: ?*MDBX_env, pathname: [*c]const u8, target_meta: c_uint, writeable: bool) c_int;
pub extern fn mdbx_env_turn_for_recovery(env: ?*MDBX_env, target_meta: c_uint) c_int;
pub extern fn mdbx_preopen_snapinfo(pathname: [*c]const u8, info: [*c]MDBX_envinfo, bytes: usize) c_int;
pub const MDBX_CHK_DEFAULTS: c_int = 0;
pub const MDBX_CHK_READWRITE: c_int = 1;
pub const MDBX_CHK_SKIP_BTREE_TRAVERSAL: c_int = 2;
pub const MDBX_CHK_SKIP_KV_TRAVERSAL: c_int = 4;
pub const MDBX_CHK_IGNORE_ORDER: c_int = 8;
pub const enum_MDBX_chk_flags = c_uint;
pub const MDBX_chk_flags_t = enum_MDBX_chk_flags;
pub const MDBX_chk_severity_prio_shift: c_int = 4;
pub const MDBX_chk_severity_kind_mask: c_int = 15;
pub const MDBX_chk_fatal: c_int = 0;
pub const MDBX_chk_error: c_int = 17;
pub const MDBX_chk_warning: c_int = 34;
pub const MDBX_chk_notice: c_int = 51;
pub const MDBX_chk_result: c_int = 68;
pub const MDBX_chk_resolution: c_int = 85;
pub const MDBX_chk_processing: c_int = 86;
pub const MDBX_chk_info: c_int = 103;
pub const MDBX_chk_verbose: c_int = 120;
pub const MDBX_chk_details: c_int = 137;
pub const MDBX_chk_extra: c_int = 154;
pub const enum_MDBX_chk_severity = c_uint;
pub const MDBX_chk_severity_t = enum_MDBX_chk_severity;
pub const MDBX_chk_none: c_int = 0;
pub const MDBX_chk_init: c_int = 1;
pub const MDBX_chk_lock: c_int = 2;
pub const MDBX_chk_meta: c_int = 3;
pub const MDBX_chk_tree: c_int = 4;
pub const MDBX_chk_gc: c_int = 5;
pub const MDBX_chk_space: c_int = 6;
pub const MDBX_chk_maindb: c_int = 7;
pub const MDBX_chk_tables: c_int = 8;
pub const MDBX_chk_conclude: c_int = 9;
pub const MDBX_chk_unlock: c_int = 10;
pub const MDBX_chk_finalize: c_int = 11;
pub const enum_MDBX_chk_stage = c_uint;
pub const MDBX_chk_stage_t = enum_MDBX_chk_stage;
pub const struct_MDBX_chk_internal_21 = opaque {};
pub const struct_MDBX_chk_issue = extern struct {
    next: [*c]struct_MDBX_chk_issue = @import("std").mem.zeroes([*c]struct_MDBX_chk_issue),
    count: usize = @import("std").mem.zeroes(usize),
    caption: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const MDBX_chk_issue_t = struct_MDBX_chk_issue;
const union_unnamed_22 = extern union {
    ptr: ?*anyopaque,
    number: usize,
};
pub const struct_MDBX_chk_scope = extern struct {
    issues: [*c]MDBX_chk_issue_t = @import("std").mem.zeroes([*c]MDBX_chk_issue_t),
    internal: ?*struct_MDBX_chk_internal_21 = @import("std").mem.zeroes(?*struct_MDBX_chk_internal_21),
    object: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
    stage: MDBX_chk_stage_t = @import("std").mem.zeroes(MDBX_chk_stage_t),
    verbosity: MDBX_chk_severity_t = @import("std").mem.zeroes(MDBX_chk_severity_t),
    subtotal_issues: usize = @import("std").mem.zeroes(usize),
    usr_z: union_unnamed_22 = @import("std").mem.zeroes(union_unnamed_22),
    usr_v: union_unnamed_22 = @import("std").mem.zeroes(union_unnamed_22),
    usr_o: union_unnamed_22 = @import("std").mem.zeroes(union_unnamed_22),
};
pub const MDBX_chk_scope_t = struct_MDBX_chk_scope;
pub const struct_MDBX_chk_user_table_cookie = opaque {};
pub const MDBX_chk_user_table_cookie_t = struct_MDBX_chk_user_table_cookie;
const struct_unnamed_24 = extern struct {
    all: usize = @import("std").mem.zeroes(usize),
    empty: usize = @import("std").mem.zeroes(usize),
    other: usize = @import("std").mem.zeroes(usize),
    branch: usize = @import("std").mem.zeroes(usize),
    leaf: usize = @import("std").mem.zeroes(usize),
    nested_branch: usize = @import("std").mem.zeroes(usize),
    nested_leaf: usize = @import("std").mem.zeroes(usize),
    nested_subleaf: usize = @import("std").mem.zeroes(usize),
};
const struct_unnamed_26 = extern struct {
    begin: usize = @import("std").mem.zeroes(usize),
    end: usize = @import("std").mem.zeroes(usize),
    amount: usize = @import("std").mem.zeroes(usize),
    count: usize = @import("std").mem.zeroes(usize),
};
pub const struct_MDBX_chk_histogram = extern struct {
    amount: usize = @import("std").mem.zeroes(usize),
    count: usize = @import("std").mem.zeroes(usize),
    ones: usize = @import("std").mem.zeroes(usize),
    pad: usize = @import("std").mem.zeroes(usize),
    ranges: [9]struct_unnamed_26 = @import("std").mem.zeroes([9]struct_unnamed_26),
};
const struct_unnamed_25 = extern struct {
    deep: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    large_pages: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    nested_tree: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    key_len: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    val_len: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
};
pub const struct_MDBX_chk_table = extern struct {
    cookie: ?*MDBX_chk_user_table_cookie_t = @import("std").mem.zeroes(?*MDBX_chk_user_table_cookie_t),
    name: MDBX_val = @import("std").mem.zeroes(MDBX_val),
    flags: MDBX_db_flags_t = @import("std").mem.zeroes(MDBX_db_flags_t),
    id: c_int = @import("std").mem.zeroes(c_int),
    payload_bytes: usize = @import("std").mem.zeroes(usize),
    lost_bytes: usize = @import("std").mem.zeroes(usize),
    pages: struct_unnamed_24 = @import("std").mem.zeroes(struct_unnamed_24),
    histogram: struct_unnamed_25 = @import("std").mem.zeroes(struct_unnamed_25),
};
pub const MDBX_chk_table_t = struct_MDBX_chk_table;
const struct_unnamed_23 = extern struct {
    total_payload_bytes: usize = @import("std").mem.zeroes(usize),
    table_total: usize = @import("std").mem.zeroes(usize),
    table_processed: usize = @import("std").mem.zeroes(usize),
    total_unused_bytes: usize = @import("std").mem.zeroes(usize),
    unused_pages: usize = @import("std").mem.zeroes(usize),
    processed_pages: usize = @import("std").mem.zeroes(usize),
    reclaimable_pages: usize = @import("std").mem.zeroes(usize),
    gc_pages: usize = @import("std").mem.zeroes(usize),
    alloc_pages: usize = @import("std").mem.zeroes(usize),
    backed_pages: usize = @import("std").mem.zeroes(usize),
    problems_meta: usize = @import("std").mem.zeroes(usize),
    tree_problems: usize = @import("std").mem.zeroes(usize),
    gc_tree_problems: usize = @import("std").mem.zeroes(usize),
    kv_tree_problems: usize = @import("std").mem.zeroes(usize),
    problems_gc: usize = @import("std").mem.zeroes(usize),
    problems_kv: usize = @import("std").mem.zeroes(usize),
    total_problems: usize = @import("std").mem.zeroes(usize),
    steady_txnid: u64 = @import("std").mem.zeroes(u64),
    recent_txnid: u64 = @import("std").mem.zeroes(u64),
    tables: [*c]const [*c]const MDBX_chk_table_t = @import("std").mem.zeroes([*c]const [*c]const MDBX_chk_table_t),
};
pub const struct_MDBX_chk_context = extern struct {
    internal: ?*struct_MDBX_chk_internal_21 = @import("std").mem.zeroes(?*struct_MDBX_chk_internal_21),
    env: ?*MDBX_env = @import("std").mem.zeroes(?*MDBX_env),
    txn: ?*MDBX_txn = @import("std").mem.zeroes(?*MDBX_txn),
    scope: [*c]MDBX_chk_scope_t = @import("std").mem.zeroes([*c]MDBX_chk_scope_t),
    scope_nesting: u8 = @import("std").mem.zeroes(u8),
    result: struct_unnamed_23 = @import("std").mem.zeroes(struct_unnamed_23),
};
pub const struct_MDBX_chk_line = extern struct {
    ctx: [*c]struct_MDBX_chk_context = @import("std").mem.zeroes([*c]struct_MDBX_chk_context),
    severity: u8 = @import("std").mem.zeroes(u8),
    scope_depth: u8 = @import("std").mem.zeroes(u8),
    empty: u8 = @import("std").mem.zeroes(u8),
    begin: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    end: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    out: [*c]u8 = @import("std").mem.zeroes([*c]u8),
};
pub const MDBX_chk_line_t = struct_MDBX_chk_line;
pub const MDBX_chk_context_t = struct_MDBX_chk_context;
pub const struct_MDBX_chk_callbacks = extern struct {
    check_break: ?*const fn ([*c]MDBX_chk_context_t) callconv(.C) bool = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_context_t) callconv(.C) bool),
    scope_push: ?*const fn ([*c]MDBX_chk_context_t, [*c]MDBX_chk_scope_t, [*c]MDBX_chk_scope_t, [*c]const u8, [*c]struct___va_list_tag_1) callconv(.C) c_int = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_context_t, [*c]MDBX_chk_scope_t, [*c]MDBX_chk_scope_t, [*c]const u8, [*c]struct___va_list_tag_1) callconv(.C) c_int),
    scope_conclude: ?*const fn ([*c]MDBX_chk_context_t, [*c]MDBX_chk_scope_t, [*c]MDBX_chk_scope_t, c_int) callconv(.C) c_int = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_context_t, [*c]MDBX_chk_scope_t, [*c]MDBX_chk_scope_t, c_int) callconv(.C) c_int),
    scope_pop: ?*const fn ([*c]MDBX_chk_context_t, [*c]MDBX_chk_scope_t, [*c]MDBX_chk_scope_t) callconv(.C) void = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_context_t, [*c]MDBX_chk_scope_t, [*c]MDBX_chk_scope_t) callconv(.C) void),
    issue: ?*const fn ([*c]MDBX_chk_context_t, [*c]const u8, u64, [*c]const u8, [*c]const u8, [*c]struct___va_list_tag_1) callconv(.C) void = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_context_t, [*c]const u8, u64, [*c]const u8, [*c]const u8, [*c]struct___va_list_tag_1) callconv(.C) void),
    table_filter: ?*const fn ([*c]MDBX_chk_context_t, [*c]const MDBX_val, MDBX_db_flags_t) callconv(.C) ?*MDBX_chk_user_table_cookie_t = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_context_t, [*c]const MDBX_val, MDBX_db_flags_t) callconv(.C) ?*MDBX_chk_user_table_cookie_t),
    table_conclude: ?*const fn ([*c]MDBX_chk_context_t, [*c]const MDBX_chk_table_t, ?*MDBX_cursor, c_int) callconv(.C) c_int = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_context_t, [*c]const MDBX_chk_table_t, ?*MDBX_cursor, c_int) callconv(.C) c_int),
    table_dispose: ?*const fn ([*c]MDBX_chk_context_t, [*c]const MDBX_chk_table_t) callconv(.C) void = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_context_t, [*c]const MDBX_chk_table_t) callconv(.C) void),
    table_handle_kv: ?*const fn ([*c]MDBX_chk_context_t, [*c]const MDBX_chk_table_t, usize, [*c]const MDBX_val, [*c]const MDBX_val) callconv(.C) c_int = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_context_t, [*c]const MDBX_chk_table_t, usize, [*c]const MDBX_val, [*c]const MDBX_val) callconv(.C) c_int),
    stage_begin: ?*const fn ([*c]MDBX_chk_context_t, MDBX_chk_stage_t) callconv(.C) c_int = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_context_t, MDBX_chk_stage_t) callconv(.C) c_int),
    stage_end: ?*const fn ([*c]MDBX_chk_context_t, MDBX_chk_stage_t, c_int) callconv(.C) c_int = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_context_t, MDBX_chk_stage_t, c_int) callconv(.C) c_int),
    print_begin: ?*const fn ([*c]MDBX_chk_context_t, MDBX_chk_severity_t) callconv(.C) [*c]MDBX_chk_line_t = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_context_t, MDBX_chk_severity_t) callconv(.C) [*c]MDBX_chk_line_t),
    print_flush: ?*const fn ([*c]MDBX_chk_line_t) callconv(.C) void = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_line_t) callconv(.C) void),
    print_done: ?*const fn ([*c]MDBX_chk_line_t) callconv(.C) void = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_line_t) callconv(.C) void),
    print_chars: ?*const fn ([*c]MDBX_chk_line_t, [*c]const u8, usize) callconv(.C) void = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_line_t, [*c]const u8, usize) callconv(.C) void),
    print_format: ?*const fn ([*c]MDBX_chk_line_t, [*c]const u8, [*c]struct___va_list_tag_1) callconv(.C) void = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_line_t, [*c]const u8, [*c]struct___va_list_tag_1) callconv(.C) void),
    print_size: ?*const fn ([*c]MDBX_chk_line_t, [*c]const u8, u64, [*c]const u8) callconv(.C) void = @import("std").mem.zeroes(?*const fn ([*c]MDBX_chk_line_t, [*c]const u8, u64, [*c]const u8) callconv(.C) void),
};
pub const MDBX_chk_callbacks_t = struct_MDBX_chk_callbacks;
pub extern fn mdbx_env_chk(env: ?*MDBX_env, cb: [*c]const MDBX_chk_callbacks_t, ctx: [*c]MDBX_chk_context_t, flags: MDBX_chk_flags_t, verbosity: MDBX_chk_severity_t, timeout_seconds_16dot16: c_uint) c_int;
pub extern fn mdbx_env_chk_encount_problem(ctx: [*c]MDBX_chk_context_t) c_int;
pub const __llvm__ = @as(c_int, 1);
pub const __clang__ = @as(c_int, 1);
pub const __clang_major__ = @as(c_int, 18);
pub const __clang_minor__ = @as(c_int, 1);
pub const __clang_patchlevel__ = @as(c_int, 6);
pub const __clang_version__ = "18.1.6 (https://github.com/ziglang/zig-bootstrap 98bc6bf4fc4009888d33941daf6b600d20a42a56)";
pub const __GNUC__ = @as(c_int, 4);
pub const __GNUC_MINOR__ = @as(c_int, 2);
pub const __GNUC_PATCHLEVEL__ = @as(c_int, 1);
pub const __GXX_ABI_VERSION = @as(c_int, 1002);
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __MEMORY_SCOPE_SYSTEM = @as(c_int, 0);
pub const __MEMORY_SCOPE_DEVICE = @as(c_int, 1);
pub const __MEMORY_SCOPE_WRKGRP = @as(c_int, 2);
pub const __MEMORY_SCOPE_WVFRNT = @as(c_int, 3);
pub const __MEMORY_SCOPE_SINGLE = @as(c_int, 4);
pub const __OPENCL_MEMORY_SCOPE_WORK_ITEM = @as(c_int, 0);
pub const __OPENCL_MEMORY_SCOPE_WORK_GROUP = @as(c_int, 1);
pub const __OPENCL_MEMORY_SCOPE_DEVICE = @as(c_int, 2);
pub const __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES = @as(c_int, 3);
pub const __OPENCL_MEMORY_SCOPE_SUB_GROUP = @as(c_int, 4);
pub const __FPCLASS_SNAN = @as(c_int, 0x0001);
pub const __FPCLASS_QNAN = @as(c_int, 0x0002);
pub const __FPCLASS_NEGINF = @as(c_int, 0x0004);
pub const __FPCLASS_NEGNORMAL = @as(c_int, 0x0008);
pub const __FPCLASS_NEGSUBNORMAL = @as(c_int, 0x0010);
pub const __FPCLASS_NEGZERO = @as(c_int, 0x0020);
pub const __FPCLASS_POSZERO = @as(c_int, 0x0040);
pub const __FPCLASS_POSSUBNORMAL = @as(c_int, 0x0080);
pub const __FPCLASS_POSNORMAL = @as(c_int, 0x0100);
pub const __FPCLASS_POSINF = @as(c_int, 0x0200);
pub const __PRAGMA_REDEFINE_EXTNAME = @as(c_int, 1);
pub const __VERSION__ = "Clang 18.1.6 (https://github.com/ziglang/zig-bootstrap 98bc6bf4fc4009888d33941daf6b600d20a42a56)";
pub const __OBJC_BOOL_IS_BOOL = @as(c_int, 0);
pub const __CONSTANT_CFSTRINGS__ = @as(c_int, 1);
pub const __clang_literal_encoding__ = "UTF-8";
pub const __clang_wide_literal_encoding__ = "UTF-32";
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const _LP64 = @as(c_int, 1);
pub const __LP64__ = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 8);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_WIDTH__ = @as(c_int, 64);
pub const __LLONG_WIDTH__ = @as(c_int, 64);
pub const __BITINT_MAXWIDTH__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 8388608, .decimal);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __INT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __LONG_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __WCHAR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 32);
pub const __WINT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __WINT_WIDTH__ = @as(c_int, 32);
pub const __INTMAX_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __SIZE_WIDTH__ = @as(c_int, 64);
pub const __UINTMAX_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 64);
pub const __INTPTR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTPTR_WIDTH__ = @as(c_int, 64);
pub const __UINTPTR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTPTR_WIDTH__ = @as(c_int, 64);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 8);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 16);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 8);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 8);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 8);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 4);
pub const __SIZEOF_WINT_T__ = @as(c_int, 4);
pub const __SIZEOF_INT128__ = @as(c_int, 16);
pub const __INTMAX_TYPE__ = c_long;
pub const __INTMAX_FMTd__ = "ld";
pub const __INTMAX_FMTi__ = "li";
pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`");
// (no file):95:9
pub const __UINTMAX_TYPE__ = c_ulong;
pub const __UINTMAX_FMTo__ = "lo";
pub const __UINTMAX_FMTu__ = "lu";
pub const __UINTMAX_FMTx__ = "lx";
pub const __UINTMAX_FMTX__ = "lX";
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`");
// (no file):101:9
pub const __PTRDIFF_TYPE__ = c_long;
pub const __PTRDIFF_FMTd__ = "ld";
pub const __PTRDIFF_FMTi__ = "li";
pub const __INTPTR_TYPE__ = c_long;
pub const __INTPTR_FMTd__ = "ld";
pub const __INTPTR_FMTi__ = "li";
pub const __SIZE_TYPE__ = c_ulong;
pub const __SIZE_FMTo__ = "lo";
pub const __SIZE_FMTu__ = "lu";
pub const __SIZE_FMTx__ = "lx";
pub const __SIZE_FMTX__ = "lX";
pub const __WCHAR_TYPE__ = c_int;
pub const __WINT_TYPE__ = c_uint;
pub const __SIG_ATOMIC_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __UINTPTR_TYPE__ = c_ulong;
pub const __UINTPTR_FMTo__ = "lo";
pub const __UINTPTR_FMTu__ = "lu";
pub const __UINTPTR_FMTx__ = "lx";
pub const __UINTPTR_FMTX__ = "lX";
pub const __FLT16_DENORM_MIN__ = @as(f16, 5.9604644775390625e-8);
pub const __FLT16_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_EPSILON__ = @as(f16, 9.765625e-4);
pub const __FLT16_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT16_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT16_MIN__ = @as(f16, 6.103515625e-5);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_HAS_DENORM__ = @as(c_int, 1);
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __DBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 3.64519953188247460253e-4951);
pub const __LDBL_HAS_DENORM__ = @as(c_int, 1);
pub const __LDBL_DIG__ = @as(c_int, 18);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 21);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 1.08420217248550443401e-19);
pub const __LDBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __LDBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __LDBL_MANT_DIG__ = @as(c_int, 64);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 4932);
pub const __LDBL_MAX_EXP__ = @as(c_int, 16384);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.18973149535723176502e+4932);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 4931);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 16381);
pub const __LDBL_MIN__ = @as(c_longdouble, 3.36210314311209350626e-4932);
pub const __POINTER_WIDTH__ = @as(c_int, 64);
pub const __BIGGEST_ALIGNMENT__ = @as(c_int, 16);
pub const __WINT_UNSIGNED__ = @as(c_int, 1);
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub const __INT64_TYPE__ = c_long;
pub const __INT64_FMTd__ = "ld";
pub const __INT64_FMTi__ = "li";
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`");
// (no file):198:9
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub const __UINT16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`");
// (no file):220:9
pub const __UINT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulong;
pub const __UINT64_FMTo__ = "lo";
pub const __UINT64_FMTu__ = "lu";
pub const __UINT64_FMTx__ = "lx";
pub const __UINT64_FMTX__ = "lX";
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`");
// (no file):228:9
pub const __UINT64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __INT64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_LEAST8_FMTd__ = "hhd";
pub const __INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const __UINT_LEAST8_FMTo__ = "hho";
pub const __UINT_LEAST8_FMTu__ = "hhu";
pub const __UINT_LEAST8_FMTx__ = "hhx";
pub const __UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_LEAST16_FMTd__ = "hd";
pub const __INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_LEAST16_FMTo__ = "ho";
pub const __UINT_LEAST16_FMTu__ = "hu";
pub const __UINT_LEAST16_FMTx__ = "hx";
pub const __UINT_LEAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_LEAST32_FMTd__ = "d";
pub const __INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_LEAST32_FMTo__ = "o";
pub const __UINT_LEAST32_FMTu__ = "u";
pub const __UINT_LEAST32_FMTx__ = "x";
pub const __UINT_LEAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_long;
pub const __INT_LEAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_LEAST64_FMTd__ = "ld";
pub const __INT_LEAST64_FMTi__ = "li";
pub const __UINT_LEAST64_TYPE__ = c_ulong;
pub const __UINT_LEAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINT_LEAST64_FMTo__ = "lo";
pub const __UINT_LEAST64_FMTu__ = "lu";
pub const __UINT_LEAST64_FMTx__ = "lx";
pub const __UINT_LEAST64_FMTX__ = "lX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_FAST8_FMTd__ = "hhd";
pub const __INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const __UINT_FAST8_FMTo__ = "hho";
pub const __UINT_FAST8_FMTu__ = "hhu";
pub const __UINT_FAST8_FMTx__ = "hhx";
pub const __UINT_FAST8_FMTX__ = "hhX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_FAST16_FMTd__ = "hd";
pub const __INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_FAST16_FMTo__ = "ho";
pub const __UINT_FAST16_FMTu__ = "hu";
pub const __UINT_FAST16_FMTx__ = "hx";
pub const __UINT_FAST16_FMTX__ = "hX";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_FAST32_FMTd__ = "d";
pub const __INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_FAST32_FMTo__ = "o";
pub const __UINT_FAST32_FMTu__ = "u";
pub const __UINT_FAST32_FMTx__ = "x";
pub const __UINT_FAST32_FMTX__ = "X";
pub const __INT_FAST64_TYPE__ = c_long;
pub const __INT_FAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_FAST64_FMTd__ = "ld";
pub const __INT_FAST64_FMTi__ = "li";
pub const __UINT_FAST64_TYPE__ = c_ulong;
pub const __UINT_FAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINT_FAST64_FMTo__ = "lo";
pub const __UINT_FAST64_FMTu__ = "lu";
pub const __UINT_FAST64_FMTx__ = "lx";
pub const __UINT_FAST64_FMTX__ = "lX";
pub const __USER_LABEL_PREFIX__ = "";
pub const __FINITE_MATH_ONLY__ = @as(c_int, 0);
pub const __GNUC_STDC_INLINE__ = @as(c_int, 1);
pub const __GCC_ATOMIC_TEST_AND_SET_TRUEVAL = @as(c_int, 1);
pub const __CLANG_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
pub const __NO_INLINE__ = @as(c_int, 1);
pub const __PIC__ = @as(c_int, 2);
pub const __pic__ = @as(c_int, 2);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __SSP_STRONG__ = @as(c_int, 2);
pub const __ELF__ = @as(c_int, 1);
pub const __GCC_ASM_FLAG_OUTPUTS__ = @as(c_int, 1);
pub const __code_model_small__ = @as(c_int, 1);
pub const __amd64__ = @as(c_int, 1);
pub const __amd64 = @as(c_int, 1);
pub const __x86_64 = @as(c_int, 1);
pub const __x86_64__ = @as(c_int, 1);
pub const __SEG_GS = @as(c_int, 1);
pub const __SEG_FS = @as(c_int, 1);
pub const __seg_gs = @compileError("unable to translate macro: undefined identifier `address_space`");
// (no file):358:9
pub const __seg_fs = @compileError("unable to translate macro: undefined identifier `address_space`");
// (no file):359:9
pub const __k8 = @as(c_int, 1);
pub const __k8__ = @as(c_int, 1);
pub const __tune_k8__ = @as(c_int, 1);
pub const __REGISTER_PREFIX__ = "";
pub const __NO_MATH_INLINES = @as(c_int, 1);
pub const __AES__ = @as(c_int, 1);
pub const __VAES__ = @as(c_int, 1);
pub const __PCLMUL__ = @as(c_int, 1);
pub const __VPCLMULQDQ__ = @as(c_int, 1);
pub const __LAHF_SAHF__ = @as(c_int, 1);
pub const __LZCNT__ = @as(c_int, 1);
pub const __RDRND__ = @as(c_int, 1);
pub const __FSGSBASE__ = @as(c_int, 1);
pub const __BMI__ = @as(c_int, 1);
pub const __BMI2__ = @as(c_int, 1);
pub const __POPCNT__ = @as(c_int, 1);
pub const __PRFCHW__ = @as(c_int, 1);
pub const __RDSEED__ = @as(c_int, 1);
pub const __ADX__ = @as(c_int, 1);
pub const __MOVBE__ = @as(c_int, 1);
pub const __FMA__ = @as(c_int, 1);
pub const __F16C__ = @as(c_int, 1);
pub const __GFNI__ = @as(c_int, 1);
pub const __AVX512CD__ = @as(c_int, 1);
pub const __AVX512VPOPCNTDQ__ = @as(c_int, 1);
pub const __AVX512VNNI__ = @as(c_int, 1);
pub const __AVX512DQ__ = @as(c_int, 1);
pub const __AVX512BITALG__ = @as(c_int, 1);
pub const __AVX512BW__ = @as(c_int, 1);
pub const __AVX512VL__ = @as(c_int, 1);
pub const __EVEX256__ = @as(c_int, 1);
pub const __AVX512VBMI__ = @as(c_int, 1);
pub const __AVX512VBMI2__ = @as(c_int, 1);
pub const __AVX512IFMA__ = @as(c_int, 1);
pub const __AVX512VP2INTERSECT__ = @as(c_int, 1);
pub const __SHA__ = @as(c_int, 1);
pub const __FXSR__ = @as(c_int, 1);
pub const __XSAVE__ = @as(c_int, 1);
pub const __XSAVEOPT__ = @as(c_int, 1);
pub const __XSAVEC__ = @as(c_int, 1);
pub const __XSAVES__ = @as(c_int, 1);
pub const __CLFLUSHOPT__ = @as(c_int, 1);
pub const __CLWB__ = @as(c_int, 1);
pub const __SHSTK__ = @as(c_int, 1);
pub const __RDPID__ = @as(c_int, 1);
pub const __MOVDIRI__ = @as(c_int, 1);
pub const __MOVDIR64B__ = @as(c_int, 1);
pub const __INVPCID__ = @as(c_int, 1);
pub const __AVX512F__ = @as(c_int, 1);
pub const __AVX2__ = @as(c_int, 1);
pub const __AVX__ = @as(c_int, 1);
pub const __SSE4_2__ = @as(c_int, 1);
pub const __SSE4_1__ = @as(c_int, 1);
pub const __SSSE3__ = @as(c_int, 1);
pub const __SSE3__ = @as(c_int, 1);
pub const __SSE2__ = @as(c_int, 1);
pub const __SSE2_MATH__ = @as(c_int, 1);
pub const __SSE__ = @as(c_int, 1);
pub const __SSE_MATH__ = @as(c_int, 1);
pub const __MMX__ = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_16 = @as(c_int, 1);
pub const __SIZEOF_FLOAT128__ = @as(c_int, 16);
pub const unix = @as(c_int, 1);
pub const __unix = @as(c_int, 1);
pub const __unix__ = @as(c_int, 1);
pub const linux = @as(c_int, 1);
pub const __linux = @as(c_int, 1);
pub const __linux__ = @as(c_int, 1);
pub const __gnu_linux__ = @as(c_int, 1);
pub const __FLOAT128__ = @as(c_int, 1);
pub const __STDC__ = @as(c_int, 1);
pub const __STDC_HOSTED__ = @as(c_int, 1);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const __GLIBC_MINOR__ = @as(c_int, 36);
pub const _DEBUG = @as(c_int, 1);
pub const __GCC_HAVE_DWARF2_CFI_ASM = @as(c_int, 1);
pub const LIBMDBX_H = "";
pub const __STDARG_H = "";
pub const __need___va_list = "";
pub const __need_va_list = "";
pub const __need_va_arg = "";
pub const __need___va_copy = "";
pub const __need_va_copy = "";
pub const __GNUC_VA_LIST = "";
pub const _VA_LIST = "";
pub const va_start = @compileError("unable to translate macro: undefined identifier `__builtin_va_start`");
// /home/theseyan/zig/lib/include/__stdarg_va_arg.h:17:9
pub const va_end = @compileError("unable to translate macro: undefined identifier `__builtin_va_end`");
// /home/theseyan/zig/lib/include/__stdarg_va_arg.h:19:9
pub const va_arg = @compileError("unable to translate C expr: unexpected token 'an identifier'");
// /home/theseyan/zig/lib/include/__stdarg_va_arg.h:20:9
pub const __va_copy = @compileError("unable to translate macro: undefined identifier `__builtin_va_copy`");
// /home/theseyan/zig/lib/include/__stdarg___va_copy.h:11:9
pub const va_copy = @compileError("unable to translate macro: undefined identifier `__builtin_va_copy`");
// /home/theseyan/zig/lib/include/__stdarg_va_copy.h:11:9
pub const __STDDEF_H = "";
pub const __need_ptrdiff_t = "";
pub const __need_size_t = "";
pub const __need_wchar_t = "";
pub const __need_NULL = "";
pub const __need_max_align_t = "";
pub const __need_offsetof = "";
pub const _PTRDIFF_T = "";
pub const _SIZE_T = "";
pub const _WCHAR_T = "";
pub const NULL = @import("std").zig.c_translation.cast(?*anyopaque, @as(c_int, 0));
pub const __CLANG_MAX_ALIGN_T_DEFINED = "";
pub const offsetof = @compileError("unable to translate C expr: unexpected token 'an identifier'");
// /home/theseyan/zig/lib/include/__stddef_offsetof.h:16:9
pub const __CLANG_STDINT_H = "";
pub const _STDINT_H = @as(c_int, 1);
pub const __GLIBC_INTERNAL_STARTING_HEADER_IMPLEMENTATION = "";
pub const _FEATURES_H = @as(c_int, 1);
pub const __KERNEL_STRICT_NAMES = "";
pub inline fn __GNUC_PREREQ(maj: anytype, min: anytype) @TypeOf(((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min);
}
pub inline fn __glibc_clang_prereq(maj: anytype, min: anytype) @TypeOf(((__clang_major__ << @as(c_int, 16)) + __clang_minor__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__clang_major__ << @as(c_int, 16)) + __clang_minor__) >= ((maj << @as(c_int, 16)) + min);
}
pub const __GLIBC_USE = @compileError("unable to translate macro: undefined identifier `__GLIBC_USE_`");
// /usr/include/features.h:186:9
pub const _DEFAULT_SOURCE = @as(c_int, 1);
pub const __GLIBC_USE_ISOC2X = @as(c_int, 0);
pub const __USE_ISOC11 = @as(c_int, 1);
pub const __USE_ISOC99 = @as(c_int, 1);
pub const __USE_ISOC95 = @as(c_int, 1);
pub const __USE_POSIX_IMPLICITLY = @as(c_int, 1);
pub const _POSIX_SOURCE = @as(c_int, 1);
pub const _POSIX_C_SOURCE = @as(c_long, 200809);
pub const __USE_POSIX = @as(c_int, 1);
pub const __USE_POSIX2 = @as(c_int, 1);
pub const __USE_POSIX199309 = @as(c_int, 1);
pub const __USE_POSIX199506 = @as(c_int, 1);
pub const __USE_XOPEN2K = @as(c_int, 1);
pub const __USE_XOPEN2K8 = @as(c_int, 1);
pub const _ATFILE_SOURCE = @as(c_int, 1);
pub const __WORDSIZE = @as(c_int, 64);
pub const __WORDSIZE_TIME64_COMPAT32 = @as(c_int, 1);
pub const __SYSCALL_WORDSIZE = @as(c_int, 64);
pub const __TIMESIZE = __WORDSIZE;
pub const __USE_MISC = @as(c_int, 1);
pub const __USE_ATFILE = @as(c_int, 1);
pub const __USE_FORTIFY_LEVEL = @as(c_int, 0);
pub const __GLIBC_USE_DEPRECATED_GETS = @as(c_int, 0);
pub const __GLIBC_USE_DEPRECATED_SCANF = @as(c_int, 0);
pub const _STDC_PREDEF_H = @as(c_int, 1);
pub const __STDC_IEC_559__ = @as(c_int, 1);
pub const __STDC_IEC_60559_BFP__ = @as(c_long, 201404);
pub const __STDC_IEC_559_COMPLEX__ = @as(c_int, 1);
pub const __STDC_IEC_60559_COMPLEX__ = @as(c_long, 201404);
pub const __STDC_ISO_10646__ = @as(c_long, 201706);
pub const __GNU_LIBRARY__ = @as(c_int, 6);
pub const __GLIBC__ = @as(c_int, 2);
pub inline fn __GLIBC_PREREQ(maj: anytype, min: anytype) @TypeOf(((__GLIBC__ << @as(c_int, 16)) + __GLIBC_MINOR__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__GLIBC__ << @as(c_int, 16)) + __GLIBC_MINOR__) >= ((maj << @as(c_int, 16)) + min);
}
pub const _SYS_CDEFS_H = @as(c_int, 1);
pub const __glibc_has_attribute = @compileError("unable to translate macro: undefined identifier `__has_attribute`");
// /usr/include/sys/cdefs.h:45:10
pub inline fn __glibc_has_builtin(name: anytype) @TypeOf(__has_builtin(name)) {
    _ = &name;
    return __has_builtin(name);
}
pub const __glibc_has_extension = @compileError("unable to translate macro: undefined identifier `__has_extension`");
// /usr/include/sys/cdefs.h:55:10
pub const __LEAF = "";
pub const __LEAF_ATTR = "";
pub const __THROW = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /usr/include/sys/cdefs.h:79:11
pub const __THROWNL = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /usr/include/sys/cdefs.h:80:11
pub const __NTH = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /usr/include/sys/cdefs.h:81:11
pub const __NTHNL = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /usr/include/sys/cdefs.h:82:11
pub inline fn __P(args: anytype) @TypeOf(args) {
    _ = &args;
    return args;
}
pub inline fn __PMT(args: anytype) @TypeOf(args) {
    _ = &args;
    return args;
}
pub const __CONCAT = @compileError("unable to translate C expr: unexpected token '##'");
// /usr/include/sys/cdefs.h:124:9
pub const __STRING = @compileError("unable to translate C expr: unexpected token '#'");
// /usr/include/sys/cdefs.h:125:9
pub const __ptr_t = ?*anyopaque;
pub const __BEGIN_DECLS = "";
pub const __END_DECLS = "";
pub inline fn __bos(ptr: anytype) @TypeOf(__builtin_object_size(ptr, __USE_FORTIFY_LEVEL > @as(c_int, 1))) {
    _ = &ptr;
    return __builtin_object_size(ptr, __USE_FORTIFY_LEVEL > @as(c_int, 1));
}
pub inline fn __bos0(ptr: anytype) @TypeOf(__builtin_object_size(ptr, @as(c_int, 0))) {
    _ = &ptr;
    return __builtin_object_size(ptr, @as(c_int, 0));
}
pub inline fn __glibc_objsize0(__o: anytype) @TypeOf(__bos0(__o)) {
    _ = &__o;
    return __bos0(__o);
}
pub inline fn __glibc_objsize(__o: anytype) @TypeOf(__bos(__o)) {
    _ = &__o;
    return __bos(__o);
}
pub const __warnattr = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:209:10
pub const __errordecl = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/sys/cdefs.h:210:10
pub const __flexarr = @compileError("unable to translate C expr: unexpected token '['");
// /usr/include/sys/cdefs.h:218:10
pub const __glibc_c99_flexarr_available = @as(c_int, 1);
pub const __REDIRECT = @compileError("unable to translate C expr: unexpected token '__asm__'");
// /usr/include/sys/cdefs.h:249:10
pub const __REDIRECT_NTH = @compileError("unable to translate C expr: unexpected token '__asm__'");
// /usr/include/sys/cdefs.h:256:11
pub const __REDIRECT_NTHNL = @compileError("unable to translate C expr: unexpected token '__asm__'");
// /usr/include/sys/cdefs.h:258:11
pub const __ASMNAME = @compileError("unable to translate C expr: unexpected token ','");
// /usr/include/sys/cdefs.h:261:10
pub inline fn __ASMNAME2(prefix: anytype, cname: anytype) @TypeOf(__STRING(prefix) ++ cname) {
    _ = &prefix;
    _ = &cname;
    return __STRING(prefix) ++ cname;
}
pub const __attribute_malloc__ = @compileError("unable to translate macro: undefined identifier `__malloc__`");
// /usr/include/sys/cdefs.h:283:10
pub const __attribute_alloc_size__ = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:294:10
pub const __attribute_alloc_align__ = @compileError("unable to translate macro: undefined identifier `__alloc_align__`");
// /usr/include/sys/cdefs.h:300:10
pub const __attribute_pure__ = @compileError("unable to translate macro: undefined identifier `__pure__`");
// /usr/include/sys/cdefs.h:310:10
pub const __attribute_const__ = @compileError("unable to translate C expr: unexpected token '__attribute__'");
// /usr/include/sys/cdefs.h:317:10
pub const __attribute_maybe_unused__ = @compileError("unable to translate macro: undefined identifier `__unused__`");
// /usr/include/sys/cdefs.h:323:10
pub const __attribute_used__ = @compileError("unable to translate macro: undefined identifier `__used__`");
// /usr/include/sys/cdefs.h:332:10
pub const __attribute_noinline__ = @compileError("unable to translate macro: undefined identifier `__noinline__`");
// /usr/include/sys/cdefs.h:333:10
pub const __attribute_deprecated__ = @compileError("unable to translate macro: undefined identifier `__deprecated__`");
// /usr/include/sys/cdefs.h:341:10
pub const __attribute_deprecated_msg__ = @compileError("unable to translate macro: undefined identifier `__deprecated__`");
// /usr/include/sys/cdefs.h:351:10
pub const __attribute_format_arg__ = @compileError("unable to translate macro: undefined identifier `__format_arg__`");
// /usr/include/sys/cdefs.h:364:10
pub const __attribute_format_strfmon__ = @compileError("unable to translate macro: undefined identifier `__format__`");
// /usr/include/sys/cdefs.h:374:10
pub const __attribute_nonnull__ = @compileError("unable to translate macro: undefined identifier `__nonnull__`");
// /usr/include/sys/cdefs.h:386:11
pub inline fn __nonnull(params: anytype) @TypeOf(__attribute_nonnull__(params)) {
    _ = &params;
    return __attribute_nonnull__(params);
}
pub const __returns_nonnull = @compileError("unable to translate macro: undefined identifier `__returns_nonnull__`");
// /usr/include/sys/cdefs.h:399:10
pub const __attribute_warn_unused_result__ = @compileError("unable to translate macro: undefined identifier `__warn_unused_result__`");
// /usr/include/sys/cdefs.h:408:10
pub const __wur = "";
pub const __always_inline = @compileError("unable to translate macro: undefined identifier `__always_inline__`");
// /usr/include/sys/cdefs.h:426:10
pub const __attribute_artificial__ = @compileError("unable to translate macro: undefined identifier `__artificial__`");
// /usr/include/sys/cdefs.h:435:10
pub const __extern_inline = @compileError("unable to translate macro: undefined identifier `__gnu_inline__`");
// /usr/include/sys/cdefs.h:453:11
pub const __extern_always_inline = @compileError("unable to translate macro: undefined identifier `__gnu_inline__`");
// /usr/include/sys/cdefs.h:454:11
pub const __fortify_function = __extern_always_inline ++ __attribute_artificial__;
pub const __restrict_arr = @compileError("unable to translate C expr: unexpected token '__restrict'");
// /usr/include/sys/cdefs.h:497:10
pub inline fn __glibc_unlikely(cond: anytype) @TypeOf(__builtin_expect(cond, @as(c_int, 0))) {
    _ = &cond;
    return __builtin_expect(cond, @as(c_int, 0));
}
pub inline fn __glibc_likely(cond: anytype) @TypeOf(__builtin_expect(cond, @as(c_int, 1))) {
    _ = &cond;
    return __builtin_expect(cond, @as(c_int, 1));
}
pub const __attribute_nonstring__ = "";
pub const __attribute_copy__ = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:546:10
pub const __LDOUBLE_REDIRECTS_TO_FLOAT128_ABI = @as(c_int, 0);
pub inline fn __LDBL_REDIR1(name: anytype, proto: anytype, alias: anytype) @TypeOf(name ++ proto) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return name ++ proto;
}
pub inline fn __LDBL_REDIR(name: anytype, proto: anytype) @TypeOf(name ++ proto) {
    _ = &name;
    _ = &proto;
    return name ++ proto;
}
pub inline fn __LDBL_REDIR1_NTH(name: anytype, proto: anytype, alias: anytype) @TypeOf(name ++ proto ++ __THROW) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return name ++ proto ++ __THROW;
}
pub inline fn __LDBL_REDIR_NTH(name: anytype, proto: anytype) @TypeOf(name ++ proto ++ __THROW) {
    _ = &name;
    _ = &proto;
    return name ++ proto ++ __THROW;
}
pub const __LDBL_REDIR2_DECL = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:622:10
pub const __LDBL_REDIR_DECL = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:623:10
pub inline fn __REDIRECT_LDBL(name: anytype, proto: anytype, alias: anytype) @TypeOf(__REDIRECT(name, proto, alias)) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return __REDIRECT(name, proto, alias);
}
pub inline fn __REDIRECT_NTH_LDBL(name: anytype, proto: anytype, alias: anytype) @TypeOf(__REDIRECT_NTH(name, proto, alias)) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return __REDIRECT_NTH(name, proto, alias);
}
pub const __glibc_macro_warning1 = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /usr/include/sys/cdefs.h:637:10
pub const __glibc_macro_warning = @compileError("unable to translate macro: undefined identifier `GCC`");
// /usr/include/sys/cdefs.h:638:10
pub const __HAVE_GENERIC_SELECTION = @as(c_int, 1);
pub const __fortified_attr_access = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:683:11
pub const __attr_access = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:684:11
pub const __attr_access_none = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:685:11
pub const __attr_dealloc = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:695:10
pub const __attr_dealloc_free = "";
pub const __attribute_returns_twice__ = @compileError("unable to translate macro: undefined identifier `__returns_twice__`");
// /usr/include/sys/cdefs.h:702:10
pub const __stub___compat_bdflush = "";
pub const __stub_chflags = "";
pub const __stub_fchflags = "";
pub const __stub_gtty = "";
pub const __stub_revoke = "";
pub const __stub_setlogin = "";
pub const __stub_sigreturn = "";
pub const __stub_stty = "";
pub const __GLIBC_USE_LIB_EXT2 = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_BFP_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_BFP_EXT_C2X = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_FUNCS_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_FUNCS_EXT_C2X = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_TYPES_EXT = @as(c_int, 0);
pub const _BITS_TYPES_H = @as(c_int, 1);
pub const __S16_TYPE = c_short;
pub const __U16_TYPE = c_ushort;
pub const __S32_TYPE = c_int;
pub const __U32_TYPE = c_uint;
pub const __SLONGWORD_TYPE = c_long;
pub const __ULONGWORD_TYPE = c_ulong;
pub const __SQUAD_TYPE = c_long;
pub const __UQUAD_TYPE = c_ulong;
pub const __SWORD_TYPE = c_long;
pub const __UWORD_TYPE = c_ulong;
pub const __SLONG32_TYPE = c_int;
pub const __ULONG32_TYPE = c_uint;
pub const __S64_TYPE = c_long;
pub const __U64_TYPE = c_ulong;
pub const __STD_TYPE = @compileError("unable to translate C expr: unexpected token 'typedef'");
// /usr/include/bits/types.h:137:10
pub const _BITS_TYPESIZES_H = @as(c_int, 1);
pub const __SYSCALL_SLONG_TYPE = __SLONGWORD_TYPE;
pub const __SYSCALL_ULONG_TYPE = __ULONGWORD_TYPE;
pub const __DEV_T_TYPE = __UQUAD_TYPE;
pub const __UID_T_TYPE = __U32_TYPE;
pub const __GID_T_TYPE = __U32_TYPE;
pub const __INO_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __INO64_T_TYPE = __UQUAD_TYPE;
pub const __MODE_T_TYPE = __U32_TYPE;
pub const __NLINK_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSWORD_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __OFF_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __OFF64_T_TYPE = __SQUAD_TYPE;
pub const __PID_T_TYPE = __S32_TYPE;
pub const __RLIM_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __RLIM64_T_TYPE = __UQUAD_TYPE;
pub const __BLKCNT_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __BLKCNT64_T_TYPE = __SQUAD_TYPE;
pub const __FSBLKCNT_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSBLKCNT64_T_TYPE = __UQUAD_TYPE;
pub const __FSFILCNT_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSFILCNT64_T_TYPE = __UQUAD_TYPE;
pub const __ID_T_TYPE = __U32_TYPE;
pub const __CLOCK_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __TIME_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __USECONDS_T_TYPE = __U32_TYPE;
pub const __SUSECONDS_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __SUSECONDS64_T_TYPE = __SQUAD_TYPE;
pub const __DADDR_T_TYPE = __S32_TYPE;
pub const __KEY_T_TYPE = __S32_TYPE;
pub const __CLOCKID_T_TYPE = __S32_TYPE;
pub const __TIMER_T_TYPE = ?*anyopaque;
pub const __BLKSIZE_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __FSID_T_TYPE = @compileError("unable to translate macro: undefined identifier `__val`");
// /usr/include/bits/typesizes.h:73:9
pub const __SSIZE_T_TYPE = __SWORD_TYPE;
pub const __CPU_MASK_TYPE = __SYSCALL_ULONG_TYPE;
pub const __OFF_T_MATCHES_OFF64_T = @as(c_int, 1);
pub const __INO_T_MATCHES_INO64_T = @as(c_int, 1);
pub const __RLIM_T_MATCHES_RLIM64_T = @as(c_int, 1);
pub const __STATFS_MATCHES_STATFS64 = @as(c_int, 1);
pub const __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 = @as(c_int, 1);
pub const __FD_SETSIZE = @as(c_int, 1024);
pub const _BITS_TIME64_H = @as(c_int, 1);
pub const __TIME64_T_TYPE = __TIME_T_TYPE;
pub const _BITS_WCHAR_H = @as(c_int, 1);
pub const __WCHAR_MAX = __WCHAR_MAX__;
pub const __WCHAR_MIN = -__WCHAR_MAX - @as(c_int, 1);
pub const _BITS_STDINT_INTN_H = @as(c_int, 1);
pub const _BITS_STDINT_UINTN_H = @as(c_int, 1);
pub const __intptr_t_defined = "";
pub const __INT64_C = @import("std").zig.c_translation.Macros.L_SUFFIX;
pub const __UINT64_C = @import("std").zig.c_translation.Macros.UL_SUFFIX;
pub const INT8_MIN = -@as(c_int, 128);
pub const INT16_MIN = -@as(c_int, 32767) - @as(c_int, 1);
pub const INT32_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const INT64_MIN = -__INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT8_MAX = @as(c_int, 127);
pub const INT16_MAX = @as(c_int, 32767);
pub const INT32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT64_MAX = __INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT8_MAX = @as(c_int, 255);
pub const UINT16_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT64_MAX = __UINT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INT_LEAST8_MIN = -@as(c_int, 128);
pub const INT_LEAST16_MIN = -@as(c_int, 32767) - @as(c_int, 1);
pub const INT_LEAST32_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const INT_LEAST64_MIN = -__INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT_LEAST8_MAX = @as(c_int, 127);
pub const INT_LEAST16_MAX = @as(c_int, 32767);
pub const INT_LEAST32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT_LEAST64_MAX = __INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT_LEAST8_MAX = @as(c_int, 255);
pub const UINT_LEAST16_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_LEAST32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_LEAST64_MAX = __UINT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INT_FAST8_MIN = -@as(c_int, 128);
pub const INT_FAST16_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INT_FAST32_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INT_FAST64_MIN = -__INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT_FAST8_MAX = @as(c_int, 127);
pub const INT_FAST16_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INT_FAST32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INT_FAST64_MAX = __INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT_FAST8_MAX = @as(c_int, 255);
pub const UINT_FAST16_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST64_MAX = __UINT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INTPTR_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INTPTR_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const UINTPTR_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const INTMAX_MIN = -__INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INTMAX_MAX = __INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINTMAX_MAX = __UINT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const PTRDIFF_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const PTRDIFF_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const SIG_ATOMIC_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const SIG_ATOMIC_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const SIZE_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const WCHAR_MIN = __WCHAR_MIN;
pub const WCHAR_MAX = __WCHAR_MAX;
pub const WINT_MIN = @as(c_uint, 0);
pub const WINT_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub inline fn INT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn INT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn INT32_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const INT64_C = @import("std").zig.c_translation.Macros.L_SUFFIX;
pub inline fn UINT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn UINT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const UINT32_C = @import("std").zig.c_translation.Macros.U_SUFFIX;
pub const UINT64_C = @import("std").zig.c_translation.Macros.UL_SUFFIX;
pub const INTMAX_C = @import("std").zig.c_translation.Macros.L_SUFFIX;
pub const UINTMAX_C = @import("std").zig.c_translation.Macros.UL_SUFFIX;
pub const _ASSERT_H = @as(c_int, 1);
pub const __ASSERT_VOID_CAST = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/assert.h:40:10
pub const _ASSERT_H_DECLS = "";
pub const assert = @compileError("unable to translate macro: undefined identifier `__FILE__`");
// /usr/include/assert.h:107:11
pub const __ASSERT_FUNCTION = @compileError("unable to translate C expr: unexpected token '__extension__'");
// /usr/include/assert.h:129:12
pub const static_assert = @compileError("unable to translate C expr: unexpected token '_Static_assert'");
// /usr/include/assert.h:143:10
pub const _ERRNO_H = @as(c_int, 1);
pub const _BITS_ERRNO_H = @as(c_int, 1);
pub const _ASM_GENERIC_ERRNO_H = "";
pub const _ASM_GENERIC_ERRNO_BASE_H = "";
pub const EPERM = @as(c_int, 1);
pub const ENOENT = @as(c_int, 2);
pub const ESRCH = @as(c_int, 3);
pub const EINTR = @as(c_int, 4);
pub const EIO = @as(c_int, 5);
pub const ENXIO = @as(c_int, 6);
pub const E2BIG = @as(c_int, 7);
pub const ENOEXEC = @as(c_int, 8);
pub const EBADF = @as(c_int, 9);
pub const ECHILD = @as(c_int, 10);
pub const EAGAIN = @as(c_int, 11);
pub const ENOMEM = @as(c_int, 12);
pub const EACCES = @as(c_int, 13);
pub const EFAULT = @as(c_int, 14);
pub const ENOTBLK = @as(c_int, 15);
pub const EBUSY = @as(c_int, 16);
pub const EEXIST = @as(c_int, 17);
pub const EXDEV = @as(c_int, 18);
pub const ENODEV = @as(c_int, 19);
pub const ENOTDIR = @as(c_int, 20);
pub const EISDIR = @as(c_int, 21);
pub const EINVAL = @as(c_int, 22);
pub const ENFILE = @as(c_int, 23);
pub const EMFILE = @as(c_int, 24);
pub const ENOTTY = @as(c_int, 25);
pub const ETXTBSY = @as(c_int, 26);
pub const EFBIG = @as(c_int, 27);
pub const ENOSPC = @as(c_int, 28);
pub const ESPIPE = @as(c_int, 29);
pub const EROFS = @as(c_int, 30);
pub const EMLINK = @as(c_int, 31);
pub const EPIPE = @as(c_int, 32);
pub const EDOM = @as(c_int, 33);
pub const ERANGE = @as(c_int, 34);
pub const EDEADLK = @as(c_int, 35);
pub const ENAMETOOLONG = @as(c_int, 36);
pub const ENOLCK = @as(c_int, 37);
pub const ENOSYS = @as(c_int, 38);
pub const ENOTEMPTY = @as(c_int, 39);
pub const ELOOP = @as(c_int, 40);
pub const EWOULDBLOCK = EAGAIN;
pub const ENOMSG = @as(c_int, 42);
pub const EIDRM = @as(c_int, 43);
pub const ECHRNG = @as(c_int, 44);
pub const EL2NSYNC = @as(c_int, 45);
pub const EL3HLT = @as(c_int, 46);
pub const EL3RST = @as(c_int, 47);
pub const ELNRNG = @as(c_int, 48);
pub const EUNATCH = @as(c_int, 49);
pub const ENOCSI = @as(c_int, 50);
pub const EL2HLT = @as(c_int, 51);
pub const EBADE = @as(c_int, 52);
pub const EBADR = @as(c_int, 53);
pub const EXFULL = @as(c_int, 54);
pub const ENOANO = @as(c_int, 55);
pub const EBADRQC = @as(c_int, 56);
pub const EBADSLT = @as(c_int, 57);
pub const EDEADLOCK = EDEADLK;
pub const EBFONT = @as(c_int, 59);
pub const ENOSTR = @as(c_int, 60);
pub const ENODATA = @as(c_int, 61);
pub const ETIME = @as(c_int, 62);
pub const ENOSR = @as(c_int, 63);
pub const ENONET = @as(c_int, 64);
pub const ENOPKG = @as(c_int, 65);
pub const EREMOTE = @as(c_int, 66);
pub const ENOLINK = @as(c_int, 67);
pub const EADV = @as(c_int, 68);
pub const ESRMNT = @as(c_int, 69);
pub const ECOMM = @as(c_int, 70);
pub const EPROTO = @as(c_int, 71);
pub const EMULTIHOP = @as(c_int, 72);
pub const EDOTDOT = @as(c_int, 73);
pub const EBADMSG = @as(c_int, 74);
pub const EOVERFLOW = @as(c_int, 75);
pub const ENOTUNIQ = @as(c_int, 76);
pub const EBADFD = @as(c_int, 77);
pub const EREMCHG = @as(c_int, 78);
pub const ELIBACC = @as(c_int, 79);
pub const ELIBBAD = @as(c_int, 80);
pub const ELIBSCN = @as(c_int, 81);
pub const ELIBMAX = @as(c_int, 82);
pub const ELIBEXEC = @as(c_int, 83);
pub const EILSEQ = @as(c_int, 84);
pub const ERESTART = @as(c_int, 85);
pub const ESTRPIPE = @as(c_int, 86);
pub const EUSERS = @as(c_int, 87);
pub const ENOTSOCK = @as(c_int, 88);
pub const EDESTADDRREQ = @as(c_int, 89);
pub const EMSGSIZE = @as(c_int, 90);
pub const EPROTOTYPE = @as(c_int, 91);
pub const ENOPROTOOPT = @as(c_int, 92);
pub const EPROTONOSUPPORT = @as(c_int, 93);
pub const ESOCKTNOSUPPORT = @as(c_int, 94);
pub const EOPNOTSUPP = @as(c_int, 95);
pub const EPFNOSUPPORT = @as(c_int, 96);
pub const EAFNOSUPPORT = @as(c_int, 97);
pub const EADDRINUSE = @as(c_int, 98);
pub const EADDRNOTAVAIL = @as(c_int, 99);
pub const ENETDOWN = @as(c_int, 100);
pub const ENETUNREACH = @as(c_int, 101);
pub const ENETRESET = @as(c_int, 102);
pub const ECONNABORTED = @as(c_int, 103);
pub const ECONNRESET = @as(c_int, 104);
pub const ENOBUFS = @as(c_int, 105);
pub const EISCONN = @as(c_int, 106);
pub const ENOTCONN = @as(c_int, 107);
pub const ESHUTDOWN = @as(c_int, 108);
pub const ETOOMANYREFS = @as(c_int, 109);
pub const ETIMEDOUT = @as(c_int, 110);
pub const ECONNREFUSED = @as(c_int, 111);
pub const EHOSTDOWN = @as(c_int, 112);
pub const EHOSTUNREACH = @as(c_int, 113);
pub const EALREADY = @as(c_int, 114);
pub const EINPROGRESS = @as(c_int, 115);
pub const ESTALE = @as(c_int, 116);
pub const EUCLEAN = @as(c_int, 117);
pub const ENOTNAM = @as(c_int, 118);
pub const ENAVAIL = @as(c_int, 119);
pub const EISNAM = @as(c_int, 120);
pub const EREMOTEIO = @as(c_int, 121);
pub const EDQUOT = @as(c_int, 122);
pub const ENOMEDIUM = @as(c_int, 123);
pub const EMEDIUMTYPE = @as(c_int, 124);
pub const ECANCELED = @as(c_int, 125);
pub const ENOKEY = @as(c_int, 126);
pub const EKEYEXPIRED = @as(c_int, 127);
pub const EKEYREVOKED = @as(c_int, 128);
pub const EKEYREJECTED = @as(c_int, 129);
pub const EOWNERDEAD = @as(c_int, 130);
pub const ENOTRECOVERABLE = @as(c_int, 131);
pub const ERFKILL = @as(c_int, 132);
pub const EHWPOISON = @as(c_int, 133);
pub const ENOTSUP = EOPNOTSUPP;
pub const errno = __errno_location().*;
pub const _PTHREAD_H = @as(c_int, 1);
pub const _SCHED_H = @as(c_int, 1);
pub const __time_t_defined = @as(c_int, 1);
pub const _STRUCT_TIMESPEC = @as(c_int, 1);
pub const _BITS_ENDIAN_H = @as(c_int, 1);
pub const __LITTLE_ENDIAN = @as(c_int, 1234);
pub const __BIG_ENDIAN = @as(c_int, 4321);
pub const __PDP_ENDIAN = @as(c_int, 3412);
pub const _BITS_ENDIANNESS_H = @as(c_int, 1);
pub const __BYTE_ORDER = __LITTLE_ENDIAN;
pub const __FLOAT_WORD_ORDER = __BYTE_ORDER;
pub inline fn __LONG_LONG_PAIR(HI: anytype, LO: anytype) @TypeOf(HI) {
    _ = &HI;
    _ = &LO;
    return blk: {
        _ = &LO;
        break :blk HI;
    };
}
pub const __pid_t_defined = "";
pub const _BITS_SCHED_H = @as(c_int, 1);
pub const SCHED_OTHER = @as(c_int, 0);
pub const SCHED_FIFO = @as(c_int, 1);
pub const SCHED_RR = @as(c_int, 2);
pub const _BITS_TYPES_STRUCT_SCHED_PARAM = @as(c_int, 1);
pub const _BITS_CPU_SET_H = @as(c_int, 1);
pub const __CPU_SETSIZE = @as(c_int, 1024);
pub const __NCPUBITS = @as(c_int, 8) * @import("std").zig.c_translation.sizeof(__cpu_mask);
pub inline fn __CPUELT(cpu: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div(cpu, __NCPUBITS)) {
    _ = &cpu;
    return @import("std").zig.c_translation.MacroArithmetic.div(cpu, __NCPUBITS);
}
pub inline fn __CPUMASK(cpu: anytype) @TypeOf(@import("std").zig.c_translation.cast(__cpu_mask, @as(c_int, 1)) << @import("std").zig.c_translation.MacroArithmetic.rem(cpu, __NCPUBITS)) {
    _ = &cpu;
    return @import("std").zig.c_translation.cast(__cpu_mask, @as(c_int, 1)) << @import("std").zig.c_translation.MacroArithmetic.rem(cpu, __NCPUBITS);
}
pub const __CPU_ZERO_S = @compileError("unable to translate C expr: unexpected token 'do'");
// /usr/include/bits/cpu-set.h:46:10
pub const __CPU_SET_S = @compileError("unable to translate macro: undefined identifier `__cpu`");
// /usr/include/bits/cpu-set.h:58:9
pub const __CPU_CLR_S = @compileError("unable to translate macro: undefined identifier `__cpu`");
// /usr/include/bits/cpu-set.h:65:9
pub const __CPU_ISSET_S = @compileError("unable to translate macro: undefined identifier `__cpu`");
// /usr/include/bits/cpu-set.h:72:9
pub inline fn __CPU_COUNT_S(setsize: anytype, cpusetp: anytype) @TypeOf(__sched_cpucount(setsize, cpusetp)) {
    _ = &setsize;
    _ = &cpusetp;
    return __sched_cpucount(setsize, cpusetp);
}
pub const __CPU_EQUAL_S = @compileError("unable to translate macro: undefined identifier `__builtin_memcmp`");
// /usr/include/bits/cpu-set.h:84:10
pub const __CPU_OP_S = @compileError("unable to translate macro: undefined identifier `__dest`");
// /usr/include/bits/cpu-set.h:99:9
pub inline fn __CPU_ALLOC_SIZE(count: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div((count + __NCPUBITS) - @as(c_int, 1), __NCPUBITS) * @import("std").zig.c_translation.sizeof(__cpu_mask)) {
    _ = &count;
    return @import("std").zig.c_translation.MacroArithmetic.div((count + __NCPUBITS) - @as(c_int, 1), __NCPUBITS) * @import("std").zig.c_translation.sizeof(__cpu_mask);
}
pub inline fn __CPU_ALLOC(count: anytype) @TypeOf(__sched_cpualloc(count)) {
    _ = &count;
    return __sched_cpualloc(count);
}
pub inline fn __CPU_FREE(cpuset: anytype) @TypeOf(__sched_cpufree(cpuset)) {
    _ = &cpuset;
    return __sched_cpufree(cpuset);
}
pub const __sched_priority = @compileError("unable to translate macro: undefined identifier `sched_priority`");
// /usr/include/sched.h:48:9
pub const _TIME_H = @as(c_int, 1);
pub const _BITS_TIME_H = @as(c_int, 1);
pub const CLOCKS_PER_SEC = @import("std").zig.c_translation.cast(__clock_t, @import("std").zig.c_translation.promoteIntLiteral(c_int, 1000000, .decimal));
pub const CLOCK_REALTIME = @as(c_int, 0);
pub const CLOCK_MONOTONIC = @as(c_int, 1);
pub const CLOCK_PROCESS_CPUTIME_ID = @as(c_int, 2);
pub const CLOCK_THREAD_CPUTIME_ID = @as(c_int, 3);
pub const CLOCK_MONOTONIC_RAW = @as(c_int, 4);
pub const CLOCK_REALTIME_COARSE = @as(c_int, 5);
pub const CLOCK_MONOTONIC_COARSE = @as(c_int, 6);
pub const CLOCK_BOOTTIME = @as(c_int, 7);
pub const CLOCK_REALTIME_ALARM = @as(c_int, 8);
pub const CLOCK_BOOTTIME_ALARM = @as(c_int, 9);
pub const CLOCK_TAI = @as(c_int, 11);
pub const TIMER_ABSTIME = @as(c_int, 1);
pub const __clock_t_defined = @as(c_int, 1);
pub const __struct_tm_defined = @as(c_int, 1);
pub const __clockid_t_defined = @as(c_int, 1);
pub const __timer_t_defined = @as(c_int, 1);
pub const __itimerspec_defined = @as(c_int, 1);
pub const _BITS_TYPES_LOCALE_T_H = @as(c_int, 1);
pub const _BITS_TYPES___LOCALE_T_H = @as(c_int, 1);
pub const TIME_UTC = @as(c_int, 1);
pub inline fn __isleap(year: anytype) @TypeOf((@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 4)) == @as(c_int, 0)) and ((@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 100)) != @as(c_int, 0)) or (@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 400)) == @as(c_int, 0)))) {
    _ = &year;
    return (@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 4)) == @as(c_int, 0)) and ((@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 100)) != @as(c_int, 0)) or (@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 400)) == @as(c_int, 0)));
}
pub const _BITS_PTHREADTYPES_COMMON_H = @as(c_int, 1);
pub const _THREAD_SHARED_TYPES_H = @as(c_int, 1);
pub const _BITS_PTHREADTYPES_ARCH_H = @as(c_int, 1);
pub const __SIZEOF_PTHREAD_MUTEX_T = @as(c_int, 40);
pub const __SIZEOF_PTHREAD_ATTR_T = @as(c_int, 56);
pub const __SIZEOF_PTHREAD_RWLOCK_T = @as(c_int, 56);
pub const __SIZEOF_PTHREAD_BARRIER_T = @as(c_int, 32);
pub const __SIZEOF_PTHREAD_MUTEXATTR_T = @as(c_int, 4);
pub const __SIZEOF_PTHREAD_COND_T = @as(c_int, 48);
pub const __SIZEOF_PTHREAD_CONDATTR_T = @as(c_int, 4);
pub const __SIZEOF_PTHREAD_RWLOCKATTR_T = @as(c_int, 8);
pub const __SIZEOF_PTHREAD_BARRIERATTR_T = @as(c_int, 4);
pub const __LOCK_ALIGNMENT = "";
pub const __ONCE_ALIGNMENT = "";
pub const _BITS_ATOMIC_WIDE_COUNTER_H = "";
pub const _THREAD_MUTEX_INTERNAL_H = @as(c_int, 1);
pub const __PTHREAD_MUTEX_HAVE_PREV = @as(c_int, 1);
pub const __PTHREAD_MUTEX_INITIALIZER = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/bits/struct_mutex.h:56:10
pub const _RWLOCK_INTERNAL_H = "";
pub const __PTHREAD_RWLOCK_ELISION_EXTRA = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/bits/struct_rwlock.h:40:11
pub inline fn __PTHREAD_RWLOCK_INITIALIZER(__flags: anytype) @TypeOf(__flags) {
    _ = &__flags;
    return blk: {
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = &__PTHREAD_RWLOCK_ELISION_EXTRA;
        _ = @as(c_int, 0);
        break :blk __flags;
    };
}
pub const __ONCE_FLAG_INIT = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/bits/thread-shared-types.h:113:9
pub const __have_pthread_attr_t = @as(c_int, 1);
pub const _BITS_SETJMP_H = @as(c_int, 1);
pub const ____sigset_t_defined = "";
pub const _SIGSET_NWORDS = @import("std").zig.c_translation.MacroArithmetic.div(@as(c_int, 1024), @as(c_int, 8) * @import("std").zig.c_translation.sizeof(c_ulong));
pub const __jmp_buf_tag_defined = @as(c_int, 1);
pub const PTHREAD_STACK_MIN = @as(c_int, 16384);
pub const PTHREAD_MUTEX_INITIALIZER = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/pthread.h:90:9
pub const PTHREAD_RWLOCK_INITIALIZER = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/pthread.h:114:10
pub const PTHREAD_COND_INITIALIZER = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/pthread.h:155:9
pub const PTHREAD_CANCELED = @import("std").zig.c_translation.cast(?*anyopaque, -@as(c_int, 1));
pub const PTHREAD_ONCE_INIT = @as(c_int, 0);
pub const PTHREAD_BARRIER_SERIAL_THREAD = -@as(c_int, 1);
pub const __cleanup_fct_attribute = "";
pub const pthread_cleanup_push = @compileError("unable to translate macro: undefined identifier `__cancel_buf`");
// /usr/include/pthread.h:681:10
pub const pthread_cleanup_pop = @compileError("unable to translate macro: undefined identifier `__cancel_buf`");
// /usr/include/pthread.h:702:10
pub inline fn __sigsetjmp_cancel(env: anytype, savemask: anytype) @TypeOf(__sigsetjmp(@import("std").zig.c_translation.cast([*c]struct___jmp_buf_tag, @import("std").zig.c_translation.cast(?*anyopaque, env)), savemask)) {
    _ = &env;
    _ = &savemask;
    return __sigsetjmp(@import("std").zig.c_translation.cast([*c]struct___jmp_buf_tag, @import("std").zig.c_translation.cast(?*anyopaque, env)), savemask);
}
pub const _SYS_TYPES_H = @as(c_int, 1);
pub const __u_char_defined = "";
pub const __ino_t_defined = "";
pub const __dev_t_defined = "";
pub const __gid_t_defined = "";
pub const __mode_t_defined = "";
pub const __nlink_t_defined = "";
pub const __uid_t_defined = "";
pub const __off_t_defined = "";
pub const __id_t_defined = "";
pub const __ssize_t_defined = "";
pub const __daddr_t_defined = "";
pub const __key_t_defined = "";
pub const __BIT_TYPES_DEFINED__ = @as(c_int, 1);
pub const _ENDIAN_H = @as(c_int, 1);
pub const LITTLE_ENDIAN = __LITTLE_ENDIAN;
pub const BIG_ENDIAN = __BIG_ENDIAN;
pub const PDP_ENDIAN = __PDP_ENDIAN;
pub const BYTE_ORDER = __BYTE_ORDER;
pub const _BITS_BYTESWAP_H = @as(c_int, 1);
pub inline fn __bswap_constant_16(x: anytype) __uint16_t {
    _ = &x;
    return @import("std").zig.c_translation.cast(__uint16_t, ((x >> @as(c_int, 8)) & @as(c_int, 0xff)) | ((x & @as(c_int, 0xff)) << @as(c_int, 8)));
}
pub inline fn __bswap_constant_32(x: anytype) @TypeOf(((((x & @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0xff000000, .hex)) >> @as(c_int, 24)) | ((x & @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00ff0000, .hex)) >> @as(c_int, 8))) | ((x & @as(c_uint, 0x0000ff00)) << @as(c_int, 8))) | ((x & @as(c_uint, 0x000000ff)) << @as(c_int, 24))) {
    _ = &x;
    return ((((x & @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0xff000000, .hex)) >> @as(c_int, 24)) | ((x & @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00ff0000, .hex)) >> @as(c_int, 8))) | ((x & @as(c_uint, 0x0000ff00)) << @as(c_int, 8))) | ((x & @as(c_uint, 0x000000ff)) << @as(c_int, 24));
}
pub inline fn __bswap_constant_64(x: anytype) @TypeOf(((((((((x & @as(c_ulonglong, 0xff00000000000000)) >> @as(c_int, 56)) | ((x & @as(c_ulonglong, 0x00ff000000000000)) >> @as(c_int, 40))) | ((x & @as(c_ulonglong, 0x0000ff0000000000)) >> @as(c_int, 24))) | ((x & @as(c_ulonglong, 0x000000ff00000000)) >> @as(c_int, 8))) | ((x & @as(c_ulonglong, 0x00000000ff000000)) << @as(c_int, 8))) | ((x & @as(c_ulonglong, 0x0000000000ff0000)) << @as(c_int, 24))) | ((x & @as(c_ulonglong, 0x000000000000ff00)) << @as(c_int, 40))) | ((x & @as(c_ulonglong, 0x00000000000000ff)) << @as(c_int, 56))) {
    _ = &x;
    return ((((((((x & @as(c_ulonglong, 0xff00000000000000)) >> @as(c_int, 56)) | ((x & @as(c_ulonglong, 0x00ff000000000000)) >> @as(c_int, 40))) | ((x & @as(c_ulonglong, 0x0000ff0000000000)) >> @as(c_int, 24))) | ((x & @as(c_ulonglong, 0x000000ff00000000)) >> @as(c_int, 8))) | ((x & @as(c_ulonglong, 0x00000000ff000000)) << @as(c_int, 8))) | ((x & @as(c_ulonglong, 0x0000000000ff0000)) << @as(c_int, 24))) | ((x & @as(c_ulonglong, 0x000000000000ff00)) << @as(c_int, 40))) | ((x & @as(c_ulonglong, 0x00000000000000ff)) << @as(c_int, 56));
}
pub const _BITS_UINTN_IDENTITY_H = @as(c_int, 1);
pub inline fn htobe16(x: anytype) @TypeOf(__bswap_16(x)) {
    _ = &x;
    return __bswap_16(x);
}
pub inline fn htole16(x: anytype) @TypeOf(__uint16_identity(x)) {
    _ = &x;
    return __uint16_identity(x);
}
pub inline fn be16toh(x: anytype) @TypeOf(__bswap_16(x)) {
    _ = &x;
    return __bswap_16(x);
}
pub inline fn le16toh(x: anytype) @TypeOf(__uint16_identity(x)) {
    _ = &x;
    return __uint16_identity(x);
}
pub inline fn htobe32(x: anytype) @TypeOf(__bswap_32(x)) {
    _ = &x;
    return __bswap_32(x);
}
pub inline fn htole32(x: anytype) @TypeOf(__uint32_identity(x)) {
    _ = &x;
    return __uint32_identity(x);
}
pub inline fn be32toh(x: anytype) @TypeOf(__bswap_32(x)) {
    _ = &x;
    return __bswap_32(x);
}
pub inline fn le32toh(x: anytype) @TypeOf(__uint32_identity(x)) {
    _ = &x;
    return __uint32_identity(x);
}
pub inline fn htobe64(x: anytype) @TypeOf(__bswap_64(x)) {
    _ = &x;
    return __bswap_64(x);
}
pub inline fn htole64(x: anytype) @TypeOf(__uint64_identity(x)) {
    _ = &x;
    return __uint64_identity(x);
}
pub inline fn be64toh(x: anytype) @TypeOf(__bswap_64(x)) {
    _ = &x;
    return __bswap_64(x);
}
pub inline fn le64toh(x: anytype) @TypeOf(__uint64_identity(x)) {
    _ = &x;
    return __uint64_identity(x);
}
pub const _SYS_SELECT_H = @as(c_int, 1);
pub const __FD_ZERO = @compileError("unable to translate macro: undefined identifier `__i`");
// /usr/include/bits/select.h:25:9
pub const __FD_SET = @compileError("unable to translate C expr: expected ')' instead got '|='");
// /usr/include/bits/select.h:32:9
pub const __FD_CLR = @compileError("unable to translate C expr: expected ')' instead got '&='");
// /usr/include/bits/select.h:34:9
pub inline fn __FD_ISSET(d: anytype, s: anytype) @TypeOf((__FDS_BITS(s)[@as(usize, @intCast(__FD_ELT(d)))] & __FD_MASK(d)) != @as(c_int, 0)) {
    _ = &d;
    _ = &s;
    return (__FDS_BITS(s)[@as(usize, @intCast(__FD_ELT(d)))] & __FD_MASK(d)) != @as(c_int, 0);
}
pub const __sigset_t_defined = @as(c_int, 1);
pub const __timeval_defined = @as(c_int, 1);
pub const __suseconds_t_defined = "";
pub const __NFDBITS = @as(c_int, 8) * @import("std").zig.c_translation.cast(c_int, @import("std").zig.c_translation.sizeof(__fd_mask));
pub inline fn __FD_ELT(d: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div(d, __NFDBITS)) {
    _ = &d;
    return @import("std").zig.c_translation.MacroArithmetic.div(d, __NFDBITS);
}
pub inline fn __FD_MASK(d: anytype) __fd_mask {
    _ = &d;
    return @import("std").zig.c_translation.cast(__fd_mask, @as(c_ulong, 1) << @import("std").zig.c_translation.MacroArithmetic.rem(d, __NFDBITS));
}
pub inline fn __FDS_BITS(set: anytype) @TypeOf(set.*.__fds_bits) {
    _ = &set;
    return set.*.__fds_bits;
}
pub const FD_SETSIZE = __FD_SETSIZE;
pub const NFDBITS = __NFDBITS;
pub inline fn FD_SET(fd: anytype, fdsetp: anytype) @TypeOf(__FD_SET(fd, fdsetp)) {
    _ = &fd;
    _ = &fdsetp;
    return __FD_SET(fd, fdsetp);
}
pub inline fn FD_CLR(fd: anytype, fdsetp: anytype) @TypeOf(__FD_CLR(fd, fdsetp)) {
    _ = &fd;
    _ = &fdsetp;
    return __FD_CLR(fd, fdsetp);
}
pub inline fn FD_ISSET(fd: anytype, fdsetp: anytype) @TypeOf(__FD_ISSET(fd, fdsetp)) {
    _ = &fd;
    _ = &fdsetp;
    return __FD_ISSET(fd, fdsetp);
}
pub inline fn FD_ZERO(fdsetp: anytype) @TypeOf(__FD_ZERO(fdsetp)) {
    _ = &fdsetp;
    return __FD_ZERO(fdsetp);
}
pub const __blksize_t_defined = "";
pub const __blkcnt_t_defined = "";
pub const __fsblkcnt_t_defined = "";
pub const __fsfilcnt_t_defined = "";
pub const _SYS_UIO_H = @as(c_int, 1);
pub const __iovec_defined = @as(c_int, 1);
pub const _BITS_UIO_LIM_H = @as(c_int, 1);
pub const __IOV_MAX = @as(c_int, 1024);
pub const UIO_MAXIOV = __IOV_MAX;
pub const HAVE_STRUCT_IOVEC = @as(c_int, 1);
pub inline fn __has_cpp_attribute(x: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &x;
    return @as(c_int, 0);
}
pub inline fn __has_CXX_attribute(x: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &x;
    return @as(c_int, 0);
}
pub inline fn __has_C23_or_CXX_attribute(x: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &x;
    return @as(c_int, 0);
}
pub const __has_exceptions_disabled = @compileError("unable to translate macro: undefined identifier `__has_feature`");
// mdbx.h:223:9
pub const MDBX_PURE_FUNCTION = @compileError("unable to translate macro: undefined identifier `__pure__`");
// mdbx.h:250:9
pub const MDBX_NOTHROW_PURE_FUNCTION = @compileError("unable to translate macro: undefined identifier `__pure__`");
// mdbx.h:268:9
pub const MDBX_CONST_FUNCTION = @compileError("unable to translate C expr: unexpected token '__attribute__'");
// mdbx.h:294:9
pub const MDBX_NOTHROW_CONST_FUNCTION = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// mdbx.h:312:9
pub const MDBX_DEPRECATED = "";
pub const MDBX_DEPRECATED_ENUM = "";
pub const __dll_export = @compileError("unable to translate macro: undefined identifier `__visibility__`");
// mdbx.h:361:9
pub const __dll_import = "";
pub const LIBMDBX_INLINE_API = @compileError("unable to translate C expr: unexpected token 'static'");
// mdbx.h:391:9
pub const MDBX_STRINGIFY_HELPER = @compileError("unable to translate C expr: unexpected token '#'");
// mdbx.h:396:9
pub inline fn MDBX_STRINGIFY(x: anytype) @TypeOf(MDBX_STRINGIFY_HELPER(x)) {
    _ = &x;
    return MDBX_STRINGIFY_HELPER(x);
}
pub const @"bool" = bool;
pub const @"true" = @as(c_int, 1);
pub const @"false" = @as(c_int, 0);
pub const MDBX_CXX17_NOEXCEPT = "";
pub const MDBX_CXX01_CONSTEXPR = @compileError("unable to translate C expr: unexpected token '__inline'");
// mdbx.h:429:9
pub const MDBX_CXX01_CONSTEXPR_VAR = @compileError("unable to translate C expr: unexpected token 'const'");
// mdbx.h:430:9
pub const MDBX_CXX11_CONSTEXPR = @compileError("unable to translate C expr: unexpected token '__inline'");
// mdbx.h:452:9
pub const MDBX_CXX11_CONSTEXPR_VAR = @compileError("unable to translate C expr: unexpected token 'const'");
// mdbx.h:453:9
pub const MDBX_CXX14_CONSTEXPR = @compileError("unable to translate C expr: unexpected token '__inline'");
// mdbx.h:474:9
pub const MDBX_CXX14_CONSTEXPR_VAR = @compileError("unable to translate C expr: unexpected token 'const'");
// mdbx.h:475:9
pub const MDBX_NORETURN = @compileError("unable to translate macro: undefined identifier `__noreturn__`");
// mdbx.h:498:9
pub const MDBX_PRINTF_ARGS = @compileError("unable to translate macro: undefined identifier `__format__`");
// mdbx.h:511:9
pub const MDBX_MAYBE_UNUSED = @compileError("unable to translate macro: undefined identifier `__unused__`");
// mdbx.h:527:9
pub const MDBX_NOSANITIZE_ENUM = @compileError("unable to translate macro: undefined identifier `__no_sanitize__`");
// mdbx.h:533:9
pub const DEFINE_ENUM_FLAG_OPERATORS = @compileError("unable to translate C expr: unexpected token ''");
// mdbx.h:600:9
pub const CONSTEXPR_ENUM_FLAGS_OPERATIONS = @as(c_int, 1);
pub const MDBX_VERSION_MAJOR = @as(c_int, 0);
pub const MDBX_VERSION_MINOR = @as(c_int, 13);
pub const LIBMDBX_API = "";
pub const LIBMDBX_API_TYPE = "";
pub const LIBMDBX_VERINFO_API = __dll_export;
pub const MDBX_LOCKNAME = "/mdbx.lck";
pub const MDBX_DATANAME = "/mdbx.dat";
pub const MDBX_LOCK_SUFFIX = "-lck";
pub const MDBX_LOGGER_DONTCHANGE = @import("std").zig.c_translation.cast([*c]MDBX_debug_func, @import("std").zig.c_translation.cast(isize, -@as(c_int, 1)));
pub const MDBX_LOGGER_NOFMT_DONTCHANGE = @import("std").zig.c_translation.cast([*c]MDBX_debug_func_nofmt, @import("std").zig.c_translation.cast(isize, -@as(c_int, 1)));
pub const MDBX_MAP_RESIZED = MDBX_MAP_RESIZED_is_deprecated();
pub inline fn mdbx_env_openT(env: anytype, pathname: anytype, flags: anytype, mode: anytype) @TypeOf(mdbx_env_open(env, pathname, flags, mode)) {
    _ = &env;
    _ = &pathname;
    _ = &flags;
    _ = &mode;
    return mdbx_env_open(env, pathname, flags, mode);
}
pub inline fn mdbx_env_deleteT(pathname: anytype, mode: anytype) @TypeOf(mdbx_env_delete(pathname, mode)) {
    _ = &pathname;
    _ = &mode;
    return mdbx_env_delete(pathname, mode);
}
pub inline fn mdbx_env_copyT(env: anytype, dest: anytype, flags: anytype) @TypeOf(mdbx_env_copy(env, dest, flags)) {
    _ = &env;
    _ = &dest;
    _ = &flags;
    return mdbx_env_copy(env, dest, flags);
}
pub const mdbx_txn_copy2pathnameT = @compileError("unable to translate macro: undefined identifier `path`");
// mdbx.h:2753:9
pub inline fn mdbx_env_get_pathT(env: anytype, dest: anytype) @TypeOf(mdbx_env_get_path(env, dest)) {
    _ = &env;
    _ = &dest;
    return mdbx_env_get_path(env, dest);
}
pub const MDBX_EPSILON = @import("std").zig.c_translation.cast([*c]MDBX_val, @import("std").zig.c_translation.cast(ptrdiff_t, -@as(c_int, 1)));
pub inline fn mdbx_env_open_for_recoveryT(env: anytype, pathname: anytype, target_mets: anytype, writeable: anytype) @TypeOf(mdbx_env_open_for_recovery(env, pathname, target_mets, writeable)) {
    _ = &env;
    _ = &pathname;
    _ = &target_mets;
    _ = &writeable;
    return mdbx_env_open_for_recovery(env, pathname, target_mets, writeable);
}
pub inline fn mdbx_preopen_snapinfoT(pathname: anytype, info: anytype, bytes: anytype) @TypeOf(mdbx_preopen_snapinfo(pathname, info, bytes)) {
    _ = &pathname;
    _ = &info;
    _ = &bytes;
    return mdbx_preopen_snapinfo(pathname, info, bytes);
}
pub const MDBX_CHK_MAIN = @import("std").zig.c_translation.cast(?*anyopaque, @import("std").zig.c_translation.cast(ptrdiff_t, @as(c_int, 0)));
pub const MDBX_CHK_GC = @import("std").zig.c_translation.cast(?*anyopaque, @import("std").zig.c_translation.cast(ptrdiff_t, -@as(c_int, 1)));
pub const MDBX_CHK_META = @import("std").zig.c_translation.cast(?*anyopaque, @import("std").zig.c_translation.cast(ptrdiff_t, -@as(c_int, 2)));
pub const timespec = struct_timespec;
pub const sched_param = struct_sched_param;
pub const tm = struct_tm;
pub const itimerspec = struct_itimerspec;
pub const sigevent = struct_sigevent;
pub const __locale_struct = struct___locale_struct;
pub const __pthread_internal_list = struct___pthread_internal_list;
pub const __pthread_internal_slist = struct___pthread_internal_slist;
pub const __pthread_mutex_s = struct___pthread_mutex_s;
pub const __pthread_rwlock_arch_t = struct___pthread_rwlock_arch_t;
pub const __pthread_cond_s = struct___pthread_cond_s;
pub const __jmp_buf_tag = struct___jmp_buf_tag;
pub const _pthread_cleanup_buffer = struct__pthread_cleanup_buffer;
pub const __cancel_jmp_buf_tag = struct___cancel_jmp_buf_tag;
pub const __pthread_cleanup_frame = struct___pthread_cleanup_frame;
pub const timeval = struct_timeval;
pub const iovec = struct_iovec;
pub const MDBX_version_info = struct_MDBX_version_info;
pub const MDBX_build_info = struct_MDBX_build_info;
pub const MDBX_constants = enum_MDBX_constants;
pub const MDBX_log_level = enum_MDBX_log_level;
pub const MDBX_debug_flags = enum_MDBX_debug_flags;
pub const MDBX_env_flags = enum_MDBX_env_flags;
pub const MDBX_txn_flags = enum_MDBX_txn_flags;
pub const MDBX_db_flags = enum_MDBX_db_flags;
pub const MDBX_put_flags = enum_MDBX_put_flags;
pub const MDBX_copy_flags = enum_MDBX_copy_flags;
pub const MDBX_error = enum_MDBX_error;
pub const MDBX_option = enum_MDBX_option;
pub const MDBX_env_delete_mode = enum_MDBX_env_delete_mode;
pub const MDBX_warmup_flags = enum_MDBX_warmup_flags;
pub const MDBX_dbi_state = enum_MDBX_dbi_state;
pub const MDBX_chk_flags = enum_MDBX_chk_flags;
pub const MDBX_chk_severity = enum_MDBX_chk_severity;
pub const MDBX_chk_stage = enum_MDBX_chk_stage;
pub const MDBX_chk_issue = struct_MDBX_chk_issue;
pub const MDBX_chk_scope = struct_MDBX_chk_scope;
pub const MDBX_chk_user_table_cookie = struct_MDBX_chk_user_table_cookie;
pub const MDBX_chk_histogram = struct_MDBX_chk_histogram;
pub const MDBX_chk_table = struct_MDBX_chk_table;
pub const MDBX_chk_context = struct_MDBX_chk_context;
pub const MDBX_chk_line = struct_MDBX_chk_line;
pub const MDBX_chk_callbacks = struct_MDBX_chk_callbacks;
