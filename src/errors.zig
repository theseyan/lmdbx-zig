const std = @import("std");
const c = @import("c.zig");

pub const Error = error{
    // MDBX specific errors
    MDBX_KEYEXIST,
    MDBX_NOTFOUND,
    MDBX_PAGE_NOTFOUND,
    MDBX_CORRUPTED,
    MDBX_PANIC,
    MDBX_VERSION_MISMATCH,
    MDBX_INVALID,
    MDBX_MAP_FULL,
    MDBX_DBS_FULL,
    MDBX_READERS_FULL,
    MDBX_TXN_FULL,
    MDBX_CURSOR_FULL,
    MDBX_PAGE_FULL,
    MDBX_UNABLE_EXTEND_MAPSIZE,
    MDBX_INCOMPATIBLE,
    MDBX_BAD_RSLOT,
    MDBX_BAD_TXN,
    MDBX_BAD_VALSIZE,
    MDBX_BAD_DBI,
    MDBX_PROBLEM,
    MDBX_BUSY,
    MDBX_EMULTIVAL,
    MDBX_EBADSIGN,
    MDBX_WANNA_RECOVERY,
    MDBX_EKEYMISMATCH,
    MDBX_TOO_LARGE,
    MDBX_THREAD_MISMATCH,
    MDBX_TXN_OVERLAPPING,
    MDBX_BACKLOG_DEPLETED,
    MDBX_DUPLICATED_CLK,
    MDBX_DANGLING_DBI,
    MDBX_OUSTED,
    MDBX_MVCC_RETARDED,
    MDBX_ENODATA,
    MDBX_ENOFILE,
    MDBX_EREMOTE,

    // System errors
    INVAL,
    ACCESS,
    NOMEM,
    ROFS,
    NOSYS,
    IO,
    PERM,
    INTR,
    DEADLK,

    // Unknown error
    MDBX_UNKNOWN_ERROR
};

pub fn throw(rc: c_int) Error!void {
    try switch (rc) {
        c.MDBX_SUCCESS, c.MDBX_RESULT_TRUE => {},
        
        c.MDBX_KEYEXIST => Error.MDBX_KEYEXIST,
        c.MDBX_NOTFOUND => Error.MDBX_NOTFOUND,
        c.MDBX_PAGE_NOTFOUND => Error.MDBX_PAGE_NOTFOUND,
        c.MDBX_CORRUPTED => Error.MDBX_CORRUPTED,
        c.MDBX_PANIC => Error.MDBX_PANIC,
        c.MDBX_VERSION_MISMATCH => Error.MDBX_VERSION_MISMATCH,
        c.MDBX_INVALID => Error.MDBX_INVALID,
        c.MDBX_MAP_FULL => Error.MDBX_MAP_FULL,
        c.MDBX_DBS_FULL => Error.MDBX_DBS_FULL,
        c.MDBX_READERS_FULL => Error.MDBX_READERS_FULL,
        c.MDBX_TXN_FULL => Error.MDBX_TXN_FULL,
        c.MDBX_CURSOR_FULL => Error.MDBX_CURSOR_FULL,
        c.MDBX_PAGE_FULL => Error.MDBX_PAGE_FULL,
        c.MDBX_UNABLE_EXTEND_MAPSIZE => Error.MDBX_UNABLE_EXTEND_MAPSIZE,
        c.MDBX_INCOMPATIBLE => Error.MDBX_INCOMPATIBLE,
        c.MDBX_BAD_RSLOT => Error.MDBX_BAD_RSLOT,
        c.MDBX_BAD_TXN => Error.MDBX_BAD_TXN,
        c.MDBX_BAD_VALSIZE => Error.MDBX_BAD_VALSIZE,
        c.MDBX_BAD_DBI => Error.MDBX_BAD_DBI,
        c.MDBX_PROBLEM => Error.MDBX_PROBLEM,
        c.MDBX_BUSY => Error.MDBX_BUSY,
        c.MDBX_EMULTIVAL => Error.MDBX_EMULTIVAL,
        c.MDBX_EBADSIGN => Error.MDBX_EBADSIGN,
        c.MDBX_WANNA_RECOVERY => Error.MDBX_WANNA_RECOVERY,
        c.MDBX_EKEYMISMATCH => Error.MDBX_EKEYMISMATCH,
        c.MDBX_TOO_LARGE => Error.MDBX_TOO_LARGE,
        c.MDBX_THREAD_MISMATCH => Error.MDBX_THREAD_MISMATCH,
        c.MDBX_TXN_OVERLAPPING => Error.MDBX_TXN_OVERLAPPING,
        c.MDBX_BACKLOG_DEPLETED => Error.MDBX_BACKLOG_DEPLETED,
        c.MDBX_DUPLICATED_CLK => Error.MDBX_DUPLICATED_CLK,
        c.MDBX_DANGLING_DBI => Error.MDBX_DANGLING_DBI,
        c.MDBX_OUSTED => Error.MDBX_OUSTED,
        c.MDBX_MVCC_RETARDED => Error.MDBX_MVCC_RETARDED,
        c.MDBX_ENODATA => Error.MDBX_ENODATA,
        c.MDBX_ENOFILE => Error.MDBX_ENOFILE,
        c.MDBX_EREMOTE => Error.MDBX_EREMOTE,

        c.MDBX_EINVAL => Error.INVAL,
        c.MDBX_EACCESS => Error.ACCESS,
        c.MDBX_ENOMEM => Error.NOMEM,
        c.MDBX_EROFS => Error.ROFS,
        c.MDBX_ENOSYS => Error.NOSYS,
        c.MDBX_EIO => Error.IO,
        c.MDBX_EPERM => Error.PERM,
        c.MDBX_EINTR => Error.INTR,
        c.MDBX_EDEADLK => Error.DEADLK,

        else => {
            std.debug.print("Received an unknown error code: {d}\n", .{rc});
            return Error.MDBX_UNKNOWN_ERROR;
        }
    };
}