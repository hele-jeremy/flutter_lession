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
    /**
     * map集合类型：
     */
  }
}
