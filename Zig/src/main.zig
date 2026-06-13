const std = @import("std");

const DDSK = 0b0111_0111_0111;
const MASK = 0b1111_1111_1111;

const ddsk = [_][]const u8{ "ドド", "スコ" };

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    var writer = std.Io.File.stdout().writer(io, &.{});
    const stdout = &writer.interface;
    const now = std.Io.Timestamp.now(io, .real);
    var rng: std.Random.DefaultPrng = .init(@bitCast(now.toMilliseconds()));
    const rand = rng.random();

    var buffer: usize = 0;
    while (buffer != DDSK) {
        const index = rand.uintLessThan(usize, ddsk.len);
        try stdout.writeAll(ddsk[index]);
        buffer = (buffer << 1) & MASK | index;
    }
    try stdout.writeAll("ラブ注入♡\n");
    try stdout.flush();
}
