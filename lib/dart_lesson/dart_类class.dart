import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lesson/dart_lesson/dart_%E5%8D%95%E4%BE%8B%E6%A8%A1%E5%BC%8F.dart';
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
    Person.commonClassMemberAndConstructorTest();
    ProfileMark.constructorTest();
    Staff.constructorInvokeTest();
    Vector3ds.superConstructorParamsAndInitializeList();
    ImmutablePoint.constConstructorTest();
    Logger.testFactoryConstructor();
    Rectangle.testGetterSetter();
    Box.testAbstractClass();
    Impostor.testImplicitInterfaceAndNoSuchMethod();
  }
}

class Person {
  ///静态常量
  static const count = 100;

  ///静态变量
  static var country = "中国";

  ///成员变量默认会生成一个隐式的getter方法，并且非final的成员变量以及late final修饰但是未声明初始化器的成员变量会生成隐式的setter方法
  ///对于非空non-null类型的成员变量，有三种初始化方式:
  ///  1.在定义的时候通过初始化语句初始化. 如: String name = "hello";
  ///  2.将其标记为late ,但要保证在使用该变量之前，其已经初始化赋值了
  ///  3.通过构造函数进行初始化
  // String name = "hello";
  // final String sex = "male";
  // late String name;
  // late final String sex;
  String name;
  final String sex;

  ///nullable可空类型的变量，可以初始化也可以不进行初始化，有默认值null
  int? age;

  ///同时对于final修饰的变量，不管是nullable还是non-null类型的，都需要进行初始化
  ///初始化方式有:
  /// 默认赋初始值
  /// late标记(保证使用之前已经经过初始化了)
  ///通过构造进行初始化
  final double? height;

  ///构造函数
  Person(this.name, this.sex, this.height) {
    LogUtils.d("Person通过构造函数初始化:$name $sex $age $height");
  }

  // Person(this.name,{required this.sex,required this.height});
  // Person(this.name, {this.sex = "female", this.height}); //命名参数对于nullable类型的变量,可以有默认值null，也可以通过required强制赋值(当然也可以赋null空值)
  // Person(this.name, [this.sex = "male", this.height]); //位置参数non-null必须有默认值，nullable有默认值null
  // Person({required this.name, required this.sex, this.height});
  // Person([this.name = "default",this.sex = "ladyboy",this.height]);  //构造函数的参数可以全部定义成命名参数或者位置参数

  ///命名构造函数  类名.标识符
  ///Dart提供了Named Constructor命名构造函数,让代码的可读性更高,使人通过名字就知道该构造函数是干嘛的
  ///类中定义的final类型的变量必须在类初始化的时候进行初始化,以及对于没有初始化的non-null类型的变量也必须进行初始化
  // Person.fromJson(Map data, this.name, /*this.sex, this.height, */{this.sex = "",this.height,this.age}) { //final变量为可选参数
  Person.fromJson(Map data, this.name, this.sex, this.height, {this.age}) {
    //final变量为必填参数
    LogUtils.d("Person通过命名构造函数初始化:$name $sex $age $height\n${data.toString()}");
  }

  ///通过_下划线将构造函数进行私有化，使其只能在当前类中进行初始化
  Person._fromJson2(Map data, this.name, this.sex, this.height, [this.age]) {
    LogUtils.d(
        "Person通过私有命名构造函数初始化:$name $sex $age $height\n${data.toString()}");
  }

  //构造函数还可以调用另一个构造函数,通过this关键字调用其他构造函数 (重定向redirect构造函数)
  Person.fromName(String name) : this(name, "female", 2.22);

  Person.fromNameAndSex(String name, String sex) : this(name, sex, 43.33);

  Person.mock() : this("mock_user", "ladyboy", 22);

  Person.build(
      {required String name, required String sex, double height = 3.14})
      : this(name, sex, height);

  Person.build2(
      [String name = "default", String sex = "male", double height = 0.0])
      : this(name, sex, height);

