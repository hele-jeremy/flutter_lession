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

    var person = Person("hoko", "male", 2.22);
    // var person = Person("hoko", sex: "male", height: 2.22);
    // var person = Person("hoko");
    // var person = Person(name: "hoko", sex: "male");
    LogUtils.d(person);

    var person2 = Person.fromJson(<String, int>{
      for (int i = 0; i < 3; i++) "key_$i": i * i
    }, "hoko2", "ladyboy", 2.22, age: 30);
    LogUtils.d(person2);
    //DartClasses 和 Person都定义在一个类文件中，因此是DartClasses是可以访问调用Person的私有命名构造函数的
    var person3 = Person._fromJson2({}, "hoko3", "male", 2.3, 43);
    person3.doSomething();
    LogUtils.d(person3);
    Person.sayWorld();

    var person4 = Person.build(name: "hoko", sex: "male");
    LogUtils.d(person4);

    var person5 = Person.build2("hook");
    LogUtils.d(person5);

    LogUtils.d(
        "-----------------------------------------------------------------");
    var profileMark = ProfileMark("pro1");
    profileMark.increase();
    var profileMark2 = ProfileMark.unNamed();
    var profileMark3 = ProfileMark.unNamed2();
    LogUtils.d("$profileMark\n$profileMark2\n$profileMark3");
  }
}

class Person {
  //静态常量
  static const count = 100;

  //静态变量
  static var country = "中国";

  //成员变量默认会生成一个隐式的getter方法，并且非final的成员变量以及late final修饰但是未声明初始化器的成员变量也会生成隐式的setter方法
  //对于非空non-null类型的成员变量，有三种初始化方式:
  //  1.在定义的时候通过初始化语句初始化. 如: String name = "hello";
  //  2.将其标记为late ,但要保证在使用该变量之前，其已经初始化赋值了
  //  3.通过构造函数进行初始化
  // String name = "hello";
  // final String sex = "male";
  // late String name;
  // late final String sex;
  String name;

  final String sex;

  //nullable可空类型的变量，可以初始化也可以不进行初始化，有默认值null
  int? age;

  //同时对于final修饰的变量，不管是nullable还是non-null类型的，都需要进行初始化
  //初始化方式有:
  // late标记(保证使用之前已经经过初始化了)
  // 默认赋初始值
  //通过构造进行初始化
  final double? height;

  //构造函数
  Person(this.name, this.sex, this.height) {
    LogUtils.d("Person通过构造函数初始化:$name $sex $age $height");
  }

  // Person(this.name,{required this.sex,required this.height});
  // Person(this.name, {this.sex = "female", this.height}); //命名参数对于nullable类型的变量,可以有默认值null，也可以通过required强制赋值(当然也可以赋null空值)
  // Person(this.name, [this.sex = "male", this.height]); //位置参数non-null必须有默认值，nullable有默认值null
  // Person({required this.name, required this.sex, this.height});
  // Person([this.name = "default",this.sex = "ladyboy",this.height]);  //构造函数的参数可以全部定义成命名参数或者位置参数

  //命名构造函数  类名.标识符
  //Dart提供了Named Constructor命名构造函数,让代码的可读性更高,使人通过名字就知道该构造函数是干嘛的

  //类中定义的final类型的变量必须在类初始化的时候进行初始化,以及对于没有初始化的non-null类型的变量也必须进行初始化
  Person.fromJson(Map data, this.name, this.sex, this.height, {this.age}) {
    LogUtils.d("Person通过命名构造函数初始化:$name $sex $age $height\n${data.toString()}");
  }

  //通过_下划线将构造函数进行私有化，使其只能在当前类中进行初始化
  Person._fromJson2(Map data, this.name, this.sex, this.height, [this.age]) {
    LogUtils.d(
        "Person通过私有命名构造函数初始化:$name $sex $age $height\n${data.toString()}");
  }

  //构造函数还可以调用另一个构造函数,通过this关键字调用其他构造函数
  Person.fromName(String name) : this(name, "female", 2.22);

  Person.fromNameAndSex(String name, String sex) : this(name, sex, 43.33);

  Person.mock() : this("mock_user", "ladyboy", 22);

  Person.build(
      {required String name, required String sex, double height = 3.14})
      : this(name, sex, height);

  Person.build2(
      [String name = "default", String sex = "male", double height = 0.0])
      : this(name, sex, height);

  //重定向构造函数不能进行字段的初始化
  // Person.from(this.name,String sex) : this(sex,2.22); //The redirecting constructor can't have a field initializer.

  //成员方法
  void doSomething() {
    LogUtils.d("person : $name dosomething...!");
  }

  //静态方法
  static void sayWorld() {
    LogUtils.d("Person sayWorld!");
  }

  @override
  String toString() {
    return 'Person{name: $name, sex: $sex, age: $age, height: $height}';
  }
}

class Pair<T> {
  final T first;
  final T second;

  //常量构造函数
  const Pair(this.first, this.second);

  Pair.fromJson(T first, T second) : this(first, second);
}

class ProfileMark {
  //final 非late修饰的变量的赋值通常是通过构造函数来进行初始化的

  final String name;
  final DateTime start = DateTime.now();

  //如果想在构造函数调用开始后,对final修饰的变量进行赋值操作,可以有一下两种方式:
  late final int count;

  void increase(){
    count = Random().nextInt(200);
  }

  ProfileMark(this.name);

  ProfileMark.unNamed() : this("pro2");

  ProfileMark.unNamed2() : name = "pro3";

  @override
  String toString() {
    return 'ProfileMark{name: $name, start: $start, count: $count}';
  }
}
