const std = @import("std");
const mdbx = @import("lmdbx");

pub fn main() !void {
    std.debug.print("all ur base are belong to us\n", .{});

    var env: ?*mdbx.MDBX_env = undefined;

    // Allocate memory for env
    const envCreate = mdbx.mdbx_env_create(&env);
    
    if (envCreate == 0) {
        std.debug.print("env created\n", .{});
    } else {
        std.debug.print("failed to create env: error {d}\n", .{envCreate});
        return error.EnvCreateError;
    }

    // Open env
    const openEnv = mdbx.mdbx_env_open(env, "idk.db", mdbx.MDBX_LIFORECLAIM, 0o664);
    if (openEnv == 0) {
        std.debug.print("env opened\n", .{});
    } else {
        std.debug.print("failed opening env: error {d}\n", .{openEnv});
        return error.EnvOpenError;
    }

    // Create a transaction
    var txn: ?*mdbx.MDBX_txn = undefined;
    _ = mdbx.mdbx_txn_begin(env, null, 0, &txn);

    // Open new database handle
    var dbi: mdbx.MDBX_dbi = undefined;
    const dbiOpen = mdbx.mdbx_dbi_open(txn, null, mdbx.MDBX_DB_DEFAULTS, &dbi);
    if (dbiOpen == 0) {
        std.debug.print("Database handle opened\n", .{});
    } else {
        std.debug.print("Failed to open db handle: error {d}\n", .{dbiOpen});
        return error.DbiOpenError;
    }

    // Put key and value
    const key_val = "name";
    const val_val = "Sayan";
    var key = mdbx.MDBX_val{
        .iov_base = @ptrCast(@constCast(key_val)),
        .iov_len = key_val.len
    };
    var val = mdbx.MDBX_val{
        .iov_base = @ptrCast(@constCast(val_val)),
        .iov_len = val_val.len
    };

    const putRes = mdbx.mdbx_put(txn, dbi, &key, &val, 0);
    if (putRes != 0) {
        std.debug.print("failed to put key: error {d}\n", .{putRes});
        return error.PutError;
    }

    // Get the key
    var getKey = mdbx.MDBX_val{
        .iov_base = @ptrCast(@constCast("name")),
        .iov_len = "name".len
    };
    var getVal: mdbx.MDBX_val = undefined;

    const getRes = mdbx.mdbx_get(txn, dbi, &getKey, &getVal);
    if (getRes != 0) {
        std.debug.print("failed to get key: error {d}\n", .{getRes});
        return error.GetError;
    } else {
        const valPtr: [*]const u8 = @ptrCast(@alignCast(getVal.iov_base));
        const valSlice = valPtr[0..getVal.iov_len];
        std.debug.print("got value: {s}\n", .{valSlice});
    }

    // Close env
    switch(mdbx.mdbx_env_close(env)) {
        0 => {
            std.debug.print("env closed, bye\n", .{});
        },
        else => {
            std.debug.print("unknown error occurred while closing env\n", .{});
            return error.EnvCloseError;
        }
    }
}