  ///重定向构造函数不能进行字段的初始化 同时重定向构造函数使用this重定向到类中的其他构造函数,使用super的不属于重定向构造函数
  // Person.from(this.name,String sex) : this(sex,2.22); //The redirecting constructor can't have a field initializer.

  ///成员方法
  void doSomething() {
    LogUtils.d("person : $name dosomething...!");
  }

  ///静态方法
  static void sayWorld() {
    LogUtils.d("Person sayWorld!");
  }

  @override
  String toString() {
    return 'Person{name: $name, sex: $sex, age: $age, height: $height}';
  }

  static void commonClassMemberAndConstructorTest() {
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
  }
}

class Pair<T> {
  final T first;
  final T second;

  // int count = 0; //Can't define a const constructor for a class with non-final fields

  ///常量构造函数
  const Pair(this.first, this.second);

  Pair.fromJson(T first, T second) : this(first, second);
}

class ProfileMark {
  ///final 非late修饰的变量的赋值通常是通过构造函数来进行初始化的
  final String name;
  final DateTime start = DateTime.now();

  ///如果想在构造函数调用开始后,对final修饰的变量进行赋值操作,可以有以下两种方式:
  ///使用工厂构造函数 factory constructor
  ///使用late修饰final类型的变量,但是要注意late final修饰的变量没有初始化器的情况下，会对其添加一个setter API
  late final int count;

  void increase() {
    ///count 变量使用late final修饰，由于其没有一个默认的初始化值,并且由于其使用了late进行了修饰
    ///因此其可以不用在构造函数中进行初始化,并且为其添加了一个setter api,可以为其进行赋值操作
    ///但是要注意 late 修饰的non-null非空类型的变量,在使用之前必须要进行初始化，否则抛出异常
    count = Random().nextInt(200);
    // name = "hoko"; //'name' can't be used as a setter because it's final.
  }

  ProfileMark(this.name);

  ///Redirecting constructors can't have a body 重定向构造函数不能有函数体
  // ProfileMark.unNamed(int count) : this("pro2"){}
  ///The redirecting constructor can't have a field initializer. 重定向构造函数不能使用this初始化变量
  // ProfileMark.nuNamed(this.count) : this("pro2");
  ProfileMark.unNamed(int count) : this("pro2");

  ///注意:unNamed是重定向构造函数，而unNamed2 是命名构造函数不是重定向构造函数
  ///同时nuNamed2通过初始化列表(Initialize list)初始化列表对name进行了赋值操作
  ProfileMark.unNamed2(this.count) : name = "pro3";

  @override
  String toString() {
    return 'ProfileMark{name: $name, start: $start, count: $count}';
  }

  static void constructorTest() {
    LogUtils.d("构造函数的测试.....");
    var profileMark = ProfileMark("pro1");
    profileMark.increase();
    LogUtils.d(profileMark);
    var profileMark2 = ProfileMark.unNamed(33);
    profileMark2.increase();
    LogUtils.d(profileMark2);
    var profileMark3 = ProfileMark.unNamed2(20);
    LogUtils.d(profileMark3);
  }
}

class Animal {
  ///默认构造函数，如果类中没有声明构造函数，dart会默认给我们生成一个无参构造函数,并且该构造函数会调用父类的无参构造函数
  ///构造函数不会被继承，如果子类没有声明构造函数,会有一个默认的无参构造函数
}

class People {
  String? firstName;

  ///子类构造函数不能通过super调用父类的工厂构造函数
  // factory People.fromJson(Map data) => People();
  // People();

  ///同时只要类中定义了一个构造函数(哪怕是factory工厂构造函数)就不会再提供默认无参构造函数
  People.fromJson(Map data) {
    LogUtils.d("in people:$data");
  }
}

class Staff extends People {
  Staff.fromJson(Map data) : super.fromJson(data) {
    LogUtils.d("in Staff:$data");
  }

