const __root = @This();
pub const __builtin = @import("std").zig.c_translation.builtins;
pub const __helpers = @import("std").zig.c_translation.helpers;
pub const struct___va_list_tag_1 = extern struct {
    unnamed_0: c_uint = 0,
    unnamed_1: c_uint = 0,
    unnamed_2: ?*anyopaque = null,
    unnamed_3: ?*anyopaque = null,
};
pub const __builtin_va_list = [1]struct___va_list_tag_1;
pub const va_list = __builtin_va_list;
pub const __gnuc_va_list = __builtin_va_list;
pub const ptrdiff_t = c_long;
pub const wchar_t = c_int;
pub const max_align_t = extern struct {
    __aro_max_align_ll: c_longlong = 0,
    __aro_max_align_ld: c_longdouble = 0,
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
    tv_sec: __time_t = 0,
    tv_nsec: __syscall_slong_t = 0,
    pub const nanosleep = __root.nanosleep;
    pub const timespec_get = __root.timespec_get;
    pub const get = __root.timespec_get;
};
pub const pid_t = __pid_t;
pub const struct_sched_param = extern struct {
    sched_priority: c_int = 0,
};
pub const __cpu_mask = c_ulong;
pub const cpu_set_t = extern struct {
    __bits: [16]__cpu_mask = @import("std").mem.zeroes([16]__cpu_mask),
    pub const __sched_cpufree = __root.__sched_cpufree;
    pub const cpufree = __root.__sched_cpufree;
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
    tm_sec: c_int = 0,
    tm_min: c_int = 0,
    tm_hour: c_int = 0,
    tm_mday: c_int = 0,
    tm_mon: c_int = 0,
    tm_year: c_int = 0,
    tm_wday: c_int = 0,
    tm_yday: c_int = 0,
    tm_isdst: c_int = 0,
    tm_gmtoff: c_long = 0,
    tm_zone: [*c]const u8 = null,
    pub const mktime = __root.mktime;
    pub const asctime = __root.asctime;
    pub const asctime_r = __root.asctime_r;
    pub const timegm = __root.timegm;
    pub const timelocal = __root.timelocal;
    pub const r = __root.asctime_r;
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
    __ctype_b: [*c]const c_ushort = null,
    __ctype_tolower: [*c]const c_int = null,
    __ctype_toupper: [*c]const c_int = null,
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
    __low: c_uint = 0,
    __high: c_uint = 0,
};
pub const __atomic_wide_counter = extern union {
    __value64: c_ulonglong,
    __value32: struct_unnamed_3,
};
pub const struct___pthread_internal_list = extern struct {
    __prev: [*c]struct___pthread_internal_list = null,
    __next: [*c]struct___pthread_internal_list = null,
};
pub const __pthread_list_t = struct___pthread_internal_list;
pub const struct___pthread_internal_slist = extern struct {
    __next: [*c]struct___pthread_internal_slist = null,
};
pub const __pthread_slist_t = struct___pthread_internal_slist;
pub const struct___pthread_mutex_s = extern struct {
    __lock: c_int = 0,
    __count: c_uint = 0,
    __owner: c_int = 0,
    __nusers: c_uint = 0,
    __kind: c_int = 0,
    __spins: c_short = 0,
    __elision: c_short = 0,
    __list: __pthread_list_t = @import("std").mem.zeroes(__pthread_list_t),
};
pub const struct___pthread_rwlock_arch_t = extern struct {
    __readers: c_uint = 0,
    __writers: c_uint = 0,
    __wrphase_futex: c_uint = 0,
    __writers_futex: c_uint = 0,
    __pad3: c_uint = 0,
    __pad4: c_uint = 0,
    __cur_writer: c_int = 0,
    __shared: c_int = 0,
    __rwelision: i8 = 0,
    __pad1: [7]u8 = @import("std").mem.zeroes([7]u8),
    __pad2: c_ulong = 0,
    __flags: c_uint = 0,
};
pub const struct___pthread_cond_s = extern struct {
    __wseq: __atomic_wide_counter = @import("std").mem.zeroes(__atomic_wide_counter),
    __g1_start: __atomic_wide_counter = @import("std").mem.zeroes(__atomic_wide_counter),
    __g_refs: [2]c_uint = @import("std").mem.zeroes([2]c_uint),
    __g_size: [2]c_uint = @import("std").mem.zeroes([2]c_uint),
    __g1_orig_size: c_uint = 0,
    __wrefs: c_uint = 0,
    __g_signals: [2]c_uint = @import("std").mem.zeroes([2]c_uint),
};
pub const __tss_t = c_uint;
pub const __thrd_t = c_ulong;
pub const __once_flag = extern struct {
    __data: c_int = 0,
};
pub const pthread_t = c_ulong;
pub const pthread_mutexattr_t = extern union {
    __size: [4]u8,
    __align: c_int,
    pub const pthread_mutexattr_init = __root.pthread_mutexattr_init;
    pub const pthread_mutexattr_destroy = __root.pthread_mutexattr_destroy;
    pub const pthread_mutexattr_getpshared = __root.pthread_mutexattr_getpshared;
    pub const pthread_mutexattr_setpshared = __root.pthread_mutexattr_setpshared;
    pub const pthread_mutexattr_gettype = __root.pthread_mutexattr_gettype;
    pub const pthread_mutexattr_settype = __root.pthread_mutexattr_settype;
    pub const pthread_mutexattr_getprotocol = __root.pthread_mutexattr_getprotocol;
    pub const pthread_mutexattr_setprotocol = __root.pthread_mutexattr_setprotocol;
    pub const pthread_mutexattr_getprioceiling = __root.pthread_mutexattr_getprioceiling;
    pub const pthread_mutexattr_setprioceiling = __root.pthread_mutexattr_setprioceiling;
    pub const pthread_mutexattr_getrobust = __root.pthread_mutexattr_getrobust;
    pub const pthread_mutexattr_setrobust = __root.pthread_mutexattr_setrobust;
    pub const init = __root.pthread_mutexattr_init;
    pub const destroy = __root.pthread_mutexattr_destroy;
    pub const getpshared = __root.pthread_mutexattr_getpshared;
    pub const setpshared = __root.pthread_mutexattr_setpshared;
    pub const gettype = __root.pthread_mutexattr_gettype;
    pub const settype = __root.pthread_mutexattr_settype;
    pub const getprotocol = __root.pthread_mutexattr_getprotocol;
    pub const setprotocol = __root.pthread_mutexattr_setprotocol;
    pub const getprioceiling = __root.pthread_mutexattr_getprioceiling;
    pub const setprioceiling = __root.pthread_mutexattr_setprioceiling;
    pub const getrobust = __root.pthread_mutexattr_getrobust;
    pub const setrobust = __root.pthread_mutexattr_setrobust;
};
pub const pthread_condattr_t = extern union {
    __size: [4]u8,
    __align: c_int,
    pub const pthread_condattr_init = __root.pthread_condattr_init;
    pub const pthread_condattr_destroy = __root.pthread_condattr_destroy;
    pub const pthread_condattr_getpshared = __root.pthread_condattr_getpshared;
    pub const pthread_condattr_setpshared = __root.pthread_condattr_setpshared;
    pub const pthread_condattr_getclock = __root.pthread_condattr_getclock;
    pub const pthread_condattr_setclock = __root.pthread_condattr_setclock;
    pub const init = __root.pthread_condattr_init;
    pub const destroy = __root.pthread_condattr_destroy;
    pub const getpshared = __root.pthread_condattr_getpshared;
    pub const setpshared = __root.pthread_condattr_setpshared;
    pub const getclock = __root.pthread_condattr_getclock;
    pub const setclock = __root.pthread_condattr_setclock;
};
pub const pthread_key_t = c_uint;
pub const pthread_once_t = c_int;
pub const union_pthread_attr_t = extern union {
    __size: [56]u8,
    __align: c_long,
    pub const pthread_attr_init = __root.pthread_attr_init;
    pub const pthread_attr_destroy = __root.pthread_attr_destroy;
    pub const pthread_attr_getdetachstate = __root.pthread_attr_getdetachstate;
    pub const pthread_attr_setdetachstate = __root.pthread_attr_setdetachstate;
    pub const pthread_attr_getguardsize = __root.pthread_attr_getguardsize;
    pub const pthread_attr_setguardsize = __root.pthread_attr_setguardsize;
    pub const pthread_attr_getschedparam = __root.pthread_attr_getschedparam;
    pub const pthread_attr_setschedparam = __root.pthread_attr_setschedparam;
    pub const pthread_attr_getschedpolicy = __root.pthread_attr_getschedpolicy;
    pub const pthread_attr_setschedpolicy = __root.pthread_attr_setschedpolicy;
    pub const pthread_attr_getinheritsched = __root.pthread_attr_getinheritsched;
    pub const pthread_attr_setinheritsched = __root.pthread_attr_setinheritsched;
    pub const pthread_attr_getscope = __root.pthread_attr_getscope;
    pub const pthread_attr_setscope = __root.pthread_attr_setscope;
    pub const pthread_attr_getstackaddr = __root.pthread_attr_getstackaddr;
    pub const pthread_attr_setstackaddr = __root.pthread_attr_setstackaddr;
    pub const pthread_attr_getstacksize = __root.pthread_attr_getstacksize;
    pub const pthread_attr_setstacksize = __root.pthread_attr_setstacksize;
    pub const pthread_attr_getstack = __root.pthread_attr_getstack;
    pub const pthread_attr_setstack = __root.pthread_attr_setstack;
    pub const init = __root.pthread_attr_init;
    pub const destroy = __root.pthread_attr_destroy;
    pub const getdetachstate = __root.pthread_attr_getdetachstate;
    pub const setdetachstate = __root.pthread_attr_setdetachstate;
    pub const getguardsize = __root.pthread_attr_getguardsize;
    pub const setguardsize = __root.pthread_attr_setguardsize;
    pub const getschedparam = __root.pthread_attr_getschedparam;
    pub const setschedparam = __root.pthread_attr_setschedparam;
    pub const getschedpolicy = __root.pthread_attr_getschedpolicy;
    pub const setschedpolicy = __root.pthread_attr_setschedpolicy;
    pub const getinheritsched = __root.pthread_attr_getinheritsched;
    pub const setinheritsched = __root.pthread_attr_setinheritsched;
    pub const getscope = __root.pthread_attr_getscope;
    pub const setscope = __root.pthread_attr_setscope;
    pub const getstackaddr = __root.pthread_attr_getstackaddr;
    pub const setstackaddr = __root.pthread_attr_setstackaddr;
    pub const getstacksize = __root.pthread_attr_getstacksize;
    pub const setstacksize = __root.pthread_attr_setstacksize;
    pub const getstack = __root.pthread_attr_getstack;
    pub const setstack = __root.pthread_attr_setstack;
};
pub const pthread_attr_t = union_pthread_attr_t;
pub const pthread_mutex_t = extern union {
    __data: struct___pthread_mutex_s,
    __size: [40]u8,
    __align: c_long,
    pub const pthread_mutex_init = __root.pthread_mutex_init;
    pub const pthread_mutex_destroy = __root.pthread_mutex_destroy;
    pub const pthread_mutex_trylock = __root.pthread_mutex_trylock;
    pub const pthread_mutex_lock = __root.pthread_mutex_lock;
    pub const pthread_mutex_timedlock = __root.pthread_mutex_timedlock;
    pub const pthread_mutex_unlock = __root.pthread_mutex_unlock;
    pub const pthread_mutex_getprioceiling = __root.pthread_mutex_getprioceiling;
    pub const pthread_mutex_setprioceiling = __root.pthread_mutex_setprioceiling;
    pub const pthread_mutex_consistent = __root.pthread_mutex_consistent;
    pub const init = __root.pthread_mutex_init;
    pub const destroy = __root.pthread_mutex_destroy;
    pub const trylock = __root.pthread_mutex_trylock;
    pub const lock = __root.pthread_mutex_lock;
    pub const timedlock = __root.pthread_mutex_timedlock;
    pub const unlock = __root.pthread_mutex_unlock;
    pub const getprioceiling = __root.pthread_mutex_getprioceiling;
    pub const setprioceiling = __root.pthread_mutex_setprioceiling;
    pub const consistent = __root.pthread_mutex_consistent;
};
pub const pthread_cond_t = extern union {
    __data: struct___pthread_cond_s,
    __size: [48]u8,
    __align: c_longlong,
    pub const pthread_cond_init = __root.pthread_cond_init;
    pub const pthread_cond_destroy = __root.pthread_cond_destroy;
    pub const pthread_cond_signal = __root.pthread_cond_signal;
    pub const pthread_cond_broadcast = __root.pthread_cond_broadcast;
    pub const pthread_cond_wait = __root.pthread_cond_wait;
    pub const pthread_cond_timedwait = __root.pthread_cond_timedwait;
    pub const init = __root.pthread_cond_init;
    pub const destroy = __root.pthread_cond_destroy;
    pub const signal = __root.pthread_cond_signal;
    pub const broadcast = __root.pthread_cond_broadcast;
    pub const wait = __root.pthread_cond_wait;
    pub const timedwait = __root.pthread_cond_timedwait;
};
pub const pthread_rwlock_t = extern union {
    __data: struct___pthread_rwlock_arch_t,
    __size: [56]u8,
    __align: c_long,
    pub const pthread_rwlock_init = __root.pthread_rwlock_init;
    pub const pthread_rwlock_destroy = __root.pthread_rwlock_destroy;
    pub const pthread_rwlock_rdlock = __root.pthread_rwlock_rdlock;
    pub const pthread_rwlock_tryrdlock = __root.pthread_rwlock_tryrdlock;
    pub const pthread_rwlock_timedrdlock = __root.pthread_rwlock_timedrdlock;
    pub const pthread_rwlock_wrlock = __root.pthread_rwlock_wrlock;
    pub const pthread_rwlock_trywrlock = __root.pthread_rwlock_trywrlock;
    pub const pthread_rwlock_timedwrlock = __root.pthread_rwlock_timedwrlock;
    pub const pthread_rwlock_unlock = __root.pthread_rwlock_unlock;
    pub const init = __root.pthread_rwlock_init;
    pub const destroy = __root.pthread_rwlock_destroy;
    pub const rdlock = __root.pthread_rwlock_rdlock;
    pub const tryrdlock = __root.pthread_rwlock_tryrdlock;
    pub const timedrdlock = __root.pthread_rwlock_timedrdlock;
    pub const wrlock = __root.pthread_rwlock_wrlock;
    pub const trywrlock = __root.pthread_rwlock_trywrlock;
    pub const timedwrlock = __root.pthread_rwlock_timedwrlock;
    pub const unlock = __root.pthread_rwlock_unlock;
};
pub const pthread_rwlockattr_t = extern union {
    __size: [8]u8,
    __align: c_long,
    pub const pthread_rwlockattr_init = __root.pthread_rwlockattr_init;
    pub const pthread_rwlockattr_destroy = __root.pthread_rwlockattr_destroy;
    pub const pthread_rwlockattr_getpshared = __root.pthread_rwlockattr_getpshared;
    pub const pthread_rwlockattr_setpshared = __root.pthread_rwlockattr_setpshared;
    pub const pthread_rwlockattr_getkind_np = __root.pthread_rwlockattr_getkind_np;
    pub const pthread_rwlockattr_setkind_np = __root.pthread_rwlockattr_setkind_np;
    pub const init = __root.pthread_rwlockattr_init;
    pub const destroy = __root.pthread_rwlockattr_destroy;
    pub const getpshared = __root.pthread_rwlockattr_getpshared;
    pub const setpshared = __root.pthread_rwlockattr_setpshared;
    pub const np = __root.pthread_rwlockattr_getkind_np;
};
pub const pthread_spinlock_t = c_int;
pub const pthread_barrier_t = extern union {
    __size: [32]u8,
    __align: c_long,
    pub const pthread_barrier_init = __root.pthread_barrier_init;
    pub const pthread_barrier_destroy = __root.pthread_barrier_destroy;
    pub const pthread_barrier_wait = __root.pthread_barrier_wait;
    pub const init = __root.pthread_barrier_init;
    pub const destroy = __root.pthread_barrier_destroy;
    pub const wait = __root.pthread_barrier_wait;
};
pub const pthread_barrierattr_t = extern union {
    __size: [4]u8,
    __align: c_int,
    pub const pthread_barrierattr_init = __root.pthread_barrierattr_init;
    pub const pthread_barrierattr_destroy = __root.pthread_barrierattr_destroy;
    pub const pthread_barrierattr_getpshared = __root.pthread_barrierattr_getpshared;
    pub const pthread_barrierattr_setpshared = __root.pthread_barrierattr_setpshared;
    pub const init = __root.pthread_barrierattr_init;
    pub const destroy = __root.pthread_barrierattr_destroy;
    pub const getpshared = __root.pthread_barrierattr_getpshared;
    pub const setpshared = __root.pthread_barrierattr_setpshared;
};
pub const __jmp_buf = [8]c_long;
pub const __sigset_t = extern struct {
    __val: [16]c_ulong = @import("std").mem.zeroes([16]c_ulong),
};
pub const struct___jmp_buf_tag = extern struct {
    __jmpbuf: __jmp_buf = @import("std").mem.zeroes(__jmp_buf),
    __mask_was_saved: c_int = 0,
    __saved_mask: __sigset_t = @import("std").mem.zeroes(__sigset_t),
    pub const __sigsetjmp = __root.__sigsetjmp;
    pub const sigsetjmp = __root.__sigsetjmp;
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
    __routine: ?*const fn (?*anyopaque) callconv(.c) void = null,
    __arg: ?*anyopaque = null,
    __canceltype: c_int = 0,
    __prev: [*c]struct__pthread_cleanup_buffer = null,
};
pub const PTHREAD_CANCEL_ENABLE: c_int = 0;
pub const PTHREAD_CANCEL_DISABLE: c_int = 1;
const enum_unnamed_12 = c_uint;
pub const PTHREAD_CANCEL_DEFERRED: c_int = 0;
pub const PTHREAD_CANCEL_ASYNCHRONOUS: c_int = 1;
const enum_unnamed_13 = c_uint;
pub extern fn pthread_create(noalias __newthread: [*c]pthread_t, noalias __attr: [*c]const pthread_attr_t, __start_routine: ?*const fn (?*anyopaque) callconv(.c) ?*anyopaque, noalias __arg: ?*anyopaque) c_int;
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
pub extern fn pthread_once(__once_control: [*c]pthread_once_t, __init_routine: ?*const fn () callconv(.c) void) c_int;
pub extern fn pthread_setcancelstate(__state: c_int, __oldstate: [*c]c_int) c_int;
pub extern fn pthread_setcanceltype(__type: c_int, __oldtype: [*c]c_int) c_int;
pub extern fn pthread_cancel(__th: pthread_t) c_int;
pub extern fn pthread_testcancel() void;
pub const struct___cancel_jmp_buf_tag = extern struct {
    __cancel_jmp_buf: __jmp_buf = @import("std").mem.zeroes(__jmp_buf),
    __mask_was_saved: c_int = 0,
};
pub const __pthread_unwind_buf_t = extern struct {
    __cancel_jmp_buf: [1]struct___cancel_jmp_buf_tag = @import("std").mem.zeroes([1]struct___cancel_jmp_buf_tag),
    __pad: [4]?*anyopaque = @import("std").mem.zeroes([4]?*anyopaque),
    pub const __pthread_register_cancel = __root.__pthread_register_cancel;
    pub const __pthread_unregister_cancel = __root.__pthread_unregister_cancel;
    pub const __pthread_unwind_next = __root.__pthread_unwind_next;
    pub const cancel = __root.__pthread_register_cancel;
    pub const next = __root.__pthread_unwind_next;
};
pub const struct___pthread_cleanup_frame = extern struct {
    __cancel_routine: ?*const fn (?*anyopaque) callconv(.c) void = null,
    __cancel_arg: ?*anyopaque = null,
    __do_it: c_int = 0,
    __cancel_type: c_int = 0,
};
pub extern fn __pthread_register_cancel(__buf: [*c]__pthread_unwind_buf_t) void;
pub extern fn __pthread_unregister_cancel(__buf: [*c]__pthread_unwind_buf_t) void; // /usr/include/pthread.h:750:13: warning: TODO weak linkage ignored
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
pub extern fn pthread_key_create(__key: [*c]pthread_key_t, __destr_function: ?*const fn (?*anyopaque) callconv(.c) void) c_int;
pub extern fn pthread_key_delete(__key: pthread_key_t) c_int;
pub extern fn pthread_getspecific(__key: pthread_key_t) ?*anyopaque;
pub extern fn pthread_setspecific(__key: pthread_key_t, __pointer: ?*const anyopaque) c_int;
pub extern fn pthread_getcpuclockid(__thread_id: pthread_t, __clock_id: [*c]__clockid_t) c_int;
pub extern fn pthread_atfork(__prepare: ?*const fn () callconv(.c) void, __parent: ?*const fn () callconv(.c) void, __child: ?*const fn () callconv(.c) void) c_int;
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
pub const register_t = c_int;
pub fn __bswap_16(arg___bsx: __uint16_t) callconv(.c) __uint16_t {
    var __bsx = arg___bsx;
    _ = &__bsx;
    return @byteSwap(@as(__uint16_t, __bsx));
}
pub fn __bswap_32(arg___bsx: __uint32_t) callconv(.c) __uint32_t {
    var __bsx = arg___bsx;
    _ = &__bsx;
    return @bitCast(@as(c_int, @byteSwap(@as(c_int, @bitCast(@as(c_uint, @truncate(__bsx)))))));
}
pub fn __bswap_64(arg___bsx: __uint64_t) callconv(.c) __uint64_t {
    var __bsx = arg___bsx;
    _ = &__bsx;
    return @bitCast(@as(c_long, @byteSwap(@as(c_long, @bitCast(@as(c_ulong, @truncate(__bsx)))))));
}
pub fn __uint16_identity(arg___x: __uint16_t) callconv(.c) __uint16_t {
    var __x = arg___x;
    _ = &__x;
    return __x;
}
pub fn __uint32_identity(arg___x: __uint32_t) callconv(.c) __uint32_t {
    var __x = arg___x;
    _ = &__x;
    return __x;
}
pub fn __uint64_identity(arg___x: __uint64_t) callconv(.c) __uint64_t {
    var __x = arg___x;
    _ = &__x;
    return __x;
}
pub const sigset_t = __sigset_t;
pub const struct_timeval = extern struct {
    tv_sec: __time_t = 0,
    tv_usec: __suseconds_t = 0,
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
    iov_base: ?*anyopaque = null,
    iov_len: usize = 0,
    pub const mdbx_dump_val = __root.mdbx_dump_val;
    pub const mdbx_jsonInteger_from_key = __root.mdbx_jsonInteger_from_key;
    pub const mdbx_double_from_key = __root.mdbx_double_from_key;
    pub const mdbx_float_from_key = __root.mdbx_float_from_key;
    pub const mdbx_int32_from_key = __root.mdbx_int32_from_key;
    pub const mdbx_int64_from_key = __root.mdbx_int64_from_key;
    pub const val = __root.mdbx_dump_val;
    pub const key = __root.mdbx_jsonInteger_from_key;
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
    datetime: [*c]const u8 = null,
    tree: [*c]const u8 = null,
    commit: [*c]const u8 = null,
    describe: [*c]const u8 = null,
};
pub const struct_MDBX_version_info = extern struct {
    major: u16 = 0,
    minor: u16 = 0,
    patch: u16 = 0,
    tweak: u16 = 0,
    semver_prerelease: [*c]const u8 = null,
    git: struct_unnamed_14 = @import("std").mem.zeroes(struct_unnamed_14),
    sourcery: [*c]const u8 = null,
};
pub extern const mdbx_version: struct_MDBX_version_info;
pub const struct_MDBX_build_info = extern struct {
    datetime: [*c]const u8 = null,
    target: [*c]const u8 = null,
    options: [*c]const u8 = null,
    compiler: [*c]const u8 = null,
    flags: [*c]const u8 = null,
    metadata: [*c]const u8 = null,
};
pub extern const mdbx_build: struct_MDBX_build_info;
pub const struct_MDBX_env = opaque {
    pub const mdbx_env_set_option = __root.mdbx_env_set_option;
    pub const mdbx_env_get_option = __root.mdbx_env_get_option;
    pub const mdbx_env_open = __root.mdbx_env_open;
    pub const mdbx_env_copy = __root.mdbx_env_copy;
    pub const mdbx_env_copy2fd = __root.mdbx_env_copy2fd;
    pub const mdbx_env_stat_ex = __root.mdbx_env_stat_ex;
    pub const mdbx_env_stat = __root.mdbx_env_stat;
    pub const mdbx_env_info_ex = __root.mdbx_env_info_ex;
    pub const mdbx_env_info = __root.mdbx_env_info;
    pub const mdbx_env_sync_ex = __root.mdbx_env_sync_ex;
    pub const mdbx_env_sync = __root.mdbx_env_sync;
    pub const mdbx_env_sync_poll = __root.mdbx_env_sync_poll;
    pub const mdbx_env_set_syncbytes = __root.mdbx_env_set_syncbytes;
    pub const mdbx_env_get_syncbytes = __root.mdbx_env_get_syncbytes;
    pub const mdbx_env_set_syncperiod = __root.mdbx_env_set_syncperiod;
    pub const mdbx_env_get_syncperiod = __root.mdbx_env_get_syncperiod;
    pub const mdbx_env_close_ex = __root.mdbx_env_close_ex;
    pub const mdbx_env_close = __root.mdbx_env_close;
    pub const mdbx_env_resurrect_after_fork = __root.mdbx_env_resurrect_after_fork;
    pub const mdbx_env_warmup = __root.mdbx_env_warmup;
    pub const mdbx_env_set_flags = __root.mdbx_env_set_flags;
    pub const mdbx_env_get_flags = __root.mdbx_env_get_flags;
    pub const mdbx_env_get_path = __root.mdbx_env_get_path;
    pub const mdbx_env_get_fd = __root.mdbx_env_get_fd;
    pub const mdbx_env_set_geometry = __root.mdbx_env_set_geometry;
    pub const mdbx_env_set_mapsize = __root.mdbx_env_set_mapsize;
    pub const mdbx_env_set_maxreaders = __root.mdbx_env_set_maxreaders;
    pub const mdbx_env_get_maxreaders = __root.mdbx_env_get_maxreaders;
    pub const mdbx_env_set_maxdbs = __root.mdbx_env_set_maxdbs;
    pub const mdbx_env_get_maxdbs = __root.mdbx_env_get_maxdbs;
    pub const mdbx_env_get_maxkeysize_ex = __root.mdbx_env_get_maxkeysize_ex;
    pub const mdbx_env_get_maxvalsize_ex = __root.mdbx_env_get_maxvalsize_ex;
    pub const mdbx_env_get_maxkeysize = __root.mdbx_env_get_maxkeysize;
    pub const mdbx_env_get_pairsize4page_max = __root.mdbx_env_get_pairsize4page_max;
    pub const mdbx_env_get_valsize4page_max = __root.mdbx_env_get_valsize4page_max;
    pub const mdbx_env_set_userctx = __root.mdbx_env_set_userctx;
    pub const mdbx_env_get_userctx = __root.mdbx_env_get_userctx;
    pub const mdbx_txn_begin_ex = __root.mdbx_txn_begin_ex;
    pub const mdbx_txn_begin = __root.mdbx_txn_begin;
    pub const mdbx_dbi_close = __root.mdbx_dbi_close;
    pub const mdbx_reader_list = __root.mdbx_reader_list;
    pub const mdbx_reader_check = __root.mdbx_reader_check;
    pub const mdbx_thread_register = __root.mdbx_thread_register;
    pub const mdbx_thread_unregister = __root.mdbx_thread_unregister;
    pub const mdbx_env_set_hsr = __root.mdbx_env_set_hsr;
    pub const mdbx_env_get_hsr = __root.mdbx_env_get_hsr;
    pub const mdbx_txn_lock = __root.mdbx_txn_lock;
    pub const mdbx_txn_unlock = __root.mdbx_txn_unlock;
    pub const mdbx_env_open_for_recovery = __root.mdbx_env_open_for_recovery;
    pub const mdbx_env_turn_for_recovery = __root.mdbx_env_turn_for_recovery;
    pub const mdbx_env_chk = __root.mdbx_env_chk;
    pub const mdbx_env_defrag = __root.mdbx_env_defrag;
    pub const option = __root.mdbx_env_set_option;
    pub const open = __root.mdbx_env_open;
    pub const copy = __root.mdbx_env_copy;
    pub const copy2fd = __root.mdbx_env_copy2fd;
    pub const ex = __root.mdbx_env_stat_ex;
    pub const stat = __root.mdbx_env_stat;
    pub const info = __root.mdbx_env_info;
    pub const sync = __root.mdbx_env_sync;
    pub const poll = __root.mdbx_env_sync_poll;
    pub const syncbytes = __root.mdbx_env_set_syncbytes;
    pub const syncperiod = __root.mdbx_env_set_syncperiod;
    pub const close = __root.mdbx_env_close;
    pub const fork = __root.mdbx_env_resurrect_after_fork;
    pub const warmup = __root.mdbx_env_warmup;
    pub const flags = __root.mdbx_env_set_flags;
    pub const path = __root.mdbx_env_get_path;
    pub const fd = __root.mdbx_env_get_fd;
    pub const geometry = __root.mdbx_env_set_geometry;
    pub const mapsize = __root.mdbx_env_set_mapsize;
    pub const maxreaders = __root.mdbx_env_set_maxreaders;
    pub const maxdbs = __root.mdbx_env_set_maxdbs;
    pub const maxkeysize = __root.mdbx_env_get_maxkeysize;
    pub const max = __root.mdbx_env_get_pairsize4page_max;
    pub const userctx = __root.mdbx_env_set_userctx;
    pub const begin = __root.mdbx_txn_begin;
    pub const list = __root.mdbx_reader_list;
    pub const check = __root.mdbx_reader_check;
    pub const register = __root.mdbx_thread_register;
    pub const unregister = __root.mdbx_thread_unregister;
    pub const hsr = __root.mdbx_env_set_hsr;
    pub const lock = __root.mdbx_txn_lock;
    pub const unlock = __root.mdbx_txn_unlock;
    pub const recovery = __root.mdbx_env_open_for_recovery;
    pub const chk = __root.mdbx_env_chk;
    pub const defrag = __root.mdbx_env_defrag;
};
pub const MDBX_env = struct_MDBX_env;
pub const struct_MDBX_txn = opaque {
    pub const mdbx_txn_copy2pathname = __root.mdbx_txn_copy2pathname;
    pub const mdbx_txn_copy2fd = __root.mdbx_txn_copy2fd;
    pub const mdbx_txn_clone = __root.mdbx_txn_clone;
    pub const mdbx_txn_set_userctx = __root.mdbx_txn_set_userctx;
    pub const mdbx_txn_get_userctx = __root.mdbx_txn_get_userctx;
    pub const mdbx_txn_info = __root.mdbx_txn_info;
    pub const mdbx_txn_env = __root.mdbx_txn_env;
    pub const mdbx_txn_flags = __root.mdbx_txn_flags;
    pub const mdbx_txn_id = __root.mdbx_txn_id;
    pub const mdbx_txn_commit_ex = __root.mdbx_txn_commit_ex;
    pub const mdbx_txn_checkpoint = __root.mdbx_txn_checkpoint;
    pub const mdbx_txn_amend = __root.mdbx_txn_amend;
    pub const mdbx_txn_rollback = __root.mdbx_txn_rollback;
    pub const mdbx_txn_commit = __root.mdbx_txn_commit;
    pub const mdbx_txn_abort_ex = __root.mdbx_txn_abort_ex;
    pub const mdbx_txn_abort = __root.mdbx_txn_abort;
    pub const mdbx_txn_break = __root.mdbx_txn_break;
    pub const mdbx_txn_reset = __root.mdbx_txn_reset;
    pub const mdbx_txn_park = __root.mdbx_txn_park;
    pub const mdbx_txn_unpark = __root.mdbx_txn_unpark;
    pub const mdbx_txn_renew = __root.mdbx_txn_renew;
    pub const mdbx_txn_refresh = __root.mdbx_txn_refresh;
    pub const mdbx_canary_put = __root.mdbx_canary_put;
    pub const mdbx_canary_get = __root.mdbx_canary_get;
    pub const mdbx_dbi_open = __root.mdbx_dbi_open;
    pub const mdbx_dbi_open2 = __root.mdbx_dbi_open2;
    pub const mdbx_dbi_open_ex = __root.mdbx_dbi_open_ex;
    pub const mdbx_dbi_open_ex2 = __root.mdbx_dbi_open_ex2;
    pub const mdbx_dbi_rename = __root.mdbx_dbi_rename;
    pub const mdbx_dbi_rename2 = __root.mdbx_dbi_rename2;
    pub const mdbx_enumerate_tables = __root.mdbx_enumerate_tables;
    pub const mdbx_dbi_stat = __root.mdbx_dbi_stat;
    pub const mdbx_dbi_dupsort_depthmask = __root.mdbx_dbi_dupsort_depthmask;
    pub const mdbx_dbi_flags_ex = __root.mdbx_dbi_flags_ex;
    pub const mdbx_dbi_flags = __root.mdbx_dbi_flags;
    pub const mdbx_drop = __root.mdbx_drop;
    pub const mdbx_get = __root.mdbx_get;
    pub const mdbx_get_ex = __root.mdbx_get_ex;
    pub const mdbx_get_equal_or_great = __root.mdbx_get_equal_or_great;
    pub const mdbx_cache_get = __root.mdbx_cache_get;
    pub const mdbx_cache_get_SingleThreaded = __root.mdbx_cache_get_SingleThreaded;
    pub const mdbx_put = __root.mdbx_put;
    pub const mdbx_replace = __root.mdbx_replace;
    pub const mdbx_replace_ex = __root.mdbx_replace_ex;
    pub const mdbx_del = __root.mdbx_del;
    pub const mdbx_cursor_bind = __root.mdbx_cursor_bind;
    pub const mdbx_cursor_open = __root.mdbx_cursor_open;
    pub const mdbx_txn_release_all_cursors_ex = __root.mdbx_txn_release_all_cursors_ex;
    pub const mdbx_txn_release_all_cursors = __root.mdbx_txn_release_all_cursors;
    pub const mdbx_cursor_renew = __root.mdbx_cursor_renew;
    pub const mdbx_estimate_range = __root.mdbx_estimate_range;
    pub const mdbx_is_dirty = __root.mdbx_is_dirty;
    pub const mdbx_dbi_sequence = __root.mdbx_dbi_sequence;
    pub const mdbx_cmp = __root.mdbx_cmp;
    pub const mdbx_dcmp = __root.mdbx_dcmp;
    pub const mdbx_txn_straggler = __root.mdbx_txn_straggler;
    pub const mdbx_gc_info = __root.mdbx_gc_info;
    pub const copy2pathname = __root.mdbx_txn_copy2pathname;
    pub const copy2fd = __root.mdbx_txn_copy2fd;
    pub const clone = __root.mdbx_txn_clone;
    pub const userctx = __root.mdbx_txn_set_userctx;
    pub const info = __root.mdbx_txn_info;
    pub const env = __root.mdbx_txn_env;
    pub const flags = __root.mdbx_txn_flags;
    pub const id = __root.mdbx_txn_id;
    pub const ex = __root.mdbx_txn_commit_ex;
    pub const checkpoint = __root.mdbx_txn_checkpoint;
    pub const amend = __root.mdbx_txn_amend;
    pub const rollback = __root.mdbx_txn_rollback;
    pub const commit = __root.mdbx_txn_commit;
    pub const abort = __root.mdbx_txn_abort;
    pub const @"break" = __root.mdbx_txn_break;
    pub const reset = __root.mdbx_txn_reset;
    pub const park = __root.mdbx_txn_park;
    pub const unpark = __root.mdbx_txn_unpark;
    pub const renew = __root.mdbx_txn_renew;
    pub const refresh = __root.mdbx_txn_refresh;
    pub const put = __root.mdbx_canary_put;
    pub const get = __root.mdbx_canary_get;
    pub const open = __root.mdbx_dbi_open;
    pub const open2 = __root.mdbx_dbi_open2;
    pub const ex2 = __root.mdbx_dbi_open_ex2;
    pub const rename = __root.mdbx_dbi_rename;
    pub const rename2 = __root.mdbx_dbi_rename2;
    pub const tables = __root.mdbx_enumerate_tables;
    pub const stat = __root.mdbx_dbi_stat;
    pub const depthmask = __root.mdbx_dbi_dupsort_depthmask;
    pub const drop = __root.mdbx_drop;
    pub const great = __root.mdbx_get_equal_or_great;
    pub const SingleThreaded = __root.mdbx_cache_get_SingleThreaded;
    pub const replace = __root.mdbx_replace;
    pub const del = __root.mdbx_del;
    pub const bind = __root.mdbx_cursor_bind;
    pub const cursors = __root.mdbx_txn_release_all_cursors;
    pub const range = __root.mdbx_estimate_range;
    pub const dirty = __root.mdbx_is_dirty;
    pub const sequence = __root.mdbx_dbi_sequence;
    pub const cmp = __root.mdbx_cmp;
    pub const dcmp = __root.mdbx_dcmp;
    pub const straggler = __root.mdbx_txn_straggler;
};
pub const MDBX_txn = struct_MDBX_txn;
pub const MDBX_dbi = u32;
pub const struct_MDBX_cursor = opaque {
    pub const mdbx_cursor_set_userctx = __root.mdbx_cursor_set_userctx;
    pub const mdbx_cursor_get_userctx = __root.mdbx_cursor_get_userctx;
    pub const mdbx_cursor_unbind = __root.mdbx_cursor_unbind;
    pub const mdbx_cursor_reset = __root.mdbx_cursor_reset;
    pub const mdbx_cursor_close = __root.mdbx_cursor_close;
    pub const mdbx_cursor_close2 = __root.mdbx_cursor_close2;
    pub const mdbx_cursor_txn = __root.mdbx_cursor_txn;
    pub const mdbx_cursor_dbi = __root.mdbx_cursor_dbi;
    pub const mdbx_cursor_copy = __root.mdbx_cursor_copy;
    pub const mdbx_cursor_compare = __root.mdbx_cursor_compare;
    pub const mdbx_cursor_get = __root.mdbx_cursor_get;
    pub const mdbx_cursor_ignord = __root.mdbx_cursor_ignord;
    pub const mdbx_cursor_scan = __root.mdbx_cursor_scan;
    pub const mdbx_cursor_scan_from = __root.mdbx_cursor_scan_from;
    pub const mdbx_cursor_get_batch = __root.mdbx_cursor_get_batch;
    pub const mdbx_cursor_put = __root.mdbx_cursor_put;
    pub const mdbx_cursor_del = __root.mdbx_cursor_del;
    pub const mdbx_cursor_delete_range = __root.mdbx_cursor_delete_range;
    pub const mdbx_cursor_bunch_delete = __root.mdbx_cursor_bunch_delete;
    pub const mdbx_cursor_count = __root.mdbx_cursor_count;
    pub const mdbx_cursor_count_ex = __root.mdbx_cursor_count_ex;
    pub const mdbx_cursor_eof = __root.mdbx_cursor_eof;
    pub const mdbx_cursor_on_first = __root.mdbx_cursor_on_first;
    pub const mdbx_cursor_on_first_dup = __root.mdbx_cursor_on_first_dup;
    pub const mdbx_cursor_on_last = __root.mdbx_cursor_on_last;
    pub const mdbx_cursor_on_last_dup = __root.mdbx_cursor_on_last_dup;
    pub const mdbx_estimate_distance = __root.mdbx_estimate_distance;
    pub const mdbx_estimate_move = __root.mdbx_estimate_move;
    pub const userctx = __root.mdbx_cursor_set_userctx;
    pub const unbind = __root.mdbx_cursor_unbind;
    pub const reset = __root.mdbx_cursor_reset;
    pub const close = __root.mdbx_cursor_close;
    pub const close2 = __root.mdbx_cursor_close2;
    pub const txn = __root.mdbx_cursor_txn;
    pub const dbi = __root.mdbx_cursor_dbi;
    pub const copy = __root.mdbx_cursor_copy;
    pub const compare = __root.mdbx_cursor_compare;
    pub const get = __root.mdbx_cursor_get;
    pub const ignord = __root.mdbx_cursor_ignord;
    pub const scan = __root.mdbx_cursor_scan;
    pub const from = __root.mdbx_cursor_scan_from;
    pub const batch = __root.mdbx_cursor_get_batch;
    pub const put = __root.mdbx_cursor_put;
    pub const del = __root.mdbx_cursor_del;
    pub const range = __root.mdbx_cursor_delete_range;
    pub const delete = __root.mdbx_cursor_bunch_delete;
    pub const count = __root.mdbx_cursor_count;
    pub const ex = __root.mdbx_cursor_count_ex;
    pub const eof = __root.mdbx_cursor_eof;
    pub const first = __root.mdbx_cursor_on_first;
    pub const dup = __root.mdbx_cursor_on_first_dup;
    pub const last = __root.mdbx_cursor_on_last;
    pub const distance = __root.mdbx_estimate_distance;
    pub const move = __root.mdbx_estimate_move;
};
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
pub const MDBX_debug_func = ?*const fn (loglevel: MDBX_log_level_t, function: [*c]const u8, line: c_int, fmt: [*c]const u8, args: [*c]struct___va_list_tag_1) callconv(.c) void;
pub extern fn mdbx_setup_debug(log_level: MDBX_log_level_t, debug_flags: MDBX_debug_flags_t, logger: MDBX_debug_func) c_int;
pub const MDBX_debug_func_nofmt = ?*const fn (loglevel: MDBX_log_level_t, function: [*c]const u8, line: c_int, msg: [*c]const u8, length: c_uint) callconv(.c) void;
pub extern fn mdbx_setup_debug_nofmt(log_level: MDBX_log_level_t, debug_flags: MDBX_debug_flags_t, logger: MDBX_debug_func_nofmt, logger_buffer: [*c]u8, logger_buffer_size: usize) c_int;
pub const MDBX_panic_func = ?*const fn (msg: [*c]const u8, function: [*c]const u8, line: c_uint, obj: ?*const anyopaque, obj_class: [*c]const u8) callconv(.c) void;
pub extern fn mdbx_assert_fail(msg: [*c]const u8, func: [*c]const u8, line: c_uint) noreturn;
pub extern fn mdbx_set_panic(func: MDBX_panic_func) void;
pub extern fn mdbx_dump_val(key: [*c]const MDBX_val, buf: [*c]u8, bufsize: usize) [*c]const u8;
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
pub const MDBX_TXN_NOWEAKING: c_int = 0;
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
pub const MDBX_CP_OVERWRITE: c_int = 64;
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
pub const MDBX_SEEK_AND_GET_MULTIPLE: c_int = 36;
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
pub const MDBX_LAGGARD_READER: c_int = -30409;
pub const MDBX_LAST_ADDED_ERRCODE: c_int = -30409;
pub const MDBX_ENODATA: c_int = 61;
pub const MDBX_EINVAL: c_int = 22;
pub const MDBX_EACCESS: c_int = 13;
pub const MDBX_ENOMEM: c_int = 12;
pub const MDBX_EROFS: c_int = 30;
pub const MDBX_ENOSYS: c_int = 95;
pub const MDBX_EIO: c_int = 5;
pub const MDBX_EPERM: c_int = 1;
pub const MDBX_EINTR: c_int = 4;
pub const MDBX_ENOFILE: c_int = 2;
pub const MDBX_EREMOTE: c_int = 121;
pub const MDBX_EDEADLK: c_int = 35;
pub const enum_MDBX_error = c_int;
pub const MDBX_error_t = enum_MDBX_error;
pub fn MDBX_MAP_RESIZED_is_deprecated() callconv(.c) c_int {
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
pub const MDBX_opt_merge_threshold: c_int = 12;
pub const MDBX_opt_writethrough_threshold: c_int = 13;
pub const MDBX_opt_prefault_write_enable: c_int = 14;
pub const MDBX_opt_gc_time_limit: c_int = 15;
pub const MDBX_opt_prefer_waf_insteadof_balance: c_int = 16;
pub const MDBX_opt_subpage_limit: c_int = 17;
pub const MDBX_opt_subpage_room_threshold: c_int = 18;
pub const MDBX_opt_subpage_reserve_prereq: c_int = 19;
pub const MDBX_opt_subpage_reserve_limit: c_int = 20;
pub const MDBX_opt_split_reserve: c_int = 21;
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
    ms_psize: u32 = 0,
    ms_depth: u32 = 0,
    ms_branch_pages: u64 = 0,
    ms_leaf_pages: u64 = 0,
    ms_overflow_pages: u64 = 0,
    ms_entries: u64 = 0,
    ms_mod_txnid: u64 = 0,
};
pub const MDBX_stat = struct_MDBX_stat;
pub extern fn mdbx_env_stat_ex(env: ?*const MDBX_env, txn: ?*const MDBX_txn, stat: [*c]MDBX_stat, bytes: usize) c_int;
pub fn mdbx_env_stat(arg_env: ?*const MDBX_env, arg_stat: [*c]MDBX_stat, arg_bytes: usize) callconv(.c) c_int {
    var env = arg_env;
    _ = &env;
    var stat = arg_stat;
    _ = &stat;
    var bytes = arg_bytes;
    _ = &bytes;
    return mdbx_env_stat_ex(env, null, stat, bytes);
}
const struct_unnamed_15 = extern struct {
    lower: u64 = 0,
    upper: u64 = 0,
    current: u64 = 0,
    shrink: u64 = 0,
    grow: u64 = 0,
};
const struct_unnamed_17 = extern struct {
    x: u64 = 0,
    y: u64 = 0,
};
const struct_unnamed_16 = extern struct {
    current: struct_unnamed_17 = @import("std").mem.zeroes(struct_unnamed_17),
    meta: [3]struct_unnamed_17 = @import("std").mem.zeroes([3]struct_unnamed_17),
};
const struct_unnamed_18 = extern struct {
    newly: u64 = 0,
    cow: u64 = 0,
    clone: u64 = 0,
    split: u64 = 0,
    merge: u64 = 0,
    spill: u64 = 0,
    unspill: u64 = 0,
    wops: u64 = 0,
    prefault: u64 = 0,
    mincore: u64 = 0,
    msync: u64 = 0,
    fsync: u64 = 0,
};
const struct_unnamed_19 = extern struct {
    x: u64 = 0,
    y: u64 = 0,
};
pub const struct_MDBX_envinfo = extern struct {
    mi_geo: struct_unnamed_15 = @import("std").mem.zeroes(struct_unnamed_15),
    mi_mapsize: u64 = 0,
    mi_dxb_fsize: u64 = 0,
    mi_dxb_fallocated: u64 = 0,
    mi_last_pgno: u64 = 0,
    mi_recent_txnid: u64 = 0,
    mi_latter_reader_txnid: u64 = 0,
    mi_self_latter_reader_txnid: u64 = 0,
    mi_meta_txnid: [3]u64 = @import("std").mem.zeroes([3]u64),
    mi_meta_sign: [3]u64 = @import("std").mem.zeroes([3]u64),
    mi_maxreaders: u32 = 0,
    mi_numreaders: u32 = 0,
    mi_dxb_pagesize: u32 = 0,
    mi_sys_pagesize: u32 = 0,
    mi_sys_upcblk: u32 = 0,
    mi_sys_ioblk: u32 = 0,
    mi_bootid: struct_unnamed_16 = @import("std").mem.zeroes(struct_unnamed_16),
    mi_unsync_volume: u64 = 0,
    mi_autosync_threshold: u64 = 0,
    mi_since_sync_seconds16dot16: u32 = 0,
    mi_autosync_period_seconds16dot16: u32 = 0,
    mi_since_reader_check_seconds16dot16: u32 = 0,
    mi_mode: u32 = 0,
    mi_pgop_stat: struct_unnamed_18 = @import("std").mem.zeroes(struct_unnamed_18),
    mi_dxbid: struct_unnamed_19 = @import("std").mem.zeroes(struct_unnamed_19),
};
pub const MDBX_envinfo = struct_MDBX_envinfo;
pub extern fn mdbx_env_info_ex(env: ?*const MDBX_env, txn: ?*const MDBX_txn, info: [*c]MDBX_envinfo, bytes: usize) c_int;
pub fn mdbx_env_info(arg_env: ?*const MDBX_env, arg_info: [*c]MDBX_envinfo, arg_bytes: usize) callconv(.c) c_int {
    var env = arg_env;
    _ = &env;
    var info = arg_info;
    _ = &info;
    var bytes = arg_bytes;
    _ = &bytes;
    return mdbx_env_info_ex(env, null, info, bytes);
}
pub extern fn mdbx_env_sync_ex(env: ?*MDBX_env, force: bool, nonblock: bool) c_int;
pub fn mdbx_env_sync(arg_env: ?*MDBX_env) callconv(.c) c_int {
    var env = arg_env;
    _ = &env;
    return mdbx_env_sync_ex(env, @as(c_int, 1) != 0, @as(c_int, 0) != 0);
}
pub fn mdbx_env_sync_poll(arg_env: ?*MDBX_env) callconv(.c) c_int {
    var env = arg_env;
    _ = &env;
    return mdbx_env_sync_ex(env, @as(c_int, 0) != 0, @as(c_int, 1) != 0);
}
pub fn mdbx_env_set_syncbytes(arg_env: ?*MDBX_env, arg_threshold: usize) callconv(.c) c_int {
    var env = arg_env;
    _ = &env;
    var threshold = arg_threshold;
    _ = &threshold;
    return mdbx_env_set_option(env, MDBX_opt_sync_bytes, threshold);
}
pub fn mdbx_env_get_syncbytes(arg_env: ?*const MDBX_env, arg_threshold: [*c]usize) callconv(.c) c_int {
    var env = arg_env;
    _ = &env;
    var threshold = arg_threshold;
    _ = &threshold;
    var rc: c_int = MDBX_EINVAL;
    _ = &rc;
    if (threshold != null) {
        var proxy: u64 = 0;
        _ = &proxy;
        rc = mdbx_env_get_option(env, MDBX_opt_sync_bytes, &proxy);
        while (true) {
            if (!false) break;
        }
        threshold.* = proxy;
    }
    return rc;
}
pub fn mdbx_env_set_syncperiod(arg_env: ?*MDBX_env, arg_seconds_16dot16: c_uint) callconv(.c) c_int {
    var env = arg_env;
    _ = &env;
    var seconds_16dot16 = arg_seconds_16dot16;
    _ = &seconds_16dot16;
    return mdbx_env_set_option(env, MDBX_opt_sync_period, seconds_16dot16);
}
pub fn mdbx_env_get_syncperiod(arg_env: ?*const MDBX_env, arg_period_seconds_16dot16: [*c]c_uint) callconv(.c) c_int {
    var env = arg_env;
    _ = &env;
    var period_seconds_16dot16 = arg_period_seconds_16dot16;
    _ = &period_seconds_16dot16;
    var rc: c_int = MDBX_EINVAL;
    _ = &rc;
    if (period_seconds_16dot16 != null) {
        var proxy: u64 = 0;
        _ = &proxy;
        rc = mdbx_env_get_option(env, MDBX_opt_sync_period, &proxy);
        while (true) {
            if (!false) break;
        }
        period_seconds_16dot16.* = @truncate(proxy);
    }
    return rc;
}
pub extern fn mdbx_env_close_ex(env: ?*MDBX_env, dont_sync: bool) c_int;
pub fn mdbx_env_close(arg_env: ?*MDBX_env) callconv(.c) c_int {
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
pub fn mdbx_env_set_mapsize(arg_env: ?*MDBX_env, arg_size: usize) callconv(.c) c_int {
    var env = arg_env;
    _ = &env;
    var size = arg_size;
    _ = &size;
    return mdbx_env_set_geometry(env, @bitCast(@as(c_ulong, @truncate(size))), @bitCast(@as(c_ulong, @truncate(size))), @bitCast(@as(c_ulong, @truncate(size))), -@as(c_int, 1), -@as(c_int, 1), -@as(c_int, 1));
}
pub extern fn mdbx_is_readahead_reasonable(volume: usize, redundancy: isize) c_int;
pub fn mdbx_limits_pgsize_min() callconv(.c) isize {
    return MDBX_MIN_PAGESIZE;
}
pub fn mdbx_limits_pgsize_max() callconv(.c) isize {
    return MDBX_MAX_PAGESIZE;
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
pub fn mdbx_env_set_maxreaders(arg_env: ?*MDBX_env, arg_readers: c_uint) callconv(.c) c_int {
    var env = arg_env;
    _ = &env;
    var readers = arg_readers;
    _ = &readers;
    return mdbx_env_set_option(env, MDBX_opt_max_readers, readers);
}
pub fn mdbx_env_get_maxreaders(arg_env: ?*const MDBX_env, arg_readers: [*c]c_uint) callconv(.c) c_int {
    var env = arg_env;
    _ = &env;
    var readers = arg_readers;
    _ = &readers;
    var rc: c_int = MDBX_EINVAL;
    _ = &rc;
    if (readers != null) {
        var proxy: u64 = 0;
        _ = &proxy;
        rc = mdbx_env_get_option(env, MDBX_opt_max_readers, &proxy);
        readers.* = @truncate(proxy);
    }
    return rc;
}
pub fn mdbx_env_set_maxdbs(arg_env: ?*MDBX_env, arg_dbs: MDBX_dbi) callconv(.c) c_int {
    var env = arg_env;
    _ = &env;
    var dbs = arg_dbs;
    _ = &dbs;
    return mdbx_env_set_option(env, MDBX_opt_max_db, dbs);
}
pub fn mdbx_env_get_maxdbs(arg_env: ?*const MDBX_env, arg_dbs: [*c]MDBX_dbi) callconv(.c) c_int {
    var env = arg_env;
    _ = &env;
    var dbs = arg_dbs;
    _ = &dbs;
    var rc: c_int = MDBX_EINVAL;
    _ = &rc;
    if (dbs != null) {
        var proxy: u64 = 0;
        _ = &proxy;
        rc = mdbx_env_get_option(env, MDBX_opt_max_db, &proxy);
        dbs.* = @truncate(proxy);
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
pub fn mdbx_txn_begin(arg_env: ?*MDBX_env, arg_parent: ?*MDBX_txn, arg_flags: MDBX_txn_flags_t, arg_txn: [*c]?*MDBX_txn) callconv(.c) c_int {
    var env = arg_env;
    _ = &env;
    var parent = arg_parent;
    _ = &parent;
    var flags = arg_flags;
    _ = &flags;
    var txn = arg_txn;
    _ = &txn;
    return mdbx_txn_begin_ex(env, parent, flags, txn, null);
}
pub extern fn mdbx_txn_clone(origin: ?*const MDBX_txn, in_out_clone: [*c]?*MDBX_txn, context: ?*anyopaque) c_int;
pub extern fn mdbx_txn_set_userctx(txn: ?*MDBX_txn, ctx: ?*anyopaque) c_int;
pub extern fn mdbx_txn_get_userctx(txn: ?*const MDBX_txn) ?*anyopaque;
pub const struct_MDBX_txn_info = extern struct {
    txn_id: u64 = 0,
    txn_reader_lag: u64 = 0,
    txn_space_used: u64 = 0,
    txn_space_limit_soft: u64 = 0,
    txn_space_limit_hard: u64 = 0,
    txn_space_retired: u64 = 0,
    txn_space_leftover: u64 = 0,
    txn_space_dirty: u64 = 0,
    txn_pget: u64 = 0,
};
pub const MDBX_txn_info = struct_MDBX_txn_info;
pub extern fn mdbx_txn_info(txn: ?*const MDBX_txn, info: [*c]MDBX_txn_info, scan_rlt: bool) c_int;
pub extern fn mdbx_txn_env(txn: ?*const MDBX_txn) ?*MDBX_env;
pub extern fn mdbx_txn_flags(txn: ?*const MDBX_txn) MDBX_txn_flags_t;
pub extern fn mdbx_txn_id(txn: ?*const MDBX_txn) u64;
const struct_unnamed_21 = extern struct {
    time: u32 = 0,
    volume: u64 = 0,
    calls: u32 = 0,
};
const struct_unnamed_20 = extern struct {
    wloops: u32 = 0,
    coalescences: u32 = 0,
    wipes: u32 = 0,
    flushes: u32 = 0,
    kicks: u32 = 0,
    work_counter: u32 = 0,
    work_rtime_monotonic: u32 = 0,
    work_xtime_cpu: u32 = 0,
    work_rsteps: u32 = 0,
    work_xpages: u32 = 0,
    work_majflt: u32 = 0,
    self_counter: u32 = 0,
    self_rtime_monotonic: u32 = 0,
    self_xtime_cpu: u32 = 0,
    self_rsteps: u32 = 0,
    self_xpages: u32 = 0,
    self_majflt: u32 = 0,
    pnl_merge_work: struct_unnamed_21 = @import("std").mem.zeroes(struct_unnamed_21),
    pnl_merge_self: struct_unnamed_21 = @import("std").mem.zeroes(struct_unnamed_21),
    max_reader_lag: u32 = 0,
    max_retained_pages: u32 = 0,
};
pub const struct_MDBX_commit_latency = extern struct {
    preparation: u32 = 0,
    gc_wallclock: u32 = 0,
    audit: u32 = 0,
    write: u32 = 0,
    sync: u32 = 0,
    ending: u32 = 0,
    whole: u32 = 0,
    gc_cputime: u32 = 0,
    gc_prof: struct_unnamed_20 = @import("std").mem.zeroes(struct_unnamed_20),
};
pub const MDBX_commit_latency = struct_MDBX_commit_latency;
pub extern fn mdbx_txn_commit_ex(txn: ?*MDBX_txn, latency: [*c]MDBX_commit_latency) c_int;
pub extern fn mdbx_txn_checkpoint(txn: ?*MDBX_txn, weakening_durability: MDBX_txn_flags_t, latency: [*c]MDBX_commit_latency) c_int;
pub extern fn mdbx_txn_commit_embark_read(ptxn: [*c]?*MDBX_txn, latency: [*c]MDBX_commit_latency) c_int;
pub extern fn mdbx_txn_amend(read_txn: ?*MDBX_txn, ptr_write_txn: [*c]?*MDBX_txn, flags: MDBX_txn_flags_t, context: ?*anyopaque) c_int;
pub extern fn mdbx_txn_rollback(txn: ?*MDBX_txn) c_int;
pub fn mdbx_txn_commit(arg_txn: ?*MDBX_txn) callconv(.c) c_int {
    var txn = arg_txn;
    _ = &txn;
    return mdbx_txn_commit_ex(txn, null);
}
pub extern fn mdbx_txn_abort_ex(txn: ?*MDBX_txn, latency: [*c]MDBX_commit_latency) c_int;
pub fn mdbx_txn_abort(arg_txn: ?*MDBX_txn) callconv(.c) c_int {
    var txn = arg_txn;
    _ = &txn;
    return mdbx_txn_abort_ex(txn, null);
}
pub extern fn mdbx_txn_break(txn: ?*MDBX_txn) c_int;
pub extern fn mdbx_txn_reset(txn: ?*MDBX_txn) c_int;
pub extern fn mdbx_txn_park(txn: ?*MDBX_txn, autounpark: bool) c_int;
pub extern fn mdbx_txn_unpark(txn: ?*MDBX_txn, restart_if_ousted: bool) c_int;
pub extern fn mdbx_txn_renew(txn: ?*MDBX_txn) c_int;
pub extern fn mdbx_txn_refresh(txn: ?*MDBX_txn) c_int;
pub const struct_MDBX_canary = extern struct {
    x: u64 = 0,
    y: u64 = 0,
    z: u64 = 0,
    v: u64 = 0,
};
pub const MDBX_canary = struct_MDBX_canary;
pub extern fn mdbx_canary_put(txn: ?*MDBX_txn, canary: [*c]const MDBX_canary) c_int;
pub extern fn mdbx_canary_get(txn: ?*const MDBX_txn, canary: [*c]MDBX_canary) c_int;
pub const MDBX_cmp_func = ?*const fn (a: [*c]const MDBX_val, b: [*c]const MDBX_val) callconv(.c) c_int;
pub extern fn mdbx_dbi_open(txn: ?*MDBX_txn, name: [*c]const u8, flags: MDBX_db_flags_t, dbi: [*c]MDBX_dbi) c_int;
pub extern fn mdbx_dbi_open2(txn: ?*MDBX_txn, name: [*c]const MDBX_val, flags: MDBX_db_flags_t, dbi: [*c]MDBX_dbi) c_int;
pub extern fn mdbx_dbi_open_ex(txn: ?*MDBX_txn, name: [*c]const u8, flags: MDBX_db_flags_t, dbi: [*c]MDBX_dbi, keycmp: MDBX_cmp_func, datacmp: MDBX_cmp_func) c_int;
pub extern fn mdbx_dbi_open_ex2(txn: ?*MDBX_txn, name: [*c]const MDBX_val, flags: MDBX_db_flags_t, dbi: [*c]MDBX_dbi, keycmp: MDBX_cmp_func, datacmp: MDBX_cmp_func) c_int;
pub extern fn mdbx_dbi_rename(txn: ?*MDBX_txn, dbi: MDBX_dbi, name: [*c]const u8) c_int;
pub extern fn mdbx_dbi_rename2(txn: ?*MDBX_txn, dbi: MDBX_dbi, name: [*c]const MDBX_val) c_int;
pub const MDBX_table_enum_func = ?*const fn (ctx: ?*anyopaque, txn: ?*const MDBX_txn, name: [*c]const MDBX_val, flags: MDBX_db_flags_t, stat: [*c]const struct_MDBX_stat, dbi: MDBX_dbi) callconv(.c) c_int;
pub extern fn mdbx_enumerate_tables(txn: ?*const MDBX_txn, func: MDBX_table_enum_func, ctx: ?*anyopaque) c_int;
pub extern fn mdbx_key_from_jsonInteger(json_integer: i64) u64;
pub extern fn mdbx_key_from_double(ieee754_64bit: f64) u64;
pub extern fn mdbx_key_from_ptrdouble(ieee754_64bit: [*c]const f64) u64;
pub extern fn mdbx_key_from_float(ieee754_32bit: f32) u32;
pub extern fn mdbx_key_from_ptrfloat(ieee754_32bit: [*c]const f32) u32;
pub fn mdbx_key_from_int64(@"i64": i64) callconv(.c) u64 {
    _ = &@"i64";
    return @as(c_ulong, 9223372036854775808) +% @as(c_ulong, @bitCast(@as(c_long, @"i64")));
}
pub fn mdbx_key_from_int32(@"i32": i32) callconv(.c) u32 {
    _ = &@"i32";
    return @as(c_uint, 2147483648) +% @as(c_uint, @bitCast(@as(c_int, @"i32")));
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
pub fn mdbx_dbi_flags(arg_txn: ?*const MDBX_txn, arg_dbi: MDBX_dbi, arg_flags: [*c]c_uint) callconv(.c) c_int {
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
pub const struct_MDBX_cache_entry = extern struct {
    trunk_txnid: u64 = 0,
    last_confirmed_txnid: u64 = 0,
    offset: usize = 0,
    length: u32 = 0,
    pub const mdbx_cache_init = __root.mdbx_cache_init;
    pub const init = __root.mdbx_cache_init;
};
pub const MDBX_cache_entry_t = struct_MDBX_cache_entry;
pub fn mdbx_cache_init(arg_entry: [*c]MDBX_cache_entry_t) callconv(.c) void {
    var entry = arg_entry;
    _ = &entry;
    entry.*.offset = 0;
    entry.*.length = 0;
    entry.*.trunk_txnid = 0;
    entry.*.last_confirmed_txnid = 0;
}
pub const MDBX_CACHE_ERROR: c_int = -3;
pub const MDBX_CACHE_BEHIND: c_int = -2;
pub const MDBX_CACHE_UNABLE: c_int = -1;
pub const MDBX_CACHE_RACE: c_int = 0;
pub const MDBX_CACHE_DIRTY: c_int = 1;
pub const MDBX_CACHE_HIT: c_int = 2;
pub const MDBX_CACHE_CONFIRMED: c_int = 3;
pub const MDBX_CACHE_REFRESHED: c_int = 4;
pub const enum_MDBX_cache_status = c_int;
pub const MDBX_cache_status_t = enum_MDBX_cache_status;
pub const struct_MDBX_cache_result = extern struct {
    errcode: MDBX_error_t = @import("std").mem.zeroes(MDBX_error_t),
    status: MDBX_cache_status_t = @import("std").mem.zeroes(MDBX_cache_status_t),
};
pub const MDBX_cache_result_t = struct_MDBX_cache_result;
pub extern fn mdbx_cache_get(txn: ?*const MDBX_txn, dbi: MDBX_dbi, key: [*c]const MDBX_val, data: [*c]MDBX_val, entry: [*c]volatile MDBX_cache_entry_t) MDBX_cache_result_t;
pub extern fn mdbx_cache_get_SingleThreaded(txn: ?*const MDBX_txn, dbi: MDBX_dbi, key: [*c]const MDBX_val, data: [*c]MDBX_val, entry: [*c]MDBX_cache_entry_t) MDBX_cache_result_t;
pub extern fn mdbx_put(txn: ?*MDBX_txn, dbi: MDBX_dbi, key: [*c]const MDBX_val, data: [*c]MDBX_val, flags: MDBX_put_flags_t) c_int;
pub extern fn mdbx_replace(txn: ?*MDBX_txn, dbi: MDBX_dbi, key: [*c]const MDBX_val, new_data: [*c]MDBX_val, old_data: [*c]MDBX_val, flags: MDBX_put_flags_t) c_int;
pub const MDBX_preserve_func = ?*const fn (context: ?*anyopaque, target: [*c]MDBX_val, src: ?*const anyopaque, bytes: usize) callconv(.c) c_int;
pub extern fn mdbx_replace_ex(txn: ?*MDBX_txn, dbi: MDBX_dbi, key: [*c]const MDBX_val, new_data: [*c]MDBX_val, old_data: [*c]MDBX_val, flags: MDBX_put_flags_t, preserver: MDBX_preserve_func, preserver_context: ?*anyopaque) c_int;
pub extern fn mdbx_del(txn: ?*MDBX_txn, dbi: MDBX_dbi, key: [*c]const MDBX_val, data: [*c]const MDBX_val) c_int;
pub extern fn mdbx_cursor_create(context: ?*anyopaque) ?*MDBX_cursor;
pub extern fn mdbx_cursor_set_userctx(cursor: ?*MDBX_cursor, ctx: ?*anyopaque) c_int;
pub extern fn mdbx_cursor_get_userctx(cursor: ?*const MDBX_cursor) ?*anyopaque;
pub extern fn mdbx_cursor_bind(txn: ?*MDBX_txn, cursor: ?*MDBX_cursor, dbi: MDBX_dbi) c_int;
pub extern fn mdbx_cursor_unbind(cursor: ?*MDBX_cursor) c_int;
pub extern fn mdbx_cursor_reset(cursor: ?*MDBX_cursor) c_int;
pub extern fn mdbx_cursor_open(txn: ?*MDBX_txn, dbi: MDBX_dbi, cursor: [*c]?*MDBX_cursor) c_int;
pub extern fn mdbx_cursor_close(cursor: ?*MDBX_cursor) void;
pub extern fn mdbx_cursor_close2(cursor: ?*MDBX_cursor) c_int;
pub extern fn mdbx_txn_release_all_cursors_ex(txn: ?*const MDBX_txn, unbind: bool, count: [*c]usize) c_int;
pub fn mdbx_txn_release_all_cursors(arg_txn: ?*const MDBX_txn, arg_unbind: bool) callconv(.c) c_int {
    var txn = arg_txn;
    _ = &txn;
    var unbind = arg_unbind;
    _ = &unbind;
    return mdbx_txn_release_all_cursors_ex(txn, unbind, null);
}
pub extern fn mdbx_cursor_renew(txn: ?*MDBX_txn, cursor: ?*MDBX_cursor) c_int;
pub extern fn mdbx_cursor_txn(cursor: ?*const MDBX_cursor) ?*MDBX_txn;
pub extern fn mdbx_cursor_dbi(cursor: ?*const MDBX_cursor) MDBX_dbi;
pub extern fn mdbx_cursor_copy(src: ?*const MDBX_cursor, dest: ?*MDBX_cursor) c_int;
pub extern fn mdbx_cursor_compare(left: ?*const MDBX_cursor, right: ?*const MDBX_cursor, ignore_multival: bool) c_int;
pub extern fn mdbx_cursor_get(cursor: ?*MDBX_cursor, key: [*c]MDBX_val, data: [*c]MDBX_val, op: MDBX_cursor_op) c_int;
pub extern fn mdbx_cursor_ignord(cursor: ?*MDBX_cursor) c_int;
pub const MDBX_predicate_func = ?*const fn (context: ?*anyopaque, key: [*c]MDBX_val, value: [*c]MDBX_val, arg: ?*anyopaque) callconv(.c) c_int;
pub extern fn mdbx_cursor_scan(cursor: ?*MDBX_cursor, predicate: MDBX_predicate_func, context: ?*anyopaque, start_op: MDBX_cursor_op, turn_op: MDBX_cursor_op, arg: ?*anyopaque) c_int;
pub extern fn mdbx_cursor_scan_from(cursor: ?*MDBX_cursor, predicate: MDBX_predicate_func, context: ?*anyopaque, from_op: MDBX_cursor_op, from_key: [*c]MDBX_val, from_value: [*c]MDBX_val, turn_op: MDBX_cursor_op, arg: ?*anyopaque) c_int;
pub extern fn mdbx_cursor_get_batch(cursor: ?*MDBX_cursor, count: [*c]usize, pairs: [*c]MDBX_val, limit: usize, op: MDBX_cursor_op) c_int;
pub extern fn mdbx_cursor_put(cursor: ?*MDBX_cursor, key: [*c]const MDBX_val, data: [*c]MDBX_val, flags: MDBX_put_flags_t) c_int;
pub extern fn mdbx_cursor_del(cursor: ?*MDBX_cursor, flags: MDBX_put_flags_t) c_int;
pub extern fn mdbx_cursor_delete_range(begin: ?*MDBX_cursor, end: ?*MDBX_cursor, end_including: bool, number_of_affected: [*c]u64) c_int;
pub const MDBX_DELETE_CURRENT_VALUE: c_int = 0;
pub const MDBX_DELETE_CURRENT_MULTIVAL_BEFORE_EXCLUDING: c_int = 1;
pub const MDBX_DELETE_CURRENT_MULTIVAL_BEFORE_INCLUDING: c_int = 2;
pub const MDBX_DELETE_CURRENT_MULTIVAL_AFTER_INCLUDING: c_int = 3;
pub const MDBX_DELETE_CURRENT_MULTIVAL_AFTER_EXCLUDING: c_int = 4;
pub const MDBX_DELETE_CURRENT_MULTIVAL_ALL: c_int = 5;
pub const MDBX_DELETE_BEFORE_EXCLUDING: c_int = 6;
pub const MDBX_DELETE_BEFORE_INCLUDING: c_int = 7;
pub const MDBX_DELETE_AFTER_INCLUDING: c_int = 8;
pub const MDBX_DELETE_AFTER_EXCLUDING: c_int = 9;
pub const MDBX_DELETE_WHOLE: c_int = 10;
pub const enum_MDBX_bunch_action = c_uint;
pub const MDBX_bunch_action_t = enum_MDBX_bunch_action;
pub extern fn mdbx_cursor_bunch_delete(cursor: ?*MDBX_cursor, action: MDBX_bunch_action_t, number_of_affected: [*c]u64) c_int;
pub extern fn mdbx_cursor_count(cursor: ?*const MDBX_cursor, count: [*c]usize) c_int;
pub extern fn mdbx_cursor_count_ex(cursor: ?*const MDBX_cursor, count: [*c]usize, stat: [*c]MDBX_stat, bytes: usize) c_int;
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
pub extern fn mdbx_get_keycmp(flags: MDBX_db_flags_t) MDBX_cmp_func;
pub extern fn mdbx_dcmp(txn: ?*const MDBX_txn, dbi: MDBX_dbi, a: [*c]const MDBX_val, b: [*c]const MDBX_val) c_int;
pub extern fn mdbx_get_datacmp(flags: MDBX_db_flags_t) MDBX_cmp_func;
pub const MDBX_reader_list_func = ?*const fn (ctx: ?*anyopaque, num: c_int, slot: c_int, pid: mdbx_pid_t, thread: mdbx_tid_t, txnid: u64, lag: u64, bytes_used: usize, bytes_retained: usize) callconv(.c) c_int;
pub extern fn mdbx_reader_list(env: ?*const MDBX_env, func: MDBX_reader_list_func, ctx: ?*anyopaque) c_int;
pub extern fn mdbx_reader_check(env: ?*MDBX_env, dead: [*c]c_int) c_int;
pub extern fn mdbx_txn_straggler(txn: ?*const MDBX_txn, percent: [*c]c_int) c_int;
pub extern fn mdbx_thread_register(env: ?*const MDBX_env) c_int;
pub extern fn mdbx_thread_unregister(env: ?*const MDBX_env) c_int;
pub const MDBX_hsr_func = ?*const fn (env: ?*const MDBX_env, txn: ?*const MDBX_txn, pid: mdbx_pid_t, tid: mdbx_tid_t, laggard: u64, gap: c_uint, space: usize, retry: c_int) callconv(.c) c_int;
pub extern fn mdbx_env_set_hsr(env: ?*MDBX_env, hsr_callback: MDBX_hsr_func) c_int;
pub extern fn mdbx_env_get_hsr(env: ?*const MDBX_env) MDBX_hsr_func;
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
pub const struct_MDBX_chk_internal_22 = opaque {};
pub const struct_MDBX_chk_issue = extern struct {
    next: [*c]struct_MDBX_chk_issue = null,
    count: usize = 0,
    caption: [*c]const u8 = null,
};
pub const MDBX_chk_issue_t = struct_MDBX_chk_issue;
const union_unnamed_23 = extern union {
    ptr: ?*anyopaque,
    number: usize,
};
pub const struct_MDBX_chk_scope = extern struct {
    issues: [*c]MDBX_chk_issue_t = null,
    internal: ?*struct_MDBX_chk_internal_22 = null,
    object: ?*const anyopaque = null,
    stage: MDBX_chk_stage_t = @import("std").mem.zeroes(MDBX_chk_stage_t),
    verbosity: MDBX_chk_severity_t = @import("std").mem.zeroes(MDBX_chk_severity_t),
    subtotal_issues: usize = 0,
    usr_z: union_unnamed_23 = @import("std").mem.zeroes(union_unnamed_23),
    usr_v: union_unnamed_23 = @import("std").mem.zeroes(union_unnamed_23),
    usr_o: union_unnamed_23 = @import("std").mem.zeroes(union_unnamed_23),
};
pub const MDBX_chk_scope_t = struct_MDBX_chk_scope;
const struct_unnamed_25 = extern struct {
    begin: usize = 0,
    end: usize = 0,
    amount: usize = 0,
    count: usize = 0,
};
pub const struct_MDBX_chk_histogram = extern struct {
    amount: usize = 0,
    count: usize = 0,
    le1_amount: usize = 0,
    le1_count: usize = 0,
    ranges: [9]struct_unnamed_25 = @import("std").mem.zeroes([9]struct_unnamed_25),
};
pub const struct_MDBX_chk_user_table_cookie = opaque {};
pub const MDBX_chk_user_table_cookie_t = struct_MDBX_chk_user_table_cookie;
const struct_unnamed_26 = extern struct {
    all: usize = 0,
    empty: usize = 0,
    broken: usize = 0,
    branch: usize = 0,
    leaf: usize = 0,
    nested_branch: usize = 0,
    nested_leaf: usize = 0,
    nested_subleaf: usize = 0,
};
const struct_unnamed_27 = extern struct {
    height: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    large_pages: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    nested_height_or_gc_span_length: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    key_len: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    val_len: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    multival: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    tree_density: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    large_or_nested_density: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    page_age: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    pgno: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
};
pub const struct_MDBX_chk_table = extern struct {
    cookie: ?*MDBX_chk_user_table_cookie_t = null,
    name: MDBX_val = @import("std").mem.zeroes(MDBX_val),
    flags: MDBX_db_flags_t = @import("std").mem.zeroes(MDBX_db_flags_t),
    id: c_int = 0,
    payload_bytes: usize = 0,
    lost_bytes: usize = 0,
    pages: struct_unnamed_26 = @import("std").mem.zeroes(struct_unnamed_26),
    histogram: struct_unnamed_27 = @import("std").mem.zeroes(struct_unnamed_27),
};
pub const MDBX_chk_table_t = struct_MDBX_chk_table;
const struct_unnamed_24 = extern struct {
    total_payload_bytes: usize = 0,
    table_total: usize = 0,
    table_processed: usize = 0,
    total_unused_bytes: usize = 0,
    unused_pages: usize = 0,
    processed_pages: usize = 0,
    reclaimable_pages: usize = 0,
    gc_pages: usize = 0,
    alloc_pages: usize = 0,
    backed_pages: usize = 0,
    problems_meta: usize = 0,
    tree_problems: usize = 0,
    gc_tree_problems: usize = 0,
    kv_tree_problems: usize = 0,
    problems_gc: usize = 0,
    problems_kv: usize = 0,
    total_problems: usize = 0,
    steady_txnid: u64 = 0,
    recent_txnid: u64 = 0,
    histogram_page_age: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    histogram_pgno_payload: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    histogram_pgno_retained: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    tables: [*c]const [*c]const MDBX_chk_table_t = null,
};
pub const struct_MDBX_chk_context = extern struct {
    internal: ?*struct_MDBX_chk_internal_22 = null,
    env: ?*MDBX_env = null,
    txn: ?*MDBX_txn = null,
    scope: [*c]MDBX_chk_scope_t = null,
    scope_nesting: u8 = 0,
    result: struct_unnamed_24 = @import("std").mem.zeroes(struct_unnamed_24),
    pub const mdbx_env_chk_encount_problem = __root.mdbx_env_chk_encount_problem;
    pub const problem = __root.mdbx_env_chk_encount_problem;
};
pub const struct_MDBX_chk_line = extern struct {
    ctx: [*c]struct_MDBX_chk_context = null,
    severity: u8 = 0,
    scope_depth: u8 = 0,
    empty: u8 = 0,
    begin: [*c]u8 = null,
    end: [*c]u8 = null,
    out: [*c]u8 = null,
};
pub const MDBX_chk_line_t = struct_MDBX_chk_line;
pub const MDBX_chk_context_t = struct_MDBX_chk_context;
pub const struct_MDBX_chk_callbacks = extern struct {
    check_break: ?*const fn (ctx: [*c]MDBX_chk_context_t) callconv(.c) bool = null,
    scope_push: ?*const fn (ctx: [*c]MDBX_chk_context_t, outer: [*c]MDBX_chk_scope_t, inner: [*c]MDBX_chk_scope_t, fmt: [*c]const u8, args: [*c]struct___va_list_tag_1) callconv(.c) c_int = null,
    scope_conclude: ?*const fn (ctx: [*c]MDBX_chk_context_t, outer: [*c]MDBX_chk_scope_t, inner: [*c]MDBX_chk_scope_t, err: c_int) callconv(.c) c_int = null,
    scope_pop: ?*const fn (ctx: [*c]MDBX_chk_context_t, outer: [*c]MDBX_chk_scope_t, inner: [*c]MDBX_chk_scope_t) callconv(.c) void = null,
    issue: ?*const fn (ctx: [*c]MDBX_chk_context_t, object: [*c]const u8, entry_number: u64, issue: [*c]const u8, extra_fmt: [*c]const u8, extra_args: [*c]struct___va_list_tag_1) callconv(.c) void = null,
    table_filter: ?*const fn (ctx: [*c]MDBX_chk_context_t, name: [*c]const MDBX_val, flags: MDBX_db_flags_t) callconv(.c) ?*MDBX_chk_user_table_cookie_t = null,
    table_conclude: ?*const fn (ctx: [*c]MDBX_chk_context_t, table: [*c]const MDBX_chk_table_t, cursor: ?*MDBX_cursor, err: c_int) callconv(.c) c_int = null,
    table_dispose: ?*const fn (ctx: [*c]MDBX_chk_context_t, table: [*c]const MDBX_chk_table_t) callconv(.c) void = null,
    table_handle_kv: ?*const fn (ctx: [*c]MDBX_chk_context_t, table: [*c]const MDBX_chk_table_t, entry_number: usize, key: [*c]const MDBX_val, value: [*c]const MDBX_val) callconv(.c) c_int = null,
    stage_begin: ?*const fn (ctx: [*c]MDBX_chk_context_t, MDBX_chk_stage_t) callconv(.c) c_int = null,
    stage_end: ?*const fn (ctx: [*c]MDBX_chk_context_t, MDBX_chk_stage_t, err: c_int) callconv(.c) c_int = null,
    print_begin: ?*const fn (ctx: [*c]MDBX_chk_context_t, severity: MDBX_chk_severity_t) callconv(.c) [*c]MDBX_chk_line_t = null,
    print_flush: ?*const fn ([*c]MDBX_chk_line_t) callconv(.c) void = null,
    print_done: ?*const fn ([*c]MDBX_chk_line_t) callconv(.c) void = null,
    print_chars: ?*const fn ([*c]MDBX_chk_line_t, str: [*c]const u8, len: usize) callconv(.c) void = null,
    print_format: ?*const fn ([*c]MDBX_chk_line_t, fmt: [*c]const u8, args: [*c]struct___va_list_tag_1) callconv(.c) void = null,
    print_size: ?*const fn ([*c]MDBX_chk_line_t, prefix: [*c]const u8, value: u64, suffix: [*c]const u8) callconv(.c) void = null,
};
pub const MDBX_chk_callbacks_t = struct_MDBX_chk_callbacks;
pub extern fn mdbx_env_chk(env: ?*MDBX_env, cb: [*c]const MDBX_chk_callbacks_t, ctx: [*c]MDBX_chk_context_t, flags: MDBX_chk_flags_t, verbosity: MDBX_chk_severity_t, timeout_seconds_16dot16: c_uint) c_int;
pub extern fn mdbx_env_chk_encount_problem(ctx: [*c]MDBX_chk_context_t) c_int;
pub extern fn mdbx_ratio2digits(numerator: u64, denominator: u64, precision: c_int, buffer: [*c]u8, buffer_size: usize) [*c]const u8;
pub extern fn mdbx_ratio2percents(value: u64, whole: u64, buffer: [*c]u8, buffer_size: usize) [*c]const u8;
pub const MDBX_gc_iter_func = ?*const fn (ctx: ?*anyopaque, txn: ?*const MDBX_txn, span_txnid: u64, span_pgno: usize, span_length: usize, span_is_reclaimable: bool) callconv(.c) c_int;
const struct_unnamed_28 = extern struct {
    pages: usize = 0,
    span_histogram: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
    pgno_distribution: struct_MDBX_chk_histogram = @import("std").mem.zeroes(struct_MDBX_chk_histogram),
};
pub const struct_MDBX_gc_info = extern struct {
    pages_total: usize = 0,
    pages_backed: usize = 0,
    pages_allocated: usize = 0,
    pages_gc: usize = 0,
    gc_reclaimable: struct_unnamed_28 = @import("std").mem.zeroes(struct_unnamed_28),
    max_reader_lag: usize = 0,
    max_retained_pages: usize = 0,
};
pub const MDBX_gc_info_t = struct_MDBX_gc_info;
pub extern fn mdbx_gc_info(txn: ?*MDBX_txn, info: [*c]MDBX_gc_info_t, bytes: usize, iter_func: MDBX_gc_iter_func, iter_ctx: ?*anyopaque) c_int;
pub const MDBX_defrag_noobstacles: c_int = 0;
pub const MDBX_defrag_step_size: c_int = 1;
pub const MDBX_defrag_large_chunk: c_int = 2;
pub const MDBX_defrag_discontinued: c_int = 4;
pub const MDBX_defrag_laggard_reader: c_int = 8;
pub const MDBX_defrag_enough_threshold: c_int = 16;
pub const MDBX_defrag_time_limit: c_int = 32;
pub const MDBX_defrag_aborted: c_int = 64;
pub const MDBX_defrag_error: c_int = 128;
pub const enum_MDBX_defrag_stopping_reasons = c_uint;
pub const MDBX_defrag_stopping_reasons_t = enum_MDBX_defrag_stopping_reasons;
pub const struct_MDBX_defrag_result = extern struct {
    pages_shrinked: isize = 0,
    pages_moved: usize = 0,
    pages_scheduled: usize = 0,
    pages_retained: usize = 0,
    pages_left: usize = 0,
    pages_whole: usize = 0,
    obstructed_pgno: usize = 0,
    obstructed_span: usize = 0,
    obstructed_txnid: u64 = 0,
    obstructor_tid: mdbx_tid_t = 0,
    obstructor_pid: mdbx_pid_t = 0,
    rough_estimation_cycle_progress_permille: c_uint = 0,
    cycles: c_uint = 0,
    stopping_reasons: c_uint = 0,
    spent_time_dot16: usize = 0,
};
pub const MDBX_defrag_result_t = struct_MDBX_defrag_result;
pub const MDBX_defrag_notify_func = ?*const fn (ctx: ?*anyopaque, progress: [*c]const MDBX_defrag_result_t) callconv(.c) c_int;
pub extern fn mdbx_env_defrag(env: ?*MDBX_env, defrag_atleast: usize, time_atleast_dot16: usize, defrag_enough: usize, time_limit_dot16: usize, acceptable_backlash: isize, preferred_batch: isize, progress_callback: MDBX_defrag_notify_func, ctx: ?*anyopaque, result: [*c]MDBX_defrag_result_t) c_int;

pub const __VERSION__ = "Aro aro-zig";
pub const __Aro__ = "";
pub const __STDC__ = @as(c_int, 1);
pub const __STDC_HOSTED__ = @as(c_int, 1);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const __STDC_EMBED_NOT_FOUND__ = @as(c_int, 0);
pub const __STDC_EMBED_FOUND__ = @as(c_int, 1);
pub const __STDC_EMBED_EMPTY__ = @as(c_int, 2);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __GNUC__ = @as(c_int, 7);
pub const __GNUC_MINOR__ = @as(c_int, 1);
pub const __GNUC_PATCHLEVEL__ = @as(c_int, 0);
pub const __ARO_EMULATE_NO__ = @as(c_int, 0);
pub const __ARO_EMULATE_CLANG__ = @as(c_int, 1);
pub const __ARO_EMULATE_GCC__ = @as(c_int, 2);
pub const __ARO_EMULATE_MSVC__ = @as(c_int, 3);
pub const __ARO_EMULATE__ = __ARO_EMULATE_GCC__;
pub inline fn __building_module(x: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &x;
    return @as(c_int, 0);
}
pub const linux = @as(c_int, 1);
pub const __linux = @as(c_int, 1);
pub const __linux__ = @as(c_int, 1);
pub const unix = @as(c_int, 1);
pub const __unix = @as(c_int, 1);
pub const __unix__ = @as(c_int, 1);
pub const __code_model_small__ = @as(c_int, 1);
pub const __amd64__ = @as(c_int, 1);
pub const __amd64 = @as(c_int, 1);
pub const __x86_64__ = @as(c_int, 1);
pub const __x86_64 = @as(c_int, 1);
pub const __SEG_GS = @as(c_int, 1);
pub const __SEG_FS = @as(c_int, 1);
pub const __seg_gs = @compileError("unable to translate macro: undefined identifier `address_space`"); // <builtin>:33:9
pub const __seg_fs = @compileError("unable to translate macro: undefined identifier `address_space`"); // <builtin>:34:9
pub const __LAHF_SAHF__ = @as(c_int, 1);
pub const __AES__ = @as(c_int, 1);
pub const __VAES__ = @as(c_int, 1);
pub const __PCLMUL__ = @as(c_int, 1);
pub const __VPCLMULQDQ__ = @as(c_int, 1);
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
pub const __SSE4A__ = @as(c_int, 1);
pub const __FMA__ = @as(c_int, 1);
pub const __F16C__ = @as(c_int, 1);
pub const __GFNI__ = @as(c_int, 1);
pub const __EVEX512__ = @as(c_int, 1);
pub const __AVX512CD__ = @as(c_int, 1);
pub const __AVX512VPOPCNTDQ__ = @as(c_int, 1);
pub const __AVX512VNNI__ = @as(c_int, 1);
pub const __AVX512BF16__ = @as(c_int, 1);
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
pub const __CLZERO__ = @as(c_int, 1);
pub const __RDPID__ = @as(c_int, 1);
pub const __INVPCID__ = @as(c_int, 1);
pub const __AVXVNNI__ = @as(c_int, 1);
pub const __CRC32__ = @as(c_int, 1);
pub const __AVX512F__ = @as(c_int, 1);
pub const __AVX2__ = @as(c_int, 1);
pub const __AVX__ = @as(c_int, 1);
pub const __SSE4_2__ = @as(c_int, 1);
pub const __SSE4_1__ = @as(c_int, 1);
pub const __SSSE3__ = @as(c_int, 1);
pub const __SSE3__ = @as(c_int, 1);
pub const __SSE2__ = @as(c_int, 1);
pub const __SSE__ = @as(c_int, 1);
pub const __SSE_MATH__ = @as(c_int, 1);
pub const __MMX__ = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = @as(c_int, 1);
pub const __SIZEOF_FLOAT128__ = @as(c_int, 16);
pub const _LP64 = @as(c_int, 1);
pub const __LP64__ = @as(c_int, 1);
pub const __FLOAT128__ = @as(c_int, 1);
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const __ELF__ = @as(c_int, 1);
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __ATOMIC_BOOL_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_WINT_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_SHORT_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_INT_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_LONG_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_LLONG_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_POINTER_LOCK_FREE = @as(c_int, 1);
pub const __WINT_UNSIGNED__ = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 8);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SCHAR_WIDTH__ = @as(c_int, 8);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __LONG_WIDTH__ = @as(c_int, 64);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __LONG_LONG_WIDTH__ = @as(c_int, 64);
pub const __WCHAR_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 32);
pub const __WINT_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __WINT_WIDTH__ = @as(c_int, 32);
pub const __INTMAX_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __SIZE_WIDTH__ = @as(c_int, 64);
pub const __UINTMAX_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 64);
pub const __INTPTR_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTPTR_WIDTH__ = @as(c_int, 64);
pub const __UINTPTR_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTPTR_WIDTH__ = @as(c_int, 64);
pub const __SIG_ATOMIC_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __BITINT_MAXWIDTH__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 10);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 8);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 8);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 8);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 8);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 4);
pub const __SIZEOF_WINT_T__ = @as(c_int, 4);
pub const __SIZEOF_INT128__ = @as(c_int, 16);
pub const __INTPTR_TYPE__ = c_long;
pub const __UINTPTR_TYPE__ = c_ulong;
pub const __INTMAX_TYPE__ = c_long;
pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`"); // <builtin>:170:9
pub const __INTMAX_C = __helpers.L_SUFFIX;
pub const __UINTMAX_TYPE__ = c_ulong;
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`"); // <builtin>:173:9
pub const __UINTMAX_C = __helpers.UL_SUFFIX;
pub const __PTRDIFF_TYPE__ = c_long;
pub const __SIZE_TYPE__ = c_ulong;
pub const __WCHAR_TYPE__ = c_int;
pub const __WINT_TYPE__ = c_uint;
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub inline fn __INT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub inline fn __INT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub inline fn __INT32_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT64_TYPE__ = c_long;
pub const __INT64_FMTd__ = "ld";
pub const __INT64_FMTi__ = "li";
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`"); // <builtin>:199:9
pub const __INT64_C = __helpers.L_SUFFIX;
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub inline fn __UINT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub inline fn __UINT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __UINT16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`"); // <builtin>:224:9
pub const __UINT32_C = __helpers.U_SUFFIX;
pub const __UINT32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulong;
pub const __UINT64_FMTo__ = "lo";
pub const __UINT64_FMTu__ = "lu";
pub const __UINT64_FMTx__ = "lx";
pub const __UINT64_FMTX__ = "lX";
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`"); // <builtin>:233:9
pub const __UINT64_C = __helpers.UL_SUFFIX;
pub const __UINT64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __INT64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const INT_LEAST8_FMTd__ = "hhd";
pub const INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const UINT_LEAST8_FMTo__ = "hho";
pub const UINT_LEAST8_FMTu__ = "hhu";
pub const UINT_LEAST8_FMTx__ = "hhx";
pub const UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const INT_FAST8_FMTd__ = "hhd";
pub const INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const UINT_FAST8_FMTo__ = "hho";
pub const UINT_FAST8_FMTu__ = "hhu";
pub const UINT_FAST8_FMTx__ = "hhx";
pub const UINT_FAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const INT_LEAST16_FMTd__ = "hd";
pub const INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_LEAST16_FMTo__ = "ho";
pub const UINT_LEAST16_FMTu__ = "hu";
pub const UINT_LEAST16_FMTx__ = "hx";
pub const UINT_LEAST16_FMTX__ = "hX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const INT_FAST16_FMTd__ = "hd";
pub const INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_FAST16_FMTo__ = "ho";
pub const UINT_FAST16_FMTu__ = "hu";
pub const UINT_FAST16_FMTx__ = "hx";
pub const UINT_FAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const INT_LEAST32_FMTd__ = "d";
pub const INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_LEAST32_FMTo__ = "o";
pub const UINT_LEAST32_FMTu__ = "u";
pub const UINT_LEAST32_FMTx__ = "x";
pub const UINT_LEAST32_FMTX__ = "X";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const INT_FAST32_FMTd__ = "d";
pub const INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_FAST32_FMTo__ = "o";
pub const UINT_FAST32_FMTu__ = "u";
pub const UINT_FAST32_FMTx__ = "x";
pub const UINT_FAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_long;
pub const __INT_LEAST64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const INT_LEAST64_FMTd__ = "ld";
pub const INT_LEAST64_FMTi__ = "li";
pub const __UINT_LEAST64_TYPE__ = c_ulong;
pub const __UINT_LEAST64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_LEAST64_FMTo__ = "lo";
pub const UINT_LEAST64_FMTu__ = "lu";
pub const UINT_LEAST64_FMTx__ = "lx";
pub const UINT_LEAST64_FMTX__ = "lX";
pub const __INT_FAST64_TYPE__ = c_long;
pub const __INT_FAST64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const INT_FAST64_FMTd__ = "ld";
pub const INT_FAST64_FMTi__ = "li";
pub const __UINT_FAST64_TYPE__ = c_ulong;
pub const __UINT_FAST64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST64_FMTo__ = "lo";
pub const UINT_FAST64_FMTu__ = "lu";
pub const UINT_FAST64_FMTx__ = "lx";
pub const UINT_FAST64_FMTX__ = "lX";
pub const __FLT16_DENORM_MIN__ = @as(f16, 5.9604644775390625e-8);
pub const __FLT16_HAS_DENORM__ = "";
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_EPSILON__ = @as(f16, 9.765625e-4);
pub const __FLT16_HAS_INFINITY__ = "";
pub const __FLT16_HAS_QUIET_NAN__ = "";
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT16_MIN__ = @as(f16, 6.103515625e-5);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_HAS_DENORM__ = "";
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = "";
pub const __FLT_HAS_QUIET_NAN__ = "";
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_HAS_DENORM__ = "";
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = "";
pub const __DBL_HAS_QUIET_NAN__ = "";
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 3.64519953188247460253e-4951);
pub const __LDBL_HAS_DENORM__ = "";
pub const __LDBL_DIG__ = @as(c_int, 18);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 21);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 1.08420217248550443401e-19);
pub const __LDBL_HAS_INFINITY__ = "";
pub const __LDBL_HAS_QUIET_NAN__ = "";
pub const __LDBL_MANT_DIG__ = @as(c_int, 64);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 4932);
pub const __LDBL_MAX_EXP__ = @as(c_int, 16384);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.18973149535723176502e+4932);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 4931);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 16381);
pub const __LDBL_MIN__ = @as(c_longdouble, 3.36210314311209350626e-4932);
pub const __FLT_EVAL_METHOD__ = @as(c_int, 0);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __pic__ = @as(c_int, 2);
pub const __PIC__ = @as(c_int, 2);
pub const __GLIBC_MINOR__ = @as(c_int, 39);
pub const LIBMDBX_H = "";
pub const __STDC_VERSION_STDARG_H__ = @as(c_int, 0);
pub const va_start = @compileError("unable to translate macro: undefined identifier `__builtin_va_start`"); // /home/sayan/Bin/zig/lib/compiler/aro/include/stdarg.h:12:9
pub const va_end = @compileError("unable to translate macro: undefined identifier `__builtin_va_end`"); // /home/sayan/Bin/zig/lib/compiler/aro/include/stdarg.h:14:9
pub const va_arg = @compileError("unable to translate macro: undefined identifier `__builtin_va_arg`"); // /home/sayan/Bin/zig/lib/compiler/aro/include/stdarg.h:15:9
pub const __va_copy = @compileError("unable to translate macro: undefined identifier `__builtin_va_copy`"); // /home/sayan/Bin/zig/lib/compiler/aro/include/stdarg.h:18:9
pub const va_copy = @compileError("unable to translate macro: undefined identifier `__builtin_va_copy`"); // /home/sayan/Bin/zig/lib/compiler/aro/include/stdarg.h:22:9
pub const __GNUC_VA_LIST = @as(c_int, 1);
pub const __STDC_VERSION_STDDEF_H__ = @as(c_long, 202311);
pub const NULL = __helpers.cast(?*anyopaque, @as(c_int, 0));
pub const offsetof = @compileError("unable to translate macro: undefined identifier `__builtin_offsetof`"); // /home/sayan/Bin/zig/lib/compiler/aro/include/stddef.h:18:9
pub const __CLANG_STDINT_H = "";
pub const _STDINT_H = @as(c_int, 1);
pub const _FEATURES_H = @as(c_int, 1);
pub const __KERNEL_STRICT_NAMES = "";
pub inline fn __GNUC_PREREQ(maj: anytype, min: anytype) @TypeOf(((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min);
}
pub inline fn __glibc_clang_prereq(maj: anytype, min: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &maj;
    _ = &min;
    return @as(c_int, 0);
}
pub const __GLIBC_USE = @compileError("unable to translate macro: undefined identifier `__GLIBC_USE_`"); // /usr/include/features.h:188:9
pub const _DEFAULT_SOURCE = @as(c_int, 1);
pub const __GLIBC_USE_ISOC2X = @as(c_int, 0);
pub const __USE_ISOC11 = @as(c_int, 1);
pub const __USE_POSIX_IMPLICITLY = @as(c_int, 1);
pub const _POSIX_SOURCE = @as(c_int, 1);
pub const _POSIX_C_SOURCE = @as(c_long, 200809);
pub const __USE_POSIX = @as(c_int, 1);
pub const __USE_POSIX2 = @as(c_int, 1);
pub const __USE_POSIX199309 = @as(c_int, 1);
pub const __USE_POSIX199506 = @as(c_int, 1);
pub const __USE_XOPEN2K = @as(c_int, 1);
pub const __USE_ISOC95 = @as(c_int, 1);
pub const __USE_ISOC99 = @as(c_int, 1);
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
pub const __GLIBC_USE_C2X_STRTOL = @as(c_int, 0);
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
pub const __glibc_has_attribute = @compileError("unable to translate macro: undefined identifier `__has_attribute`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:45:10
pub inline fn __glibc_has_builtin(name: anytype) @TypeOf(__builtin.has_builtin(name)) {
    _ = &name;
    return __builtin.has_builtin(name);
}
pub const __glibc_has_extension = @compileError("unable to translate macro: undefined identifier `__has_extension`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:55:10
pub const __LEAF = @compileError("unable to translate macro: undefined identifier `__leaf__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:65:11
pub const __LEAF_ATTR = @compileError("unable to translate macro: undefined identifier `__leaf__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:66:11
pub const __THROW = @compileError("unable to translate macro: undefined identifier `__nothrow__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:79:11
pub const __THROWNL = @compileError("unable to translate macro: undefined identifier `__nothrow__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:80:11
pub const __NTH = @compileError("unable to translate macro: undefined identifier `__nothrow__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:81:11
pub const __NTHNL = @compileError("unable to translate macro: undefined identifier `__nothrow__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:82:11
pub const __COLD = @compileError("unable to translate macro: undefined identifier `__cold__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:102:11
pub inline fn __P(args: anytype) @TypeOf(args) {
    _ = &args;
    return args;
}
pub inline fn __PMT(args: anytype) @TypeOf(args) {
    _ = &args;
    return args;
}
pub const __CONCAT = @compileError("unable to translate C expr: unexpected token '##'"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:131:9
pub const __STRING = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:132:9
pub const __ptr_t = ?*anyopaque;
pub const __BEGIN_DECLS = "";
pub const __END_DECLS = "";
pub inline fn __bos(ptr: anytype) @TypeOf(__builtin.object_size(ptr, __USE_FORTIFY_LEVEL > @as(c_int, 1))) {
    _ = &ptr;
    return __builtin.object_size(ptr, __USE_FORTIFY_LEVEL > @as(c_int, 1));
}
pub inline fn __bos0(ptr: anytype) @TypeOf(__builtin.object_size(ptr, @as(c_int, 0))) {
    _ = &ptr;
    return __builtin.object_size(ptr, @as(c_int, 0));
}
pub inline fn __glibc_objsize0(__o: anytype) @TypeOf(__bos0(__o)) {
    _ = &__o;
    return __bos0(__o);
}
pub inline fn __glibc_objsize(__o: anytype) @TypeOf(__bos(__o)) {
    _ = &__o;
    return __bos(__o);
}
pub const __warnattr = @compileError("unable to translate macro: undefined identifier `__warning__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:212:10
pub const __errordecl = @compileError("unable to translate macro: undefined identifier `__error__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:213:10
pub const __flexarr = @compileError("unable to translate C expr: unexpected token '['"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:225:10
pub const __glibc_c99_flexarr_available = @as(c_int, 1);
pub const __REDIRECT = @compileError("unable to translate C expr: unexpected token '__asm__'"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:256:10
pub const __REDIRECT_NTH = @compileError("unable to translate C expr: unexpected token '__asm__'"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:263:11
pub const __REDIRECT_NTHNL = @compileError("unable to translate C expr: unexpected token '__asm__'"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:265:11
pub const __ASMNAME = @compileError("unable to translate macro: undefined identifier `__USER_LABEL_PREFIX__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:268:10
pub inline fn __ASMNAME2(prefix: anytype, cname: anytype) @TypeOf(__STRING(prefix) ++ cname) {
    _ = &prefix;
    _ = &cname;
    return __STRING(prefix) ++ cname;
}
pub const __REDIRECT_FORTIFY = __REDIRECT;
pub const __REDIRECT_FORTIFY_NTH = __REDIRECT_NTH;
pub const __attribute_malloc__ = @compileError("unable to translate macro: undefined identifier `__malloc__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:298:10
pub const __attribute_alloc_size__ = @compileError("unable to translate macro: undefined identifier `__alloc_size__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:306:10
pub const __attribute_alloc_align__ = @compileError("unable to translate macro: undefined identifier `__alloc_align__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:315:10
pub const __attribute_pure__ = @compileError("unable to translate macro: undefined identifier `__pure__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:325:10
pub const __attribute_const__ = @compileError("unable to translate C expr: unexpected token '__attribute__'"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:332:10
pub const __attribute_maybe_unused__ = @compileError("unable to translate macro: undefined identifier `__unused__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:338:10
pub const __attribute_used__ = @compileError("unable to translate macro: undefined identifier `__used__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:347:10
pub const __attribute_noinline__ = @compileError("unable to translate macro: undefined identifier `__noinline__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:348:10
pub const __attribute_deprecated__ = @compileError("unable to translate macro: undefined identifier `__deprecated__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:356:10
pub const __attribute_deprecated_msg__ = @compileError("unable to translate macro: undefined identifier `__deprecated__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:366:10
pub const __attribute_format_arg__ = @compileError("unable to translate macro: undefined identifier `__format_arg__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:379:10
pub const __attribute_format_strfmon__ = @compileError("unable to translate macro: undefined identifier `__format__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:389:10
pub const __attribute_nonnull__ = @compileError("unable to translate macro: undefined identifier `__nonnull__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:401:11
pub inline fn __nonnull(params: anytype) @TypeOf(__attribute_nonnull__(params)) {
    _ = &params;
    return __attribute_nonnull__(params);
}
pub const __returns_nonnull = @compileError("unable to translate macro: undefined identifier `__returns_nonnull__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:414:10
pub const __attribute_warn_unused_result__ = @compileError("unable to translate macro: undefined identifier `__warn_unused_result__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:423:10
pub const __wur = "";
pub const __always_inline = @compileError("unable to translate macro: undefined identifier `__always_inline__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:441:10
pub const __attribute_artificial__ = @compileError("unable to translate macro: undefined identifier `__artificial__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:450:10
pub const __extern_inline = @compileError("unable to translate C expr: unexpected token 'extern'"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:472:11
pub const __extern_always_inline = @compileError("unable to translate C expr: unexpected token 'extern'"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:473:11
pub const __fortify_function = __extern_always_inline ++ __attribute_artificial__;
pub const __va_arg_pack = @compileError("unable to translate macro: undefined identifier `__builtin_va_arg_pack`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:484:10
pub const __va_arg_pack_len = @compileError("unable to translate macro: undefined identifier `__builtin_va_arg_pack_len`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:485:10
pub const __restrict_arr = @compileError("unable to translate C expr: unexpected token '__restrict'"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:512:10
pub inline fn __glibc_unlikely(cond: anytype) @TypeOf(__builtin.expect(cond, @as(c_int, 0))) {
    _ = &cond;
    return __builtin.expect(cond, @as(c_int, 0));
}
pub inline fn __glibc_likely(cond: anytype) @TypeOf(__builtin.expect(cond, @as(c_int, 1))) {
    _ = &cond;
    return __builtin.expect(cond, @as(c_int, 1));
}
pub const __attribute_nonstring__ = "";
pub inline fn __attribute_copy__(arg: anytype) void {
    _ = &arg;
    return;
}
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
pub inline fn __LDBL_REDIR2_DECL(name: anytype) void {
    _ = &name;
    return;
}
pub inline fn __LDBL_REDIR_DECL(name: anytype) void {
    _ = &name;
    return;
}
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
pub const __glibc_macro_warning1 = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:653:10
pub const __glibc_macro_warning = @compileError("unable to translate macro: undefined identifier `GCC`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:654:10
pub const __HAVE_GENERIC_SELECTION = @as(c_int, 1);
pub inline fn __fortified_attr_access(a: anytype, o: anytype, s: anytype) void {
    _ = &a;
    _ = &o;
    _ = &s;
    return;
}
pub inline fn __attr_access(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __attr_access_none(argno: anytype) void {
    _ = &argno;
    return;
}
pub inline fn __attr_dealloc(dealloc: anytype, argno: anytype) void {
    _ = &dealloc;
    _ = &argno;
    return;
}
pub const __attr_dealloc_free = "";
pub const __attribute_returns_twice__ = @compileError("unable to translate macro: undefined identifier `__returns_twice__`"); // /usr/include/x86_64-linux-gnu/sys/cdefs.h:718:10
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
pub const __FSID_T_TYPE = @compileError("unable to translate macro: undefined identifier `__val`"); // /usr/include/x86_64-linux-gnu/bits/typesizes.h:73:9
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
pub const _BITS_STDINT_LEAST_H = @as(c_int, 1);
pub const __intptr_t_defined = "";
pub const INT8_MIN = -@as(c_int, 128);
pub const INT16_MIN = -@as(c_int, 32767) - @as(c_int, 1);
pub const INT32_MIN = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const INT64_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT8_MAX = @as(c_int, 127);
pub const INT16_MAX = @as(c_int, 32767);
pub const INT32_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT64_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT8_MAX = @as(c_int, 255);
pub const UINT16_MAX = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT32_MAX = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT64_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INT_LEAST8_MIN = -@as(c_int, 128);
pub const INT_LEAST16_MIN = -@as(c_int, 32767) - @as(c_int, 1);
pub const INT_LEAST32_MIN = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const INT_LEAST64_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT_LEAST8_MAX = @as(c_int, 127);
pub const INT_LEAST16_MAX = @as(c_int, 32767);
pub const INT_LEAST32_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT_LEAST64_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT_LEAST8_MAX = @as(c_int, 255);
pub const UINT_LEAST16_MAX = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_LEAST32_MAX = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_LEAST64_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INT_FAST8_MIN = -@as(c_int, 128);
pub const INT_FAST16_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INT_FAST32_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INT_FAST64_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT_FAST8_MAX = @as(c_int, 127);
pub const INT_FAST16_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INT_FAST32_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INT_FAST64_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT_FAST8_MAX = @as(c_int, 255);
pub const UINT_FAST16_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST32_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST64_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INTPTR_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INTPTR_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const UINTPTR_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const INTMAX_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INTMAX_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINTMAX_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const PTRDIFF_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const PTRDIFF_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const SIG_ATOMIC_MIN = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const SIG_ATOMIC_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const SIZE_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const WCHAR_MIN = __WCHAR_MIN;
pub const WCHAR_MAX = __WCHAR_MAX;
pub const WINT_MIN = @as(c_uint, 0);
pub const WINT_MAX = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
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
pub const INT64_C = __helpers.L_SUFFIX;
pub inline fn UINT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn UINT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const UINT32_C = __helpers.U_SUFFIX;
pub const UINT64_C = __helpers.UL_SUFFIX;
pub const INTMAX_C = __helpers.L_SUFFIX;
pub const UINTMAX_C = __helpers.UL_SUFFIX;
pub const _ASSERT_H = @as(c_int, 1);
pub const __ASSERT_VOID_CAST = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/assert.h:40:10
pub const _ASSERT_H_DECLS = "";
pub const assert = @compileError("unable to translate macro: undefined identifier `__FILE__`"); // /usr/include/assert.h:118:11
pub const __ASSERT_FUNCTION = @compileError("unable to translate C expr: unexpected token '__extension__'"); // /usr/include/assert.h:140:12
pub const static_assert = @compileError("unable to translate C expr: unexpected token '_Static_assert'"); // /usr/include/assert.h:158:10
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
pub const __need_size_t = "";
pub const __need_NULL = "";
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
pub const __NCPUBITS = @as(c_int, 8) * __helpers.sizeof(__cpu_mask);
pub inline fn __CPUELT(cpu: anytype) @TypeOf(__helpers.div(cpu, __NCPUBITS)) {
    _ = &cpu;
    return __helpers.div(cpu, __NCPUBITS);
}
pub inline fn __CPUMASK(cpu: anytype) @TypeOf(__helpers.cast(__cpu_mask, @as(c_int, 1)) << __helpers.rem(cpu, __NCPUBITS)) {
    _ = &cpu;
    return __helpers.cast(__cpu_mask, @as(c_int, 1)) << __helpers.rem(cpu, __NCPUBITS);
}
pub const __CPU_ZERO_S = @compileError("unable to translate C expr: unexpected token 'do'"); // /usr/include/x86_64-linux-gnu/bits/cpu-set.h:46:10
pub const __CPU_SET_S = @compileError("unable to translate macro: undefined identifier `__cpu`"); // /usr/include/x86_64-linux-gnu/bits/cpu-set.h:58:9
pub const __CPU_CLR_S = @compileError("unable to translate macro: undefined identifier `__cpu`"); // /usr/include/x86_64-linux-gnu/bits/cpu-set.h:65:9
pub const __CPU_ISSET_S = @compileError("unable to translate macro: undefined identifier `__cpu`"); // /usr/include/x86_64-linux-gnu/bits/cpu-set.h:72:9
pub inline fn __CPU_COUNT_S(setsize: anytype, cpusetp: anytype) @TypeOf(__sched_cpucount(setsize, cpusetp)) {
    _ = &setsize;
    _ = &cpusetp;
    return __sched_cpucount(setsize, cpusetp);
}
pub const __CPU_EQUAL_S = @compileError("unable to translate macro: undefined identifier `__builtin_memcmp`"); // /usr/include/x86_64-linux-gnu/bits/cpu-set.h:84:10
pub const __CPU_OP_S = @compileError("unable to translate macro: undefined identifier `__dest`"); // /usr/include/x86_64-linux-gnu/bits/cpu-set.h:99:9
pub inline fn __CPU_ALLOC_SIZE(count: anytype) @TypeOf(__helpers.div((count + __NCPUBITS) - @as(c_int, 1), __NCPUBITS) * __helpers.sizeof(__cpu_mask)) {
    _ = &count;
    return __helpers.div((count + __NCPUBITS) - @as(c_int, 1), __NCPUBITS) * __helpers.sizeof(__cpu_mask);
}
pub inline fn __CPU_ALLOC(count: anytype) @TypeOf(__sched_cpualloc(count)) {
    _ = &count;
    return __sched_cpualloc(count);
}
pub inline fn __CPU_FREE(cpuset: anytype) @TypeOf(__sched_cpufree(cpuset)) {
    _ = &cpuset;
    return __sched_cpufree(cpuset);
}
pub const sched_priority = @compileError("unable to translate macro: undefined identifier `sched_priority`"); // /usr/include/sched.h:47:9
pub const __sched_priority = sched_priority;
pub const _TIME_H = @as(c_int, 1);
pub const _BITS_TIME_H = @as(c_int, 1);
pub const CLOCKS_PER_SEC = __helpers.cast(__clock_t, __helpers.promoteIntLiteral(c_int, 1000000, .decimal));
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
pub inline fn __isleap(year: anytype) @TypeOf((__helpers.rem(year, @as(c_int, 4)) == @as(c_int, 0)) and ((__helpers.rem(year, @as(c_int, 100)) != @as(c_int, 0)) or (__helpers.rem(year, @as(c_int, 400)) == @as(c_int, 0)))) {
    _ = &year;
    return (__helpers.rem(year, @as(c_int, 4)) == @as(c_int, 0)) and ((__helpers.rem(year, @as(c_int, 100)) != @as(c_int, 0)) or (__helpers.rem(year, @as(c_int, 400)) == @as(c_int, 0)));
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
pub const __PTHREAD_MUTEX_INITIALIZER = @compileError("unable to translate C expr: unexpected token '{'"); // /usr/include/x86_64-linux-gnu/bits/struct_mutex.h:56:10
pub const _RWLOCK_INTERNAL_H = "";
pub const __PTHREAD_RWLOCK_ELISION_EXTRA = @compileError("unable to translate C expr: unexpected token '{'"); // /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h:40:11
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
pub const __ONCE_FLAG_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h:113:9
pub const __have_pthread_attr_t = @as(c_int, 1);
pub const _BITS_SETJMP_H = @as(c_int, 1);
pub const ____sigset_t_defined = "";
pub const _SIGSET_NWORDS = __helpers.div(@as(c_int, 1024), @as(c_int, 8) * __helpers.sizeof(c_ulong));
pub const __jmp_buf_tag_defined = @as(c_int, 1);
pub const PTHREAD_STACK_MIN = @as(c_int, 16384);
pub const PTHREAD_MUTEX_INITIALIZER = @compileError("unable to translate C expr: unexpected token '{'"); // /usr/include/pthread.h:90:9
pub const PTHREAD_RWLOCK_INITIALIZER = @compileError("unable to translate C expr: unexpected token '{'"); // /usr/include/pthread.h:114:10
pub const PTHREAD_COND_INITIALIZER = @compileError("unable to translate C expr: unexpected token '{'"); // /usr/include/pthread.h:155:9
pub const PTHREAD_CANCELED = __helpers.cast(?*anyopaque, -@as(c_int, 1));
pub const PTHREAD_ONCE_INIT = @as(c_int, 0);
pub const PTHREAD_BARRIER_SERIAL_THREAD = -@as(c_int, 1);
pub const __cleanup_fct_attribute = "";
pub const pthread_cleanup_push = @compileError("unable to translate macro: undefined identifier `__cancel_buf`"); // /usr/include/pthread.h:681:10
pub const pthread_cleanup_pop = @compileError("unable to translate macro: undefined identifier `__cancel_buf`"); // /usr/include/pthread.h:702:10
pub inline fn __sigsetjmp_cancel(env: anytype, savemask: anytype) @TypeOf(__sigsetjmp(__helpers.cast([*c]struct___jmp_buf_tag, __helpers.cast(?*anyopaque, env)), savemask)) {
    _ = &env;
    _ = &savemask;
    return __sigsetjmp(__helpers.cast([*c]struct___jmp_buf_tag, __helpers.cast(?*anyopaque, env)), savemask);
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
    return __helpers.cast(__uint16_t, ((x >> @as(c_int, 8)) & @as(c_int, 0xff)) | ((x & @as(c_int, 0xff)) << @as(c_int, 8)));
}
pub inline fn __bswap_constant_32(x: anytype) @TypeOf(((((x & __helpers.promoteIntLiteral(c_uint, 0xff000000, .hex)) >> @as(c_int, 24)) | ((x & __helpers.promoteIntLiteral(c_uint, 0x00ff0000, .hex)) >> @as(c_int, 8))) | ((x & @as(c_uint, 0x0000ff00)) << @as(c_int, 8))) | ((x & @as(c_uint, 0x000000ff)) << @as(c_int, 24))) {
    _ = &x;
    return ((((x & __helpers.promoteIntLiteral(c_uint, 0xff000000, .hex)) >> @as(c_int, 24)) | ((x & __helpers.promoteIntLiteral(c_uint, 0x00ff0000, .hex)) >> @as(c_int, 8))) | ((x & @as(c_uint, 0x0000ff00)) << @as(c_int, 8))) | ((x & @as(c_uint, 0x000000ff)) << @as(c_int, 24));
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
pub const __FD_ZERO = @compileError("unable to translate macro: undefined identifier `__i`"); // /usr/include/x86_64-linux-gnu/bits/select.h:25:9
pub const __FD_SET = @compileError("unable to translate C expr: expected ')' instead got '|='"); // /usr/include/x86_64-linux-gnu/bits/select.h:32:9
pub const __FD_CLR = @compileError("unable to translate C expr: expected ')' instead got '&='"); // /usr/include/x86_64-linux-gnu/bits/select.h:34:9
pub inline fn __FD_ISSET(d: anytype, s: anytype) @TypeOf((__FDS_BITS(s)[@as(usize, @intCast(__FD_ELT(d)))] & __FD_MASK(d)) != @as(c_int, 0)) {
    _ = &d;
    _ = &s;
    return (__FDS_BITS(s)[@as(usize, @intCast(__FD_ELT(d)))] & __FD_MASK(d)) != @as(c_int, 0);
}
pub const __sigset_t_defined = @as(c_int, 1);
pub const __timeval_defined = @as(c_int, 1);
pub const __suseconds_t_defined = "";
pub const __NFDBITS = @as(c_int, 8) * __helpers.cast(c_int, __helpers.sizeof(__fd_mask));
pub inline fn __FD_ELT(d: anytype) @TypeOf(__helpers.div(d, __NFDBITS)) {
    _ = &d;
    return __helpers.div(d, __NFDBITS);
}
pub inline fn __FD_MASK(d: anytype) __fd_mask {
    _ = &d;
    return __helpers.cast(__fd_mask, @as(c_ulong, 1) << __helpers.rem(d, __NFDBITS));
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
pub const MDBX_AMALGAMATED_SOURCE = @as(c_int, 1);
pub inline fn __has_c_attribute_qualified(x: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &x;
    return @as(c_int, 0);
}
pub inline fn __has_cpp_attribute(x: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &x;
    return @as(c_int, 0);
}
pub inline fn __has_cpp_attribute_qualified(x: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &x;
    return @as(c_int, 0);
}
pub inline fn __has_C23_or_CXX_attribute(x: anytype) @TypeOf(__has_c_attribute_qualified(x)) {
    _ = &x;
    return __has_c_attribute_qualified(x);
}
pub const __has_exceptions_disabled = @compileError("unable to translate macro: undefined identifier `__has_feature`"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:241:9
pub const MDBX_PURE_FUNCTION = @compileError("unable to translate macro: undefined identifier `__pure__`"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:265:9
pub const MDBX_NOTHROW_PURE_FUNCTION = @compileError("unable to translate macro: undefined identifier `__pure__`"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:282:9
pub const MDBX_CONST_FUNCTION = @compileError("unable to translate C expr: unexpected token '__attribute__'"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:306:9
pub const MDBX_NOTHROW_CONST_FUNCTION = @compileError("unable to translate macro: undefined identifier `__nothrow__`"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:323:9
pub const MDBX_DEPRECATED = @compileError("unable to translate macro: undefined identifier `__deprecated__`"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:343:9
pub const MDBX_DEPRECATED_ENUM = MDBX_DEPRECATED;
pub const __dll_export = @compileError("unable to translate macro: undefined identifier `__visibility__`"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:374:9
pub const __dll_import = "";
pub const LIBMDBX_INLINE_API = @compileError("unable to translate C expr: unexpected token 'static'"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:404:9
pub const MDBX_STRINGIFY_HELPER = @compileError("unable to translate C expr: unexpected token ''"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:409:9
pub inline fn MDBX_STRINGIFY(x: anytype) @TypeOf(MDBX_STRINGIFY_HELPER(x)) {
    _ = &x;
    return MDBX_STRINGIFY_HELPER(x);
}
pub const @"bool" = bool;
pub const @"true" = @as(c_int, 1);
pub const @"false" = @as(c_int, 0);
pub const MDBX_CXX17_NOEXCEPT = "";
pub const MDBX_CXX01_CONSTEXPR = @compileError("unable to translate C expr: unexpected token '__inline'"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:441:9
pub const MDBX_CXX01_CONSTEXPR_VAR = @compileError("unable to translate C expr: unexpected token 'const'"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:442:9
pub const MDBX_CXX11_CONSTEXPR = @compileError("unable to translate C expr: unexpected token '__inline'"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:461:9
pub const MDBX_CXX11_CONSTEXPR_VAR = @compileError("unable to translate C expr: unexpected token 'const'"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:462:9
pub const MDBX_CXX14_CONSTEXPR = @compileError("unable to translate C expr: unexpected token '__inline'"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:480:9
pub const MDBX_CXX14_CONSTEXPR_VAR = @compileError("unable to translate C expr: unexpected token 'const'"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:481:9
pub const MDBX_NORETURN = @compileError("unable to translate macro: undefined identifier `__noreturn__`"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:501:9
pub const MDBX_PRINTF_ARGS = @compileError("unable to translate macro: undefined identifier `__format__`"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:513:9
pub const MDBX_MAYBE_UNUSED = @compileError("unable to translate macro: undefined identifier `__unused__`"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:526:9
pub const MDBX_NOSANITIZE_ENUM = @compileError("unable to translate macro: undefined identifier `__no_sanitize__`"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:532:9
pub inline fn DEFINE_ENUM_FLAG_OPERATORS(ENUM: anytype) void {
    _ = &ENUM;
    return;
}
pub const CONSTEXPR_ENUM_FLAGS_OPERATIONS = @as(c_int, 1);
pub inline fn MDBX_LIKELY(cond: anytype) @TypeOf(__builtin.expect(!!(cond != 0), @as(c_int, 1))) {
    _ = &cond;
    return __builtin.expect(!!(cond != 0), @as(c_int, 1));
}
pub inline fn MDBX_UNLIKELY(cond: anytype) @TypeOf(__builtin.expect(!!(cond != 0), @as(c_int, 0))) {
    _ = &cond;
    return __builtin.expect(!!(cond != 0), @as(c_int, 0));
}
pub const MDBX_INLINE_API_ASSERT = @compileError("unable to translate C expr: unexpected token 'do'"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:612:9
pub const MDBX_VERSION_UNSTABLE = "";
pub const MDBX_VERSION_MAJOR = @as(c_int, 0);
pub const MDBX_VERSION_MINOR = @as(c_int, 14);
pub const LIBMDBX_API = "";
pub const LIBMDBX_API_TYPE = "";
pub const LIBMDBX_VERINFO_API = __dll_export;
pub const MDBX_LOCKNAME = "/mdbx.lck";
pub const MDBX_DATANAME = "/mdbx.dat";
pub const MDBX_LOCK_SUFFIX = "-lck";
pub const MDBX_LOGGER_DONTCHANGE = __helpers.cast(MDBX_debug_func, __helpers.cast(isize, -@as(c_int, 1)));
pub const MDBX_LOGGER_NOFMT_DONTCHANGE = __helpers.cast(MDBX_debug_func_nofmt, __helpers.cast(isize, -@as(c_int, 1)));
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
pub const mdbx_txn_copy2pathnameT = @compileError("unable to translate macro: undefined identifier `path`"); // /home/sayan/Dev/Projects/lmdbx-zig/zig-pkg/N-V-__8AAD4_MQArgIek13Rf-VqoAvJup6onfaEQTJ4G0ix7/mdbx.h:2737:9
pub inline fn mdbx_env_get_pathT(env: anytype, dest: anytype) @TypeOf(mdbx_env_get_path(env, dest)) {
    _ = &env;
    _ = &dest;
    return mdbx_env_get_path(env, dest);
}
pub const MDBX_EPSILON = __helpers.cast([*c]MDBX_val, __helpers.cast(ptrdiff_t, -@as(c_int, 1)));
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
pub const MDBX_CHK_MAIN = __helpers.cast(?*anyopaque, __helpers.cast(ptrdiff_t, @as(c_int, 0)));
pub const MDBX_CHK_GC = __helpers.cast(?*anyopaque, __helpers.cast(ptrdiff_t, -@as(c_int, 1)));
pub const MDBX_CHK_META = __helpers.cast(?*anyopaque, __helpers.cast(ptrdiff_t, -@as(c_int, 2)));
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
pub const MDBX_cache_entry = struct_MDBX_cache_entry;
pub const MDBX_cache_status = enum_MDBX_cache_status;
pub const MDBX_cache_result = struct_MDBX_cache_result;
pub const MDBX_bunch_action = enum_MDBX_bunch_action;
pub const MDBX_chk_flags = enum_MDBX_chk_flags;
pub const MDBX_chk_severity = enum_MDBX_chk_severity;
pub const MDBX_chk_stage = enum_MDBX_chk_stage;
pub const MDBX_chk_issue = struct_MDBX_chk_issue;
pub const MDBX_chk_scope = struct_MDBX_chk_scope;
pub const MDBX_chk_histogram = struct_MDBX_chk_histogram;
pub const MDBX_chk_user_table_cookie = struct_MDBX_chk_user_table_cookie;
pub const MDBX_chk_table = struct_MDBX_chk_table;
pub const MDBX_chk_context = struct_MDBX_chk_context;
pub const MDBX_chk_line = struct_MDBX_chk_line;
pub const MDBX_chk_callbacks = struct_MDBX_chk_callbacks;
pub const MDBX_gc_info = struct_MDBX_gc_info;
pub const MDBX_defrag_stopping_reasons = enum_MDBX_defrag_stopping_reasons;
pub const MDBX_defrag_result = struct_MDBX_defrag_result;
