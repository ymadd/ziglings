//
// You can also make pointers to multiple items without using a slice.
//
//     var foo: [4]u8 = [4]u8{ 1, 2, 3, 4 };
//     var foo_slice: []u8 = foo[0..];
//     var foo_ptr: [*]u8 = &foo;
//
// The difference between foo_slice and foo_ptr is that the slice has
// a known length. The pointer doesn't. It is up to YOU to keep track
// of the number of u8s foo_ptr points to!
//
const std = @import("std");

pub fn main() void {
    //私たちが強制しているアレイタイプをよく見てください
    // Zen12文字列（文字列の実質的な性質は
    //いくつかの追加機能を学んだときに明らかにされました）：
    const zen12: *const [21]u8 = "Memory is a resource.";
    //
    //   スライスに強制することも有効でした。
    //         const zen12: []const u8 = "...";
    //
    // Now let's turn this into a "many-item pointer":
    const zen_manyptr: *const [21]u8 = zen12;

    //配列やスライスのようにzen_manyptrにアクセスしても大丈夫です。
    //あなたが自分自身の長さを追跡し続ける限り長い！
    //
    // Zigの "String"はconst u8値の配列へのポインタです。
    //（または上記のように、Const U8値のスライス）。だから、私たちはできました
    // const u8の「多項目ポインタ」を文字列として扱います。
    //それをスライスに変換することができます。（ヒント：あそびは長長を捨てる！）
    //
    // Please fix this line so the print statement below can print it:
    const zen12_string: []const u8 = zen_manyptr;

    // Here's the moment of truth!
    std.debug.print("{s}\n", .{zen12_string});
}
//
// Are all of these pointer types starting to get confusing?
//
//     FREE ZIG POINTER CHEATSHEET! (Using u8 as the example type.)
//   +---------------+----------------------------------------------+
//   |  u8           |  one u8                                      |
//   |  *u8          |  pointer to one u8                           |
//   |  [2]u8        |  two u8s                                     |
//   |  [*]u8        |  pointer to unknown number of u8s            |
//   |  [*]const u8  |  pointer to unknown number of immutable u8s  |
//   |  *[2]u8       |  pointer to an array of 2 u8s                |
//   |  *const [2]u8 |  pointer to an immutable array of 2 u8s      |
//   |  []u8         |  slice of u8s                                |
//   |  []const u8   |  slice of immutable u8s                      |
//   +---------------+----------------------------------------------+
