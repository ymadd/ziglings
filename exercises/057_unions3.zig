//
// With tagged unions, it gets EVEN BETTER! If you don't have a
// need for a separate enum, you can define an inferred enum with
// your union all in one place. Just use the 'enum' keyword in
// place of the tag type:
//
//     const Foo = union(enum) {
//         small: u8,
//         medium: u32,
//         large: u64,
//     };
//
// Let's convert Insect. Doctor Zoraptera has already deleted the
// 明示的なinsectstat enum forあなたのために！
//
const std = @import("std");

const InsectStat = enum { flowers_visited, still_alive };

const Insect = union(InsectStat) {
    flowers_visited: u16,
    still_alive: bool,
};

pub fn main() void {
    var ant = Insect{ .still_alive = true };
    var bee = Insect{ .flowers_visited = 17 };

    std.debug.print("Insect report! ", .{});

    printInsect(ant);
    printInsect(bee);

    std.debug.print("\n", .{});
}

fn printInsect(insect: Insect) void {
    switch (insect) {
        .still_alive => |a| std.debug.print("Ant alive is: {}. ", .{a}),
        .flowers_visited => |f| std.debug.print("Bee visited {} flowers. ", .{f}),
    }
}

//推論された列挙体は氷山の先端を表すきちんとしている
//列挙体と労働組合の間の関係にあります。あなたは実際にもできます
// enumに和集合を支援する（これはあなたにアクティブなフィールドを与えます
// enumとしての組合から）。Wilderさえもあなたができることは何ですか
//組合への列挙体を強制！しかし、あまりにも興奮しないでください
//ユニオンタイプがそれらの奇妙なゼロビットの1つのものの1つの場合にのみ機能します
// voidのようなタイプ！
//
//コンピュータサイエンスでのほとんどのアイデアと同様に、統合をタグ付けしました。
// 1960年代に戻る長い歴史。しかし、彼らはのみです
//最近主流になる、特にシステムレベルで
// プログラミング言語。あなたも彼らが求められたことを見たかもしれません
//「バリアント」、「SUMタイプ」、さらには「enums」でも！
