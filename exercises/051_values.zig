//
//最後の運動が深いダイブだと思ったら、
//コンピュータの溶融に降りようとしているので帽子
// 芯。
//
//（Shouting）ここでは、BITSとバイトがRAMからCPUに流れます
//熱い密な液体のように。力は素晴らしいです。しかし、どうやって
//これはすべてZigプログラムのデータに関連していますか？頭を見てみましょう
//テキストエディタにバックアップして調べます。
//
//ああ、それは良いです。今、私たちはいくつかのおなじみのジグコードを見ることができます。
//
// @import（）インポートされたコードをあなた自身で追加します。この場合、コード
//標準ライブラリからプログラムに追加され、コンパイルされています
// それと。これはすべて実行されたときにRAMにロードされます。ああ、そして
//「const std」という名前のもの？それは構造体です！
//
const std = @import("std");

//私たちの古いRPG文字構造を覚えていますか？構造体は本当に単なるAです
//メモリに対処するための非常に便利な方法。これらの分野（金、
//健康、経験）はすべて特定のサイズの値です。それらを追加してください
//一緒に、あなたは全体として構造体のサイズを持っています。

const Character = struct {
    gold: u32 = 0,
    health: u8 = 100,
    experience: u32 = 0,
};

//ここでは、定数である "the_narrator"という文字を作成します
//キャラクタ構造の（不変）インスタンス。それはあなたのものに保存されています
//データとしてプログラムされ、命令コードのようにロードされています
//プログラムが実行されたときにRAM。このデータの相対位置
//メモリはハードコーディングされていて、アドレスも値も変化しません。

const the_narrator = Character{
    .gold = 12,
    .health = 99,
    .experience = 9000,
};

//この "global_wizard"文字は非常に似ています。アドレスfor.
//このデータは変更されませんが、これはvarであるため、データ自体はできます。
// constではありません。

var global_wizard = Character{};

// A function is instruction code at a particular address. Function
// parameters in Zig are always immutable. They are stored in "the
// stack". A stack is a type of data structure and "the stack" is a
// specific bit of RAM reserved for your program. The CPU has special
// support for adding and removing things from "the stack", so it is
// an extremely efficient place for memory storage.
//
// Also, when a function executes, the input arguments are often
// loaded into the beating heart of the CPU itself in registers.
//
// Our main() function here has no input parameters, but it will have
// a stack entry (called a "frame").

pub fn main() void {

    //ここで、「glorp」文字はスタックに割り当てられます
    // glorpの各インスタンスが変わること、したがってユニークな
    //この機能の呼び出しに。

    var glorp = Character{
        .gold = 30,
    };

    // "redward_xp"値は興味深いです。不公平です
    // value、それでもローカルであってもグローバルに入れることができます
    //すべての呼び出し間でデータと共有されます。しかし、そのようなものであること
    //小さい値、それは単にリテラルとしてインライン化されるかもしれません
    //命令コードで使用されている場所に値。それは上昇しています
    //コンパイラに。

    const reward_xp: u32 = 200;

    //輸入した「STD」の構造体への周りを囲みましょう
    // 頂点で。それが一度だけ定期的なZig値であるので
    //インポートされた、そのフィールドに新しい名前を割り当てることもできます。
    //宣言「デバッグ」とは別の構造体を指し、「印刷」は
    //その構造内のパブリック関数名前空間。
    //
    // std.debug.print関数を名前付きのconstに割り当てましょう。
    //「印刷」して、後でこの新しい名前を使用できるように！

    const print = std.debug.print;

    // Now let's look at assigning and pointing to values in Zig.
    //
    // We'll try three different ways of making a new name to access
    // our glorp Character and change one of its values.
    //
    // "glorp_access1" is incorrectly named! We asked Zig to set aside
    // memory for another Character struct. So when we assign glorp to
    // glorp_access1 here, we're actually assigning all of the fields
    // to make a copy! Now we have two separate characters.
    //
    // You don't need to fix this. But notice what gets printed in
    // your program's output for this one compared to the other two
    // assignments below!

    var glorp_access1: Character = glorp;
    glorp_access1.gold = 111;
    print("1:{}!. ", .{glorp.gold == glorp_access1.gold});

    // ノート：
    //
    //私たちがこれをしようとしたら
    // var、ゴールドフィールドを変更するとコンパイラエラーが発生します
    // const値は不変であるため！
    //
    // "glorp_access2"が欲しいものをします。それはオリジナルを指します
    // Glorpのアドレス。また暗黙のうちに入手することを忘れないでください
    // Structフィールドとの間接参照なので、「ゴールド」フィールドにアクセスする
    // glorp_access2からのアクセスはGlorpからアクセスするように見えます
    //それ自体

    var glorp_access2: *Character = &glorp;
    glorp_access2.gold = 222;
    print("2:{}!. ", .{glorp.gold == glorp_access2.gold});

    // "glorp_access3"は面白いです。それはポインターですが、それは
    // const。それはゴールド値を変更しませんか？番号！あなたのように
    //私たちの以前のポインター実験、定数から思い出すことができます
    //ポインタはそれが指しているものを変えることはできませんが、
    //それが指すアドレスはまだ変わっています！だからそれを変えることができます。

    const glorp_access3: *Character = &glorp;
    glorp_access3.gold = 333;
    print("3:{}!. ", .{glorp.gold == glorp_access3.gold});

    // ノート：
    //
    //これを* const文字ポインタで行おうとしたら、
    //それはうまくいかないため、コンパイラエラーが発生します
    //値が不変になるため！
    //
    //中を移動する...
    //
    //関数への引数を渡すことはほとんど同じです
    // constに割り当てをする（ジグがすべてを執行するため、
    //関数パラメータはconstです。
    //
    //これを知って、あなたが期待どおりに働くことができるかどうかを確認してください -
    //指定された金額を付属の文字のものに追加する必要があります。
    //ポイントを経験します。
    //
    print("XP before:{}, ", .{glorp.experience});

    // Fix 1 of 2 goes here:
    levelUp(&glorp, reward_xp);

    print("after:{}.\n", .{glorp.experience});
}

// Fix 2 of 2 goes here:
fn levelUp(character_access: *Character, xp: u32) void {
    character_access.experience += xp;
}

//もっともっとあります！
//
//データセグメント（コンパイル時に割り当て）と「スタック」
// //（実行時に割り当てられている）プログラムデータの唯一の場所ではありません
//メモリに保存できます。彼らはただ最も効率的です。ときどき
//私たちのプログラムがどのくらいのメモリが必要になるかわからない
//プログラムが実行されています。また、スタックのサイズには制限があります
//プログラムに割り当てられたメモリ（オペレーティングシステムによって設定されたことが多い）。
//これらの機会は「ヒープ」を持っています。
//
//あなたは好きなだけ多くのヒープメモリを使用できます（物理内）
//制限事項は、もちろん管理できません。
//を追加して削除するための組み込みのCPUサポートがないため
//スタックと一緒に持っているものです。また、の種類に応じて
//割り当て、あなたのプログラムは管理するために高価な仕事をする必要があるかもしれません
//ヒープメモリの使用。後でヒープアロケータについて学びます。
//
//さや！これは多くの情報でした。あなたは知っていることを嬉しく思います
//次の運動が私たちを学ぶZig言語に戻ってきたこと
//特徴私たちはもっと多くのことをするために使うことができます！
