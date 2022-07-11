import 'package:flutter/material.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

///枚举 enum

class DartEnums extends StatelessWidget {
  const DartEnums({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MaterialButton(
                onPressed: _eunuTest,
                child: Text("枚举Enum",
                    style: Theme.of(context).textTheme.headline6))
          ]))
    ]);
  }

  void _eunuTest() {
    ///想静态变量一样的访问枚举
    int type;
    var ve = Vehicle.bicycle;
    switch (ve) {
      case Vehicle.car:
        type = 0;
        break;
      case Vehicle.bus:
        type = 1;
        break;
      case Vehicle.bicycle:
        type = 2;
        break;
    }

    LogUtils.d("type = $type");

    ///枚举的遍历
    for (var element in Vehicle.values) {
      LogUtils.d("${element.index} - ${element.name}");
    }

    for (var element in LogPriority.values) {
      LogUtils.d(element.toString());
    }
  }
}

///通过enum来定义一个枚举
enum Vehicle implements Comparable<Vehicle> {
  car(tires: 4, passengers: 5, carbonPerKilometer: 400),
  bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
  bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0);

  ///枚举可以定义成员变量(只能是final修饰的，包括mixin混入的) 方法 和const常量构造方法(常量构造只能构造出已知数量的常量实例)
  final int tires;
  final int passengers;
  final int carbonPerKilometer;

  const Vehicle(
      {required this.tires,
      required this.passengers,
      required this.carbonPerKilometer});

  int get carbonFootprint => (carbonPerKilometer / passengers).round();

  @override
  int compareTo(Vehicle other) => carbonFootprint - other.carbonFootprint;

  @override
  String toString() => "$tires - $passengers - $carbonPerKilometer";
}

//枚举使用泛型
enum EnumWithType<T> {
  numbers<int>([1, 2, 3]),
  strings<String>(["hoko", "kobe"]);

  final List<T> items;

  const EnumWithType(this.items);
}

//最简单的枚举
enum Plain {
  foo,
  bar,
  baz;
}

class A{}

///enum枚举可以包含多种构造函数
///并且枚举不能再继承其他类,并且不能重写== hashCode index这些方法后者getter方法
enum LogPriority{
  warning(priority: 2, prefix: "warning"),
  error(priority: 1, prefix: "error"),
  ///log只是一个枚举实例的对象的名称，同时其是由unkonwn命名函数生成的
  log.unkonwn(prefix: "Log");

  final int priority;
  final String prefix;

  const LogPriority({required this.priority, required this.prefix});

  //named constructor
  const LogPriority.unkonwn({required String prefix})
      : this(priority: -1, prefix: prefix);

  ///枚举的工厂构造函数只能够返回已知的一个枚举实例
  // factory LogPriority.formJson() => const LogPriority(priority: 11,prefix: "check");

  @override
  String toString() => "$prefix($priority)";
}

// todo enum枚举和mixin的结合使用
