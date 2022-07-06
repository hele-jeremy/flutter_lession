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
    LogUtils.d(profileMark);
    var profileMark2 = ProfileMark.unNamed(33);
    profileMark2.increase();
    LogUtils.d(profileMark2);
    var profileMark3 = ProfileMark.unNamed2(20);
    LogUtils.d(profileMark3);

    var animal = Animal();
    LogUtils.d("animal: $animal");

    var staff = Staff.fromJson({"a": 1, "b": 2});
    LogUtils.d(staff);

    var staff2 = Staff({"A": 1, "B": 2});
    LogUtils.d("staff2 : $staff2");

    var vector3ds = Vector3ds.yzPlane(y: 2.22, z: 2.2);
    LogUtils.d(vector3ds);

    var vector3ds2 = Vector3ds.withAssert(1.1, 2.2, -1.3);
    LogUtils.d(vector3ds2);
    var vector3ds3 = Vector3ds(1.0, 2.0);
    LogUtils.d(vector3ds3.toString());

    var vector2ds = Vector2ds(1.1, 2.2);
    var vector2ds2 = Vector2ds(1.1, 3.3);
    var vector2ds3 = Vector2ds(1.1, 2.2);
    assert(vector2ds != vector2ds2);
    assert(vector2ds != vector2ds3);
    assert(!identical(vector2ds, vector2ds2));
    assert(!identical(vector2ds, vector3ds3));

    var immutablePoint = const ImmutablePoint(2.2, 3.3);
    var immutablePoint2 = const ImmutablePoint(1.1, 9.9);
    var immutablePoint3 = const ImmutablePoint(2.2, 3.3);
    var immutablePoint4 = const ImmutablePoint.fromJson(2.2, 3.3);
    var immutablePoint5 = ImmutablePoint(2.2, 3.3);
    var immutablePoint6 = ImmutablePoint.fromJson2(2.22);
    assert(immutablePoint != immutablePoint2);
    assert(!identical(immutablePoint, immutablePoint2));
    assert(immutablePoint == immutablePoint3);
    assert(identical(immutablePoint, immutablePoint3));
    assert(immutablePoint == immutablePoint4);
    assert(identical(immutablePoint, immutablePoint4));
    // assert(immutablePoint == immutablePoint5);
    // assert(identical(immutablePoint, immutablePoint5));
    // assert(immutablePoint == immutablePoint6);
    // assert(identical(immutablePoint, immutablePoint6));

    var immutablePoint7 = const ImmutablePoint(2, 3);
    var immutablePoint8 = const ImmutablePoint(2, 2);
    assert(immutablePoint7 + immutablePoint8 == const ImmutablePoint(4, 5));
    assert(immutablePoint7 - immutablePoint8 == const ImmutablePoint(0, 1));

    LogUtils.d("factory 工厂构造函数...");
    var logger = Logger("dev");
    var logger2 = Logger.fromJson({"name": "dev"});
    var logger3 = Logger.fromJson({"name": "pro"});
    assert(logger == logger2);
    assert(identical(logger, logger2));
    assert(logger != logger3);
    assert(!identical(logger, logger3));

    LogUtils.d("setter/getter方法......");
    var rectangle = Rectangle(1.1, 2.2, 2.2, 3.3);
    LogUtils.d(rectangle);
    //dart中的小数位数问题
    assert(rectangle.right.toStringAsFixed(1) == "3.3");
    rectangle.right = 5.5;
    LogUtils.d(rectangle);
    assert(rectangle.left == 3.3);

    LogUtils.d("抽象类abstract........");
    var absContainer = AbsContainer.fromCount(200);
    LogUtils.d(absContainer);
    LogUtils.d("隐式接口Implicitly interface.....");
    LogUtils.d(greetBob(ImplicitPerson("hoko")));
    LogUtils.d(greetBob(Impostor()));
    assert(Impostor().compareTo(Impostor()) == 0);
    dynamic impostor = Impostor();
    impostor.a();
    var a = impostor.a;

    LogUtils.d("扩展方法Extension methods.......");
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

    5.times((p0) => LogUtils.d("5.times -- $p0"));
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

  //重定向构造函数不能进行字段的初始化 同时重定向构造函数使用this重定向到类中的其他构造函数,使用super的不属于重定向构造函数
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

  //如果想在构造函数调用开始后,对final修饰的变量进行赋值操作,可以有以下两种方式:
  //使用工厂构造函数 factory constructor
  //使用late修饰final类型的变量,但是要注意late final修饰的变量没有初始化器的情况下，会对其添加一个setter API
  late final int count;

  void increase() {
    //count 变量使用late final修饰，由于其没有一个默认的初始化值,并且由于其使用了late进行了修饰
    //因此其可以不用在构造函数中进行初始化,并且为其添加了一个setter api,可以为其进行赋值操作
    //但是要注意 late 修饰的non-null非空类型的变量,在使用之前必须要进行初始化，否则抛出异常
    count = Random().nextInt(200);

    // name = "hoko"; //'name' can't be used as a setter because it's final.
  }

  ProfileMark(this.name);

  //Redirecting constructors can't have a body 重定向构造函数不能有函数体
  // ProfileMark.unNamed(int count) : this("pro2"){}

  // ProfileMark.nuNamed(this.count) : this("pro2"); //The redirecting constructor can't have a field initializer.
  ProfileMark.unNamed(int count) : this("pro2");

  //注意:unNamed是重定向构造函数，而unNamed2 是命名构造函数不是重定向构造函数
  ProfileMark.unNamed2(this.count) : name = "pro3";

  @override
  String toString() {
    return 'ProfileMark{name: $name, start: $start, count: $count}';
  }
}

