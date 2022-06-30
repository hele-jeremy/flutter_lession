import 'package:flutter/material.dart';

import '../utils/log_utils.dart';

///Dart内建数据类型
class DartBuiltInTypes extends StatelessWidget {
  const DartBuiltInTypes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          MaterialButton(
              onPressed: _numType,
              child:
                  Text("num数字类型", style: Theme.of(context).textTheme.headline6))
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          MaterialButton(
              onPressed: _stringType,
              child: Text("String字符串类型",
                  style: Theme.of(context).textTheme.headline6))
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          MaterialButton(
              onPressed: _boolType,
              child:
                  Text("bool类型", style: Theme.of(context).textTheme.headline6))
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          MaterialButton(
              onPressed: _listType,
              child: Text("List集合类型",
                  style: Theme.of(context).textTheme.headline6))
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          MaterialButton(
              onPressed: _mapType,
              child:
                  Text("Map集合类型", style: Theme.of(context).textTheme.headline6))
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          MaterialButton(
              onPressed: _varObjectDynamic,
              child: Text("var Object dynamic三者的区别",
                  style: Theme.of(context).textTheme.headline6))
        ])
      ],
    );
  }

  void _numType() {
    /**
     * Num数字类型: num int double
     * 相比与Java,dart中一切皆对象,数字类型都是对象类型和kotlin中的数字类型一样，可以直接进行对方方法操作,其不同于Java中的数字类型的拆装箱操作(如:int -> Integer)
     */
    //num数字类型既可以定义int类型也可以定义double类型
    num num1 = 2;
    num num2 = 3.1415926;
    //int 整数类型
    int i = 22;
    //double 浮点数类型
    double d = 44.242;
    LogUtils.d("num1 = $num1,num2 = $num2,i = $i,d = $d");
  }

  void _stringType() {
    /**
     * String类型:
     */
    //dart中定义String字符串既可以单引号也可以双引号
    String str1 = "hello", str2 = "你好";
    String str3 = 'str1 = $str1 str2 = $str2';
    LogUtils.d("str1 = $str1\nstr2 = $str2\nstr3 = $str3");
    String str4 = "dart中的字符串String类型";
    //字符串操作常用方法
    LogUtils.d(
        "str4.substring(0,str4.length - 1) = ${str4.substring(0, str4.length - 1)}"); //字符串截取[start,end) 包左不包右
    LogUtils.d("str1.toUpperCase() = ${str1.toUpperCase()}"); //大小写转换
    LogUtils.d(
        'str4.indexOf("r",1) = ${str4.indexOf("r", 1)}'); //从指定位置开始，查找指定字符串第一次出现的索引
    LogUtils.d("str4.indexOf(\"r\",2) = ${str4.indexOf("r", 2)}");
    LogUtils.d('str4.indexOf("r",3) = ${str4.indexOf("r", 3)}');
    LogUtils.d(
        'str4.startsWith("art") = ${str4.startsWith("art")}'); //是否以指定的字符串开头
    LogUtils.d(
        'str4.startsWith("art",1) = ${str4.startsWith("art", 1)}'); //指定位置开始是否以指定字符串开始
    LogUtils.d('str4.startsWith("r") = ${str4.startsWith("r")}');
    LogUtils.d("str4.startsWith(\"r\",11) = ${str4.startsWith("r", 11)}");

    LogUtils.d(
        'str4.replaceAll("r", "替换元素") = ${str4.replaceAll("r", "替换元素")}'); //替换字符串中的指定元素，并生成返回一个新的字符串
    LogUtils.d('str4.contains("r") = ${str4.contains("r")}'); //是否包含指定的字符串
    LogUtils.d(
        'str4.contains("r",12) = ${str4.contains("r", 12)}'); //从指定位置开始，是否包含指定的字符串

    //字符串切割
    List<String> split = str4.split("r");
    LogUtils.d("split : ${split.toString()}");

    var iterator = split.iterator;
    while (iterator.moveNext()) {
      LogUtils.d(
          "iterator.runtimeType = ${iterator.runtimeType} iterator.current = ${iterator.current}");
    }

    _foreEachPrintFunc(String str) {
      LogUtils.d(
          "split forEach runtimeType : ${str.runtimeType} current : ${str.toString()}");
    }

    split.forEach(_foreEachPrintFunc);

    for (var value in split) {
      LogUtils.d(
          "split for runtimeType : ${value.runtimeType} current : ${value.toString()}");
    }
  }

  void _boolType() {
    /**
     * bool类型:true false
     */

    bool b1 = true;
    bool b2 = false;
    LogUtils.d("b1 = $b1 b2 = $b2");
    LogUtils.d("b1 | b2 = ${b1 | b2}");
    LogUtils.d("b1 || b2 = ${b1 || b2}");
    LogUtils.d("b1 & b2 = ${b1 & b2}");
    LogUtils.d("b1 && b2 = ${b1 && b2}");
    LogUtils.d("!b1 = ${!b1} !b2 = ${!b2}");
  }

  void _listType() {
    printList(String tag, List list) {
      for (var value in list) {
        LogUtils.d(
            "$tag printList value : $value runtimetype : ${value.runtimeType}");
      }
    }

    /**
     * 集合类型List:
     */
    //没有范型类型的列表集合可以存储任意类型的数据 null也是一个对象 是Null类的一个实例
    List list = [1, 2, 3, "hello", "flutter", null];
    // List<Object?> list = [1, 2, 3, "hello", "flutter", null];
    // List<dynamic> list = [1, 2, 3, "hello", "flutter", null];
    printList("list", list);
    //通过泛型创建一个元素类型为int类型的list集合
    List<int> list2 = [];
    //type 'List<dynamic>' is not a subtype of type 'List<int>' in type cast
    //type 'List<Object?>' is not a subtype of type 'List<int>' in type cast
    // list2 = list as List<int>;

    List list3 = [];
    list3.add(true);
    list3.addAll(list);
    printList("list3", list3);

    var list4 = List<int>.generate(5, (index) => index * 2);
    var list5 = List<int>.generate(5, (index) => index + 1,
        growable: false); //growabale为false,集合长度固定不可增删操作
    list4.add(100);
    // list5.add(32);Unsupported operation: Cannot add to a fixed-length list
    // list5.replaceRange(0, 2, [1]); //Unsupported operation: Cannot remove from a fixed-length list
    printList("list4", list4);
    printList("list5", list5);

    //list集合遍历
    for (var value in list4) {
      LogUtils.d("for in value $value runtimeType : ${value.runtimeType}");
    }

    for (int i = 0; i < list4.length; i++) {
      LogUtils.d(
          "for index  : $i value : ${list4[i]} runtimeType : ${list4[i].runtimeType}");
    }

    void forEachFunc(int element) {
      LogUtils.d(
          "forEachFunc value : $element runtimeType : ${element.runtimeType}");
    }

    list4.forEach(forEachFunc);

    var iterator = list4.iterator;
    while (iterator.moveNext()) {
      LogUtils.d(
          "iterator value : ${iterator.current} runtimeType : ${iterator.current.runtimeType}");
    }

    List list6 = [
      true,
      "dart",
      100,
      2.22,
      ["flutter", "javascript", "hibernate"]
    ];

    LogUtils.d("list6.reversed : ${list6.reversed}\nlist6 : $list6");
    LogUtils.d("list6.remove(true) : ${list6.remove(true)} list6 : $list6");
    list6.insert(2, "insert");
    LogUtils.d(" list6.insert(2, \"insert\") : $list6");
    //集合索引超标，list集合中包含一个list集合，会当作一个元素处理
    // var sublist = list6.sublist(5,6); //RangeError (end): Invalid value: Only valid value is 5: 6
    var sublist = list6.sublist(2, list6.length);
    LogUtils.d("list6 : $list6 sublist : $sublist");
    //集合的一些常用操作符
    var list7 = List<int>.generate(10, (index) => index + 1);
    LogUtils.d("before list7 : $list7");
    list7.removeWhere((element) {
      LogUtils.d("removeWhere : $element");
      return element.isEven;
    });
    LogUtils.d("after list7 : $list7");

    var indexWhere = list7.indexWhere((element) {
      LogUtils.d("indexWhere : $element");
      return element.isOdd;
    });

    LogUtils.d("after indexWhere : $indexWhere");

    list7.insert(3, 10);
    LogUtils.d("list7.insert : $list7");
    LogUtils.d("list7 indexWhere2 : ${list7.indexWhere((element) {
      LogUtils.d("list7 indexWhere2 each : $element");
      return element.isOdd;
    })}");
  }

  void _mapType() {
    void printMap(String tags, Map map) {
      var mapEntryList = map.entries.toList(growable: false);
      LogUtils.d("map runtimeType : ${map.runtimeType}");
      for (int i = 0; i < mapEntryList.length; i++) {
        var entry = mapEntryList[i];
        LogUtils.d(
            "$tags entryName : ${entry.key} entryValue : ${entry.value}");
      }
    }

    /**
     * map集合类型：
     */
    //没有指定泛型的map集合，可以存储任意类型的key-value数据
    Map names = {
      "hoko": "何乐",
      "xiaoming": "小明",
      "kobe": "科比",
      "status": false,
      true: 100,
      1.11: null
    }; //_InternalLinkedHashMap<dynamic, dynamic>
    printMap("names", names);

    //通过泛型来指定Map集合的key-value类型
    Map<String, int> ages = {};
    ages["hoko"] = 22;
    ages["kobe"] = 33;
    ages["yaoming"] = 39;
    printMap("ages", ages);

    //map的遍历
    ages.forEach((key, value) {
      LogUtils.d("ages forEach: key = $key value = $value");
    });

    for (final entry in ages.entries) {
      LogUtils.d(
          "age fori: key = ${entry.key} value = ${entry.value} runtimeType = ${entry.runtimeType}");
    }

    LogUtils.d("ages.keys : ${ages.keys} ages.values : ${ages.values}");
    LogUtils.d(
        "ages.keys.runtimeType : ${ages.keys.runtimeType} ags.values.runtimeType : ${ages.values.runtimeType}");
    //查找[key]的值，如果不存在，调用[ifAbsent]来获取一个新值，关联到[key]，并返回新值，如果有，则返回与[key]相关联的值。
    var putFLutter = ages.putIfAbsent("flutter", () => 4);
    //map中的key是唯一的,添加相同的key-value,会用新的value替换旧的value
    var putKotlin = ages["kotlin"] = 8;
    LogUtils.d("putKotlin = $putKotlin");
    var putKotlin2 = ages["kotlin"] = 11;
    LogUtils.d("putKotlin2 = $putKotlin2");
    LogUtils.d("putFlutter : $putFLutter");
    printMap("putFlutterAges", ages);
    var putHoko = ages.putIfAbsent("hoko", () => 99);
    LogUtils.d("putHoko : $putHoko");
    printMap("putHokoMap", ages);

    //map的一些流式转换操作
    var ageReverse = ages
        .map((key, value) => MapEntry(value, key)); //key - value -> value -key
    var putDart = ageReverse.putIfAbsent(5, () => "Dart");

    LogUtils.d("putDart : $putDart");
    printMap("putDartMap", ageReverse);
  }

  void _varObjectDynamic() {
    /**
     * dart中var Object dynamic三者的区别:
     */
    var var1 = "hello"; //Dart为强类型语言,通过var定义变量，编译器会进行自动类型推断,var1的类型为定义时赋的初始值的类型
    // var1 = 1; //A value of type 'int' can't be assigned to a variable of type 'String'.

    var var2; //var定义的变量初始化的时候，没有赋初始值的情况下后续可以赋予任何类型的值
    var2 = "hello";
    var2 = 999;
    var2 = false;
    LogUtils.d(
        "var1 = $var1 var1.runtimeType = ${var1.runtimeType}\nvar2 = $var2 var2.runtimeType = ${var2.runtimeType}");

    //The base class for all Dart objects except `null`.
    //Dart中Object是所有类的基类,除了Null这种类型以外
    Object obj;
    obj = "flutter Object";
    obj = 2.22;
    Object obj2 = "hello dart";
    obj2 = 10;
    obj2 = [
      1,
      "2",
      false,
      {"hoko": 22}
    ];
    LogUtils.d(
        "obj = $obj obj.runtimeType :${obj.runtimeType} obj2 = $obj2 obj2.runtimeType = ${obj2.runtimeType}");
    //Object类型的在编译期间就会做类型检查，因为obj没有toInt方法因此编译期间就会报错
    // obj.toInt();//The method 'toInt' isn't defined for the type 'Object'.
    LogUtils.d(obj2
        .toString()); //toString()方法是Object类的方法因此编译可以通过,Object类型的对象只能够调用Object自身的方法,例如toString() hashCode()这些方法

    //通过dynamic来定义变量
    dynamic d1, d2 = "hello";
    d1 = "dart";
    d1 = 22;
    d2 = true;
    d2 = {"hoko": 22, "kobe": 36, 22: "jeremy"};

    LogUtils.d(
        "d1 = $d1 d1.runtimeType : ${d1.runtimeType}\nd2 = $d2 d2.runtimeType : ${d2.runtimeType}");

    var doubleD1 = d1.toDouble();
    d2["android"] = 10;
    //dynamic类型的变量不会在编译期做类型检查，因此导致dynamic类型的变量可以调用任意类型的方法,如果调用的方法或使用的变量不属于该对象的话就会在
    //运行期报错,通常情况下不推荐直接使用dynamic这种类型
    //https://dart-lang.github.io/linter/lints/prefer_typing_uninitialized_variables.html
    //对于未初始化的变量，放弃类型注释是一种糟糕的实践，因为您可能会意外地将它们赋值给您最初不打算赋值的类型。
    // d2.add(22);  //Class '_InternalLinkedHashMap<Object, Object>' has no instance method 'add'.
    LogUtils.d("doubleD1 = $doubleD1");
    LogUtils.d(
        "d1 = $d1 d1.runtimeType : ${d1.runtimeType}\nd2 = $d2 d2.runtimeType : ${d2.runtimeType}");


    //一般使用var定义变量,建议对该变量赋初始值,对于没有赋初始值的变量，建议直接显式的声明该变量的类型
    /*
        class GoodClass {
         static var bar = 7;
         var foo = 42;
         int baz; // OK

         void method() {
          int baz;
          var bar = 5;
          ...
        }
       }
     */

    ///dynamic、var、Object三者的区别
    ///dynamic：是所有Dart对象的基础类型，在大多数情况下，通常不直接使用它，
    ///通过它定义的变量会关闭类型检查，这意味着 dynamic x = 'hal';x.foo();
    ///这段代码静态类型检查不会报错，但是运行时会crash，因为x并没有foo()方法，所以建议大家在编程时不要直接使用dynamic；
    ///var：是一个关键字，意思是“我不关心这里的类型是什么。”，系统会自动推断类型runtimeType；
    ///Object：是Dart对象的基类，当你定义：Object o=xxx；时这时候系统会认为o是个对象，你可以调用o的toString()和hashCode()方法
    ///因为Object提供了这些方法，但是如果你尝试调用o.foo()时，静态类型检查会进行报错；
    ///综上不难看出dynamic与Object的最大的区别是在静态类型检查上；
    /// var 初始化确定类型后不可更改类型， Object 以及dynamic 可以更改类型
    /// Object编译阶段检查类型, 而dynamic编译阶段不检查类型
  }
}