  Staff.fromJson2(super.data) : super.fromJson() {
    LogUtils.d("in Staff:");
  }

  // Staff(Map data) : super.fromJson(data);
  Staff(super.data) : super.fromJson();

  static void constructorInvokeTest() {
    LogUtils.d("默认无参构造函数...");
    var animal = Animal();
    LogUtils.d("animal: $animal");

    var staff = Staff.fromJson({"a": 1, "b": 2});
    LogUtils.d(staff);

    var staff2 = Staff({"A": 1, "B": 2});
    LogUtils.d("staff2 : $staff2");
  }
}

///使用父类构造参数
class Vector2d {
  final double x;
  final double y;

  Vector2d(this.x, this.y);
}

class Vector3d extends Vector2d {
  final double z;

  ///常规写法
  // Vector3d(final double x, final double y, this.z) : super(x, y);
  ///子类构造函数中使用超类参数
  Vector3d(super.x, super.y, this.z);
}

class Vector2ds {
  final double x;
  final double y;

  Vector2ds.named({required this.x, required this.y});

  Vector2ds(this.x, this.y);

  Vector2ds.named2([this.x = 22.2, this.y = 4.3]);
}

class Vector3ds extends Vector2ds {
  final double z;

  ///父类构造的位置参数如果已经被使用,那么父类构造参数就不能再继续使用被占用的位置,同时父类构造函数的参数可以始终是命名参数(since dart 2.17)
  Vector3ds.yzPlane({required double y, required this.z})
      : super.named(x: 2.2, y: y);

// Vector3ds.yzPlane({required super.y, required this.z}) : super.named(x: 2.2);

// Vector3ds.yzPlane({required double y, required this.z})
//     : super.named2(2.2, y);

  Vector3ds.fromJson(Map<String, double> jsonData, super.x, super.y)
      : z = jsonData["z"]!;

  Vector3ds.fromJson2(Map<String, double> jsonData, this.z)
      : super.named(x: jsonData["x"]!, y: jsonData["y"]!);

  ///开发模式下可以使用断言来验证输入的参数数据
  Vector3ds.withAssert(this.z, super.x, super.y)
      : assert(z >= 0, "z must be > 0"),
        assert(x >= 0, "x must be > 0"),
        assert(y <= 0, "y must be < 0");

  ///使用初始化列表可以很方便的初始化final变量
  Vector3ds(super.x, super.y) : z = sqrt((x * x) + (y * y));

  @override
  String toString() {
    return 'Vector3ds{x: ${super.x} y: ${super.y} z: $z}';
  }

  static void superConstructorParamsAndInitializeList() {
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
  }
}

///常量构造函数
///如果某个类创建对象后不再发生更改，可以将对象声明为运行时常量，将对象声明为常量，需要将类的构造方法声明为
///常量构造方法,并且类中所有的(直接定义或者通过继承)field成员变量必须是final的
class ImmutablePoint {
  static const ImmutablePoint origin = ImmutablePoint(0, 0);
  final double x, y;

  //Can't define a const constructor for a class with non-final fields.
  // int z = 1;

  const ImmutablePoint(this.x, this.y);

  const ImmutablePoint.fromJson(this.x, this.y);

  const ImmutablePoint.fromJson2(this.x, {this.y = 2.2});

  ///Invalid constant value.
  ///const构造函数初始化的时候，构造函数传入的初始化值必须是常量，也就是再编译期就可以确定的
  ///而初始化列表中的jsonData["x"]和jsonData["y"]是不能在编译期确定的常量
  // const ImmutablePoint.fromJson3(Map<String, double> jsonData)
  //     : x = jsonData["x"]!,
  //       y = jsonData["y"]!;

  ImmutablePoint.fromJson3(Map<String, double> jsonData)
      : x = jsonData["x"]!,
        y = jsonData["y"]!;

  ///重写操作符
  ImmutablePoint operator +(ImmutablePoint other) =>
      ImmutablePoint(x + other.x, y + other.y);

