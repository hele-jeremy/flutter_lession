import 'package:flutter/material.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

///dart中的运算符

class DartOperator extends StatelessWidget {
  const DartOperator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dart中的操作符和流程控制语句"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              MaterialButton(
                  onPressed: _dartOperator,
                  child: Text("Dart中的运算符",
                      style: Theme.of(context).textTheme.headline6))
            ])),
        Container(
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              MaterialButton(
                  onPressed: _dartFlowControl,
                  child: Text("流程控制语句",
                      style: Theme.of(context).textTheme.headline6))
            ]))
      ]),
    );
  }

  void _dartOperator() {
    /*
    Dart中的运算符和常见的面向对象语言java kotlin很多都类似，我们只列出一些dart特有的一些运算操作符
     */

    // ~/ 除并取整 不是四舍五入的规则，相当于向下取整
    assert(5 ~/ 4 == 1);
    assert(5 ~/ 2 == 2);
    assert(10 ~/ 3 == 3);
    assert(20 ~/ 3 == 6);

    //判断连个对象是否相同可以使用  == 或者 identical()
    var key1 = const Key("key1");
    var key2 = const Key("key2");
    LogUtils.d("key1 == key2 : ${key1 == key2}");
    LogUtils.d("identical(key1,key2) : ${identical(key1, key2)}");

    var testObj1 = TestObjO()..text = "text1";
    var testObj2 = TestObjO()..text = "text2";

    LogUtils.d("testObj1 == testObj2 : ${testObj1 == testObj2}");
    LogUtils.d(
        "identical(testObj1,testObj2) : ${identical(testObj1, testObj2)}");
    assert("a" == "a");
    assert(identical("a", "a"));

    //类型判断操作符 as is is!
    Object to = TestObjO();
    var to2 = to as TestObjO;
    assert(to is TestObjO);
    assert(TestObjO() is! Key);
    assert(null is! Object); //Null不是Object的子类

    // = 和 ??= 赋值运算符
    var a = 100;
    a = 200;
    var b = 100;
    b = 300;
    // String? c = null; //Dart中不要显式的给一个变量赋值null  //https://dart-lang.github.io/linter/lints/avoid_init_to_null.html
    String? c; //nullable可空类型有默认值null，non-null非空类型在使用它之前必须要赋予一个值
    String? c2;
    c2 = "hello";
    String? c3;
    c3 ??= "flutter"; //相当于 if(c3 == null) {c3 = "flutter"} else {c3}
    // String c4;
    // c4 ??= "dart";  //The non-nullable local variable 'c4' must be assigned before it can be used.

    String? c4;
    c4 = "widget"; //可空类型的c4执行这条语句以后已经变成了,String类型的了
    // c4 ??= "state"; //再执行这条语句运行会提示: Warning: Operand of null-aware operation '??=' has type 'String' which excludes null.
    assert(a == 200);
    assert(b == 300);
    assert(c == null);
    assert(c2 == "hello");
    assert(c3 == "flutter");
    assert(c4 == "widget");

    //条件表达式
    var a1 = 5, b1 = 30;
    int result;
    if (a1 > b1) {
      result = a1;
    } else {
      result = b1;
    }
    LogUtils.d("result = $result");
    LogUtils.d("a1 > b1 ? a1 : b1 : ${a1 > b1 ? a1 : b1}");

    //表达式1 ?? 表达式2   如果表达式1的值为非null,则返回表达式1的值，否则执行表达式2并返回其值
    String? str1;
    String? str2 = "hello";
    LogUtils.d("str1 ?? \"mock\" ${str1 ?? "mock"}");
    // LogUtils.d("str2 ?? \"mock\" ${str2 ?? "mock"}");

    //级联运算符..  ?..  可以让我们在一个对象上连续多次调用该对象的方法和变量
    var tobj = TestObjO()
      ..text = "hello"
      ..count = 43.32;
    assert(tobj.text == "hello");
    LogUtils.d(tobj);
    //如果使用级联操作的对象可能为空null,那么可以在第一次使用级联操作的地方使用null-shorting，空级联操作符
    //保证后续的级联操作不会在一个空null对象上展开
    var testObjO = TestObjO.mock()
      ?..text = "flutter"
      ..classes.add(100)
      ..classes.where((element) => element % 2 == 0)
      ..foo()
      .._xoo();
    LogUtils.d(testObjO.toString());

    //级联操作符是可以嵌套操作的
    final addressBook = (AddressBookBuilder()
          ..name = "flutter first"
          ..email = "190610420@qq.com"
          ..phone = (PhoneNameBuilder()
                ..number = "13528459546"
                ..label = "office")
              .build())
        .build();
    LogUtils.d(addressBook);

    //错误使用级联操作符的例子
    var sb = StringBuffer();
    // sb.write("foo") //write方法的返回的是void，因此对void执行级联操作，调用其write方法是错误的，因为void根本没有write方法
    //   ..write("bar");

    //集合的安全操作符?[
    List list1 = [
      for (int i = 0; i < 5; i++) {i + 1}
    ];
    List? list3;
    LogUtils.d("list1[2] = ${list1[2]}");
    LogUtils.d(
        "list3?[2] = ${list3?[2]}"); // 相当于 if(list3 == null) {null} else {list3[2]}

    //条件成员访问符/空安全调用操作符 ?.
    var mock = TestObjO.mock();
    LogUtils.d(
        "mock?.text = ${mock?.text}"); //相当于 if(mock == null){null} else {mock.text}

    //非空断言操作符 !
    var mock2 = TestObjO.mock();
    //mock方法返回的是一个null的空对象，mock2! 相当于 if(mock2 != null) {mock2.text) else{throw NullPointerException()}
    LogUtils.d(
        "mock2.text = ${mock2!.text}"); //Null check operator used on a null value
  }

  void _dartFlowControl() {
    //流程控制语句
    //if..else...
    //for循环
    //标准for循环
    var stringBuffer = StringBuffer("dart is fun");
    for (int i = 0; i < 5; i++) {
      stringBuffer.write("!");
    }
    LogUtils.d(stringBuffer);

    //Dart中,for循环中的闭包(closure)会自动捕获循环的索引值,这个和javascript中是很不一样的
    var callbacks = [];
    for (int i = 0; i < 2; i++) {
      callbacks.add(() => LogUtils.d("i = $i"));
    }
    // callbacks.forEach((element) => element.call());
    callbacks.forEach((element) => element());

    //对一个一个可迭代(Iteratorable)的对象，可以使用for-in遍历,但是获取不到index索引值
    var kps = <String, int>{for (int i1 = 0; i1 < 5; i1++) "hoko = $i1": i1};
    LogUtils.d("kps : $kps}");
    for (final kp in kps.entries) {
      LogUtils.d("kp : ${kp.key} = ${kp.value}");
    }

    //while  do..while 循环
    //break continue

    var lists = List.generate(10, (index) => index);
    for (int i = 0; i < lists.length; i++) {
      int value = lists[i];
      if (value < 5) continue;
      LogUtils.d("value is $value");
    }

    //对于以上使用continue的操作,可以使用以下流式api来完成
    lists
        .where((element) => element >= 5)
        .forEach((element) => LogUtils.d("stream value = $element"));

    //switch..case..
    var ss = SwitchState.pending;
    switch (ss) {
      case SwitchState.open:
        LogUtils.d("state : open");
        var aa = 11; //每个case字句都可以有局部变量，并且仅在该case字句内可见
        break;
      case SwitchState.pending:
        LogUtils.d("state : pending");
        var aa = 22;
        continue approved; //可以通过continue + label的方式实现case穿透的能力

      approved:
      case SwitchState.approved:
        var aa = 33;
        LogUtils.d("state : approved");
        break;
      //dart中也可以执行case穿透
      case SwitchState.denied:
      case SwitchState.closed:
        LogUtils.d("state : denied-closed");
        break;
      default: //都不满足条件就执行default语句
        LogUtils.d("state : default");
    }

    //assert 断言 :
    //flutter调试模式情况下断言生效，在生产环境代码中断言会被忽略
    //同时断言是否生效也依赖开发的工具和以来的框架
    var value = 100;
    assert(value > 100, "value shoule more than 100!!");
  }
}

enum SwitchState {
  open,
  pending,
  approved,
  denied,
  closed;
}

class TestObjO {
  String text = "";
  double count = 3.22;
  final classes = List.generate(5, (index) => index * index);

  void foo() {}

  void _xoo() {}

  static TestObjO? mock() {
    return null;
    // return TestObjO();
  }

  @override
  String toString() {
    return 'TestObjO{text: $text, count: $count, classes: $classes}';
  }
}

class AddressBookBuilder {
  late String name;
  late String email;
  late PhoneNameBuilder phone;

  AddressBookBuilder build() {
    return this;
  }

  @override
  String toString() {
    return 'AddressBookBuilder{name: $name, email: $email, phone: $phone}';
  }
}

class PhoneNameBuilder {
  late String number;
  late String label;

  PhoneNameBuilder build() {
    return this;
  }

  @override
  String toString() {
    return 'PhoneNameBuilder{number: $number, label: $label}';
  }
}
