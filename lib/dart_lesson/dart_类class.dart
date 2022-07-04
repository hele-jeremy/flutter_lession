import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

///Dart面向对象:封装 继承 多态
///类  接口
///成员变量 成员方法 构造方法 静态变量 静态常量 静态方法

class DartClasses extends StatelessWidget {
  const DartClasses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MaterialButton(
                onPressed: _dartClassTest,
                child: Text("Dart中的类",
                    style: Theme.of(context).textTheme.headline6))
          ]))
    ]);
  }

  void _dartClassTest() {
    var point = const Point<double>(2.22, 3.32);
    assert(point.x == 2.22);
    var distanceTo = point.distanceTo(const Point(0.0, 1.11));
    LogUtils.d("distanceTo : $distanceTo");

    var person = Person("hoko", "female");
    LogUtils.d(person);
  }
}

class Person {
  //静态常量
  static const count = 100;

  //静态变量
  static var country = "中国";

  //成员变量默认会生成一个隐式的getter方法，并且非final的成员变量也会生成隐式的setter方法
  //对于非空non-null类型的成员变量，有三种初始化方式:
  //  1.在定义的时候通过初始化语句初始化. 如: String name = "hello";
  //  2.将其标记为late
  //  3.通过构造函数进行初始化
  // String name = "hello";
  // final String sex = "male";
  // late String name;
  // late final String sex;
  String name;
  final String sex;

  int? age;
  late final double? height;

  //构造函数
  Person(this.name, this.sex);

  @override
  String toString() {
    return 'Person{name: $name, sex: $sex, age: $age, height: $height}';
  }
}