  ImmutablePoint operator -(ImmutablePoint other) =>
      ImmutablePoint(x - other.x, y - other.y);

  factory ImmutablePoint.mock(double x, double y) {
    ///const 和 final的区别:
    ///const是一个常量，在编译的时候就确定了值，因此使用const定义的地方，赋值必须是一个编译期常量
    ///final的意思是一旦赋值就不能更改了，其是在运行期runtime确定的

    ///使用const常量构造函数创建对象，传递的参数必须是常量,而x,y是变量因此不符合要求
    // return const ImmutablePoint(x, y);
    // return const ImmutablePoint(11.1, 22); //使用常量创建
    return ImmutablePoint(x, y);
  }

  static void constConstructorTest() {
    LogUtils.d("const常量构造函数.....");

    ///必须定义了const常量构造函数的，才能够创建const常量对象
    // var vector2ds4 =const Vector2ds(2.2,3.3);
    var immutablePoint = const ImmutablePoint(2.2, 3.3);
    var immutablePoint2 = const ImmutablePoint(1.1, 9.9);
    var immutablePoint3 = const ImmutablePoint(2.2, 3.3);
    var immutablePoint4 = const ImmutablePoint.fromJson(2.2, 3.3);
    var immutablePoint5 = ImmutablePoint(2.2, 3.3); //调用常量构造函数,没有const修饰不是编译期常量
    var immutablePoint6 = ImmutablePoint.fromJson2(2.22);
    assert(immutablePoint != immutablePoint2);
    assert(!identical(immutablePoint, immutablePoint2));

    ///使用常量构造函数创建编译时常量
    ///使用常量构造函数相同参数创建的对象是同一个对象
    assert(immutablePoint == immutablePoint3);
    assert(identical(immutablePoint, immutablePoint3));
    assert(immutablePoint == immutablePoint4);
    assert(identical(immutablePoint, immutablePoint4));
    assert(immutablePoint != immutablePoint5);
    assert(!identical(immutablePoint, immutablePoint5));
    assert(immutablePoint != immutablePoint6);
    assert(!identical(immutablePoint, immutablePoint6));

    var immutablePoint7 = const ImmutablePoint(2, 3);
    var immutablePoint8 = const ImmutablePoint(2, 2);
    assert(immutablePoint7 + immutablePoint8 != const ImmutablePoint(4, 5));
    assert(immutablePoint7 - immutablePoint8 != const ImmutablePoint(0, 1));

    ///fromJson3不是常量构造函数因此不能使用const进行修饰
    // var immutablePoint9 = const ImmutablePoint.fromJson3({});

    ///在某些场景中可以忽略const关键字
    // const pointAndLine = const {
    //   "point": const [const ImmutablePoint(2.2, 3.3)],
    //   "line":const [const ImmutablePoint(1.1, 4.4),const ImmutablePoint(5.5, 9.9)]
    // };

    ///只需要保留一个常量上下文(context)即可，其余的都可以省略掉
    const pointAndLine = {
      "point": [ImmutablePoint(2.2, 3.3)],
      "line": [ImmutablePoint(1.1, 4.4), ImmutablePoint(5.5, 9.9)]
    };
  }

// @override
// bool operator ==(Object other) =>
//     other is ImmutablePoint && x == other.x && y == other.y;

// @override
// int get hashCode => Object.hash(x, y);
}

