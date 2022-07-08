import 'package:flutter/material.dart';
import 'package:flutter_lesson/dart_lesson/extension/some_api.dart';

import '../../utils/log_utils.dart';

///dart中的扩展extension

class DartExtensions extends StatelessWidget {
  const DartExtensions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MaterialButton(
                onPressed: _extensionTest,
                child: Text("扩展Extension",
                    style: Theme.of(context).textTheme.headline6))
          ]))
    ]);
  }

  void _extensionTest() {
    assert("22".padLeft(3, "*") == "*22");
    assert(int.parse("22") == 22);
    assert("22".parseInt() == 22);
    assert("2.22".parseDouble() == 2.22);

    //Class 'String' has no instance method 'parseInt'.
    //不能对动态类型的变量调用扩展方法,否则会抛出NoSuchMethodError异常
    dynamic da = "22";
    // assert(da.parseInt() == 22);
    //而对于var类型的变量则是可以调用扩展方法的，因为var类型的变量
    //在第一次赋值的时候，通过类型推断就可以确定其类型
    var va = "22";
    assert(va.parseInt() == 22);
    var list = <String>[for (int i1 = 0; i1 < 5; i1++) "kobe-$i1"];
    assert(list.doubleLength == 10);
    LogUtils.d(-list);
    LogUtils.d(list.split(3));

    var from =
        PlanetExtensions.from(<String, Object>{"name": "hoko", "size": 22});
    // assert(from == const Planet("hoko",22,));
    // assert(identical(from, const Planet("hoko", 22)));
    LogUtils.d(from);
    var tips = "hello worls!";
    LogUtils.d(tips.scream());

    5.times((i) => LogUtils.d("5.times-----$i"));
    LogUtils.d(null.stop("!!!"));

    //通过扩展方法流式调用
    getItem()
      ..removeYoungest()
      ..show();

    var listSum = <int>[for (int j = 0; j < 5; j++) j].sum;
    assert(listSum == 10);

    assert(const MetricLength(2) == 2.m);
    assert(const MetricLength(2 * 1000) == 2.km);

    var map = <String, Object>{"id": 100, "name": "hoko"};
    assert(map.id == 100);
    assert(map.name == "hoko");

    var group = Group({BPlayer("hoko", DateTime(1992, 3, 2))});
    var group2 = group + BPlayer("kobe", DateTime(1991, 2, 2));
    var gResult = group2 > group;
    var group3 = BPlayer("jason", DateTime(1993, 3, 2)) +
        BPlayer("lebron", DateTime(1982, 2, 9));
    LogUtils.d(group);
    LogUtils.d(group2);
    LogUtils.d(group3);
    LogUtils.d("gResult = $gResult");
  }
}

///扩展 https://dart.cn/guides/language/extension-methods
///扩展不仅可以扩展方法,也可以扩展很多的类型，例如：getter/setter/operarator操作符

extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }

  String scream() => toUpperCase();
}

//自定义公里
class MetricLength {
  final int meters;

  const MetricLength(this.meters);

  MetricLength operator +(MetricLength other) =>
      MetricLength(meters + other.meters);

  @override
  bool operator ==(Object other) =>
      ((other is MetricLength) && (other.meters == meters));

  @override
  int get hashCode => Object.hashAll(meters.toList());
}

extension IntExtension on int {
  void times(void Function(int) f) {
    for (int i = 0; i < this; i++) {
      // Function.apply(f, toListWithValue(i));
      //  f.call(i);
      f(i);
    }
  }

  List<int> toList() => [this];

  List<int> toListWithValue(int value) => [value];

  MetricLength get m => MetricLength(this);

  MetricLength get km => MetricLength(this * 1000);
}

extension ObjectExtension on Object {
  int nah() => hashCode + 42;

  Type type() => runtimeType;

  bool notAgain(Object other) => this != other;
}

extension ObjectNorExtension on Object? {
  String stop(String x) => "${toString()}$x";
}

//带泛型的扩展
extension MyCustomList<T> on List<T> {
  int get doubleLength => length * 2;

  List<T> operator -() => reversed.toList();

  List<List<T>> split(int at) => [sublist(0, at), sublist(at)];
}

//指定泛型的扩展
extension on List<int> {
  int get sum => fold(0, (previousValue, element) => previousValue + element);
}

class Planet {
  final String name;
  final int size;

  const Planet(this.name, this.size);

  @override
  String toString() {
    return 'Planet{name: $name, size: $size}';
  }
}

extension PlanetExtensions on Planet {
  //静态扩展函数
   static Planet from(Map<String, Object> json) =>
      Planet(json["name"] as String, json["size"] as int);

  Map<String, Object> toJson() => {"name": name, "size": size};
}

extension on Group {
  void removeYoungest() {
    var sorted = players.toList()
      ..sort((a, b) => a.dayOfBirth.compareTo(b.dayOfBirth));
    var last = sorted.last;
    players.remove(last);
  }

  void show() => LogUtils.d(this);

  //对类Group进行操作符operator扩展
  Group operator +(BPlayer other) => Group({...players, other});

  bool operator >(Group other) => players.length > other.players.length;
}

extension BPlayerArithMetic on BPlayer {
  Group operator +(BPlayer other) => Group({this, other});
}

//Map的扩展
extension _MyJsonHelper on Map<String, Object> {
  int? get id => this["id"] as int?;

  String? get name => this["name"] as String?;
}
