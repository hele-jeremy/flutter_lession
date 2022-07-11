import 'package:flutter/material.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

///继承Extensions:
///实现implements:
///混合:mixin

class DartExtensionImplementsMixin extends StatelessWidget {
  const DartExtensionImplementsMixin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MaterialButton(
                onPressed: _extensionTest,
                child: Text("继承Extension",
                    style: Theme.of(context).textTheme.headline6))
          ])),
      Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MaterialButton(
                onPressed: _implementsTest,
                child: Text("实现implements",
                    style: Theme.of(context).textTheme.headline6))
          ])),
      Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MaterialButton(
                onPressed: _mixinTest,
                child: Text("混合mixin",
                    style: Theme.of(context).textTheme.headline6))
          ]))
    ]);
  }

  void _extensionTest() {}

  void _implementsTest() {}

  void _mixinTest() {
    testAnimalMixin();
    testMultiMixin();
    testMixinConstraint();
    testMixinDefindFieldAndMethod();
  }
}

///mixin关键字在dart2.1中才被引入，之前版本中是用abstract class代替
mixin Walker {
  void walk() {
    LogUtils.d("$runtimeType - walk");
  }
}
mixin Flyer {
  void fly() {
    LogUtils.d("$runtimeType - fly");
  }
}

class Animal {}

class Mammal extends Animal {}

class Bird extends Animal {}

class Cat extends Mammal with Walker {}

class Dove extends Bird with Walker, Flyer {}

void testAnimalMixin() {
  var cat = Cat();
  var dove = Dove();

  cat.walk();

  /// cat.fly(); cat不能fly，因为没有mixin混入Flyer的方法
  dove.walk();
  dove.fly();
}

mixin A {
  String getMessage() => "$runtimeType - A";
}

mixin B {
  String getMessage() => "$runtimeType - B";
}

class P {
  String getMessage() => "$runtimeType - P";
}

///AB类继承自P 同时mixin了 A B 相当于以下的一个关系
/// class PA = P with A
/// class PAB = PA with B
/// class AB extends PAB
class AB extends P with A, B {}

///BA类继承P 同时mixin了 B A 相当于以下的一个关系
///class PB = P with B
///class PBA = PB with A
///class BA extends PBA
class BA extends P with B, A {}

void testMultiMixin() {
  var ab = AB();
  var ba = BA();
  var result = StringBuffer()
    ..write(ab.getMessage())
    ..write(" | ")
    ..write(ba.getMessage());
  LogUtils.d("result = $result");

  ///mixin的类型
  assert(ab is P);
  assert(ab is A);
  assert(ab is B);
  assert(ba is P);
  assert(ba is A);
  assert(ba is B);
}

//mixin的super超类限定
abstract class Super {
  void method() {
    ///Super的父类Object没有method()方法
    // super.method(); //The method 'method' isn't defined in a superclass of 'Super'
    LogUtils.d("$runtimeType : super method");
  }
}

class MySuper implements Super {
  @override
  void method() {
    ///MySuper实现了Super类的隐式接口,接口中的method()方法是抽象方法,因此无法通过super.method()进行调用
    // super.method(); //The method 'method' is always abstract in the supertype.
    LogUtils.d("$runtimeType : mySuper method");
  }
}

class AM {}

class BM {}

mixin Mx {}

///通过关键字on来指定,哪些类能够使用当前的mixin
///on Super的意思是指，只有继承Super或者实现Super(隐式接口)的类才能够使用该mixin
mixin Mixin on Super implements AM, BM {
// mixin Mixin on Super{
  @override
  void method() {
    super.method();
    LogUtils.d("$runtimeType : mixin method");
  }
}

// class Blame with Mixin implements Super  {  //'Mixin' can't be mixed onto 'Object' because 'Object' doesn't implement 'Super'
class Blame with Mx implements Super {
  @override
  void method() {}
}

///通过mixin的线性(linear)的继承关系，梳理出以下的继承关系图
/// class MySuper implements Super (MySuper从Super隐式接口中获得了method(只得到了方法名没有得到具体实现))
/// class MySuper_Mixin = MySuper with Mixin(匿名类MySuper_Mixin继承了MySuper得到了method方法(方法名和具体实现)，同时实现了Mixin隐式接口得到了method方法(名称和具体实现))
/// class Client exends MySuper_Mixin
class Client extends MySuper with Mixin {
  @override
  void method() {
    LogUtils.d("$runtimeType : client method");
    super.method();
  }
}

void testMixinConstraint() {
  LogUtils.d("---------------------------------------------");
  Client().method();

  ///mixin类型是不能直接被实例化的
  // var mixin = Mixin(); //Mixins can't be instantiated.
}

///mixin中定义方法 变量
mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      LogUtils.d("Playing piano");
    } else if (canCompose) {
      LogUtils.d("Waving hands");
    } else {
      LogUtils.d("Humming to self");
    }
  }
}

class Performer {}

class Musician extends Performer with Musical {}

class Maestro extends Performer with Musical {
  final String name;

  Maestro(this.name) {
    canPlayPiano = true;
  }

  @override
  void entertainMe() {
    LogUtils.d("$runtimeType : $name");
    super.entertainMe();
  }
}

void testMixinDefindFieldAndMethod(){
  LogUtils.d("---------------------------------------------");
  Musician().entertainMe();
  Maestro("Mike").entertainMe();
}