///工厂构造函数 factory
class Logger {
  final String name;
  bool mute = false;

  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  ///工厂构造函数使用factory进行修饰
  ///factory严格意义上并不是构造函数，因为其方法体内不能够访问this,只是为了调用该方法的时候就像调用普通构造函数一样
  ///而不用关心到底是返回了一个新建的对象还是一个缓存的对象
  factory Logger.fromJson(Map<String, Object> jsonData) {
    ///工厂构造函数中不能访问this
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

  static void testFactoryConstructor() {
    LogUtils.d("factory 工厂构造函数...");
    var logger = Logger("dev");
    var logger2 = Logger.fromJson({"name": "dev"});
    var logger3 = Logger.fromJson({"name": "pro"});
    assert(logger == logger2);
    assert(identical(logger, logger2));
    assert(logger != logger3);
    assert(!identical(logger, logger3));

    ///factory工厂构造函数实现单例模式
    // var mySingleton = new MySingleton();
    var mySingleton = MySingleton();
    // var mySingleton2 = new MySingleton.fronCount(100);
    var mySingleton2 = MySingleton.fronCount(100);
    assert(mySingleton == mySingleton2);
    assert(identical(mySingleton, mySingleton2));
    LogUtils.d(mySingleton);
    LogUtils.d(mySingleton2);
  }

  @override
  String toString() {
    return 'Logger{namne: $name, mute: $mute}';
  }
}

///getter/setter方法
///可以使用 get 和 set 关键字实现 getter 和 setter 方法来创建新的属性
///或者给已有的属性实现get/set方法
class Rectangle {
  double left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  double get right => left + width;

  double get bottom => top + height;

  set right(double value) => left = value - width;

  set bottom(double value) => top = value - height;

  static void testGetterSetter() {
    LogUtils.d("setter/getter方法......");
    var rectangle = Rectangle(1.1, 2.2, 2.2, 3.3);
    LogUtils.d(rectangle);
    //dart中的小数位数问题
    assert(rectangle.right.toStringAsFixed(1) == "3.3");
    rectangle.right = 5.5;
    LogUtils.d(rectangle);
    assert(rectangle.left == 3.3);
  }

  @override
  String toString() {
    return 'Rectangle{left: $left, top: $top, width: $width, height: $height, right: $right, bottom: $bottom}';
  }
}

///抽象类 abstract
///抽象类无法实例化
///抽象类可以定义抽象方法，抽象变量
abstract class AbsContainer {
  int count;

  ///定义一个抽象变量
  abstract int a;

  ///定义一个抽象方法
  void updateChildren();

  ///也可以有具体的方法实现
  void detailAction() {}

  ///不能够实例化
  AbsContainer(this.count) {
    LogUtils.d("AbsContainer init..... $count");
  }

  AbsContainer.from(this.count);

  ///抽象类如果想被实例化，可以通过提供一个工厂构造函数，返回其实现的具体子类
  // factory AbsContainer.fromCount(int count) => AbsContainer(count); //不能够实例化
  factory AbsContainer.fromCount(int count) => Box(100, count);

  @override
  String toString() => 'AbsContainer{count: $count, a: $a}';
}

class Box extends AbsContainer {
  ///相当于重写了setA/getA 方法
  @override
  int a;

  ///Box类的构造函数有三部分组成:
  ///1.Box(this.a, int count)  子类Box自己的构造函数
  ///2.assert(count > 500,"count must > 500") 初始化列表Initialize list
  ///3.super(count) 调用父类构造函数
  ///调用顺序为: 1.初始化列表 2.父类构造函数(无参/带参构造函数) 3.子类自己的构造函数
  ///可以通过一下的assert断言来验证
  ///初始化列表右边不能使用this关键字，原因是此时对象还没有初始化，根本没有this
  // Box(this.a, int count) : assert(count > 500,"count must > 500"), super(count){
  //   LogUtils.d("Box init..... a : $a count : $count");
  // }

  Box(this.a, super.count) : super() {
    LogUtils.d("Box init..... a : $a count : $count");
  }

  ///子类Box调用的是父类构造函数AbsCoutainer()而不是AbsContainer.from()命名构造函数
  // Box.from(super.count,this.a);
  Box.from(int count, this.a)
      //初始化列表
      : assert(a > 1000, "a must > 1000"),
        super(count);

  Box.from2(this.a) : super.from(fetchData());

  static int fetchData() {
    return 10;
  }

  @override
  void updateChildren() {}