class Animal {
  //默认构造函数，如果类中没有声明构造函数，dart会默认给我们生成一个无参构造函数,并且该构造函数会调用父类的无参构造函数
  //构造函数不会被继承，如果子类没有声明构造函数,会有一个默认的无参构造函数
}

class People {
  String? firstName;

  People.fromJson(Map data) {
    LogUtils.d("in people:$data");
  }
}

class Staff extends People {
  // Staff.fromJson(Map data) : super.fromJson(data) {
  //   LogUtils.d("in Staff:$data");
  // }

  Staff.fromJson(super.data) : super.fromJson() {
    LogUtils.d("in Staff:");
  }

  Staff(Map data) : super.fromJson(data);
// Staff(super.data) : super.fromJson();
}

//使用父类构造参数
class Vector2d {
  final double x;
  final double y;

  Vector2d(this.x, this.y);
}

class Vector3d extends Vector2d {
  final double z;

  //常规写法
  // Vector3d(final double x, final double y, this.z) : super(x, y);
  //子类构造函数中使用超类参数
  Vector3d(super.x, super.y, this.z);
}

class Vector2ds {
  final double x;
  final double y;

  Vector2ds.named({required this.x, required this.y});

  Vector2ds(this.x, this.y);

// Vector2ds.named([this.x = 22.2, this.y = 4.3]);
}

class Vector3ds extends Vector2ds {
  final double z;

  //父类构造的位置参数如果已经被使用,那么父类构造参数就不能再继续使用被占用的位置,同时父类构造函数的参数可以始终是命名参数(since dart 2.17)
  Vector3ds.yzPlane({required double y, required this.z})
      : super.named(x: 2.2, y: y);

// Vector3ds.yzPlane({required super.y, required this.z}) : super.named(x: 2.2);

// Vector3ds.yzPlane({required double y, required this.z})
//     : super.named(2.2, y);

  Vector3ds.fromJson(Map<String, double> jsonData, super.x, super.y)
      : z = jsonData["z"]!;

  Vector3ds.fromJson2(Map<String, double> jsonData, this.z)
      : super.named(x: jsonData["x"]!, y: jsonData["y"]!);

  //开发模式下可以使用断言来验证输入的参数数据
  Vector3ds.withAssert(this.z, super.x, super.y)
      : assert(z >= 0, "z must be > 0"),
        assert(x >= 0, "x must be > 0"),
        assert(y <= 0, "y must be < 0");

  //使用初始化列表可以很方便的初始化final变量
  Vector3ds(super.x, super.y) : z = sqrt((x * x) + (y * y));

  @override
  String toString() {
    return 'Vector3ds{x: ${super.x} y: ${super.y} z: $z}';
  }
}

//常量构造函数
class ImmutablePoint {
  static const ImmutablePoint origin = ImmutablePoint(0, 0);
  final double x, y;

  //使用常量构造函数创建编译时常量
  const ImmutablePoint(this.x, this.y);

  // const ImmutablePoint.fromJson(Map<String, double> jsonData)
  //     : x = jsonData["x"]!,
  //       y = jsonData["y"]!;  //Invalid constant value.