  static void testAbstractClass() {
    LogUtils.d("抽象类abstract........");
    var absContainer = AbsContainer.fromCount(200);
    LogUtils.d(absContainer);
  }
}

class MyPoint {
  final double x, y, distanceFromOrigin;

  ///使用初始化列表很容易方便对final类型的变量赋值
  MyPoint(double x, double y)
      : x = x,
        y = y,
        distanceFromOrigin = sqrt(x * x + y * y);
}

///隐式接口 implicit interface
///Dart中的每个类都提供了一个隐式接口,这个接口包含了该类的所有的实例(instance)成员(变量和方法)
///以及这个类实现(implements)的其他接口的实例成员,同时该类实现了这个隐式接口
///如果想创建一个A类支持调用B类的API但是又不想继承(extends)B类，则可以实现(implements)B类的接口(隐式接口)

class BigPerson {
  final String _sex;
  final int age;

  BigPerson(this._sex, this.age);

  int mock() {
    return 10;
  }
}

///ImplicitPerson 相当于实现(implements)了ImplicitPerson隐式接口
///对于ImplicitPerson extension/implements BigPerson的情况下，ImplicitPerson接口中都会包含BigPerson隐式接口中的成员(方法和变量)
///同时对于extends BigPerson继承的情况下，ImplicitPerson类实现BigPerson隐式接口中的成员，默认是继承BigPerson类中的实现
///但是对于implements BigPerson的情况下，ImplicitPerson默认必须强制实现BigPerson隐式接口的成员
///这个接口包含了greet()方法,_name,count变量,getter(name)方法,以及还包含BigPerson接口中的_sex,age变量和mock()方法)
class ImplicitPerson extends BigPerson {
// class ImplicitPerson implements BigPerson{
  ///在接口中仅对当前library文件可见
  final String _name;
  final String count;

  String get name => _name;

  ///构造函数不包含在接口中
  ImplicitPerson(this._name, this.count) : super("", 11);

  ///包含在接口中，并对外可见
  String greet(String who) => "Hello, $who. I am $_name";

  ///implemens BigPerson的情况下，必须默认强制实现
// @override
// String get _sex => throw UnimplementedError();
//
// @override
// int get age => throw UnimplementedError();
//
// @override
// int mock() {
//   throw UnimplementedError();
// }
}

String greetBob(ImplicitPerson person) => person.greet("Bob");

class Impostor implements ImplicitPerson, Comparable<Impostor> {
  @override
  String get _name => "";

  @override
  String get name => _name;

  @override
  String get count => "10";

  @override
  String greet(String who) => "Hi $who. Do you know who I am?";

  ///还实现了BigPerson隐式接口中的方法
  @override
  String get _sex => "male";

  @override
  int get age => 22;

  @override
  int mock() => 1;

  @override
  int compareTo(Impostor other) => _name.compareTo(other._name);

  @override
  int get hashCode => Object.hashAll([_name]);

  @override
  bool operator ==(Object other) => other is Impostor && other._name == _name;

  ///dynamic类型的变量,调用了不存在的方法或者变量的情况下
  ///会触发noSuchMethod方法,可以重写该方法，来记录和跟踪这一行为
  ///否则会抛出NoSuchMethodError
  ///重写了noSuchMethod的情况下，子类没有实现ImplicitPerson接口都不会lint报错需要注意
  @override
  noSuchMethod(Invocation invocation) {
    LogUtils.d(
        "$this \ninvocation:${invocation.memberName}\n${invocation.runtimeType}");
  }

  static void testImplicitInterfaceAndNoSuchMethod() {
    LogUtils.d("隐式接口Implicitly interface.....");
    LogUtils.d(greetBob(ImplicitPerson("hoko", "100")));
    LogUtils.d(greetBob(Impostor()));
    assert(Impostor().compareTo(Impostor()) == 0);
    dynamic impostor = Impostor();
    impostor.noExistMethod();
    var a = impostor.noExistFieldGetter;
  }
}