  const ImmutablePoint.fromJson(this.x, this.y);

  const ImmutablePoint.fromJson2(this.x, {this.y = 2.2});

  //重写操作符
  ImmutablePoint operator +(ImmutablePoint other) =>
      ImmutablePoint(x + other.x, y + other.y);

  ImmutablePoint operator -(ImmutablePoint other) =>
      ImmutablePoint(x - other.x, y - other.y);

  @override
  bool operator ==(Object other) =>
      other is ImmutablePoint && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);
}

//工厂构造函数 factory
class Logger {
  final String name;
  bool mute = false;

  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  factory Logger.fromJson(Map<String, Object> jsonData) {
    //工厂构造函数中不能访问this
    // this.mute = false;
    return Logger(jsonData["name"].toString());
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) {
      // ignore: avoid_print
      print(msg);
    }
  }

  @override
  String toString() {
    return 'Logger{namne: $name, mute: $mute}';
  }
}

//getter/setter方法
class Rectangle {
  double left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  double get right => left + width;

  double get bottom => top + height;

  set right(double value) => left = value - width;

  set bottom(double value) => top = value - height;

  @override
  String toString() {
    return 'Rectangle{left: $left, top: $top, width: $width, height: $height, right: $right, bottom: $bottom}';
  }
}

//抽象类 abstract
//抽象类无法实例化
//抽象类可以定义抽象方法，抽象变量
abstract class AbsContainer {
  int count;

  //定义一个抽象变量
  abstract int a;

  //定义了一个抽象方法
  void updateChildren();

  //也可以有具体的方法实现
  void detailAction() {}

  AbsContainer(this.count); //不能够实例化

  //抽象类如果想被实例化，可以通过提供一个工厂构造函数，返回其实现的具体子类
  // factory AbsContainer.fromCount(int count) => AbsContainer(count); //不能够实例化
  factory AbsContainer.fromCount(int count) => Box(100, count);

  // AbsContainer.mock(this.count); //不能够实例化

  @override
  String toString() => 'AbsContainer{count: $count, a: $a}';
}

class Box extends AbsContainer {
  @override
  int a;

  Box(this.a, super.count) : super();

  @override
  void updateChildren() {}
}

//隐式接口 implicit interface
//Dart中的每个类都提供了一个隐式接口,这个接口包含了该类的所有的实例(instance)成员(变量和方法)
//以及这个类实现的其他接口的实例成员,同时该类实现了这个隐式接口
//如果想创建一个A类支持调用B类的API但是又不想继承(extends)B类，则可以实现(implements)B类的接口(隐式接口)

//ImplicitPerson 相当于相当于实现了ImplicitPerson隐式接口
//这个接口包含了greet()方法 以及_name变量
class ImplicitPerson {
  //在接口中仅对当前library文件可见
  final String _name;

  //构造函数不包含在接口中
  ImplicitPerson(this._name);

  //包含在接口中，并对外可见
  String greet(String who) => "Hello, $who. I am $_name";
}

class Impostor implements ImplicitPerson, Comparable<Impostor> {
  @override
  String get _name => "Impostor";

  @override
  String greet(String who) => "Hi $who. Do you know who I am?";

  @override
  int compareTo(Impostor other) => _name.compareTo(other._name);

  @override
  int get hashCode => Object.hashAll([_name]);

  @override
  bool operator ==(Object other) => other is Impostor && other._name == _name;

  //dynamic类型的变量,调用了不存在的方法或者变量的情况下
  //会触发noSuchMethod方法,可以重写该方法，来记录和跟踪这一行为
  //否则会抛出NoSuchMethodError
  @override
  noSuchMethod(Invocation invocation) {
    LogUtils.d("$this \ninvocation:$invocation\n${invocation.runtimeType}");
  }
}

String greetBob(ImplicitPerson person) => person.greet("Bob");

//扩展 https://dart.cn/guides/language/extension-methods
//扩展不仅可以扩展方法,也可以扩展很多的类型，例如：getter/setter/operarator操作符

extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }

  String scream() => toUpperCase();
}

extension IntExtension on int {
  void times(void Function(int) f) {
    for (int i = 0; i < this; i++) {
      Function.apply(f, toList());
    }
  }

  List<int> toList() => [this];

  List<int> toListWithValue(int value) => [value];
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
