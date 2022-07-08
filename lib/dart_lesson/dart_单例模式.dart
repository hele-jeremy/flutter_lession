import 'package:flutter_lesson/dart_lesson/dart_%E7%B1%BBclass.dart';

///使用factory工厂构造方法实现单例模式
class MySingleton {
  num _count;

  set count(num value) => _count = value;

  //定义一个静态私有的MySingleton对象常量
  static final MySingleton _factoryClass = MySingleton._internal(0);

  //_下划线创建一个私有private的命名构造函数(named constructor)
  MySingleton._internal(this._count);

  //工厂构造函数
  factory MySingleton() => _factoryClass;

  //命名工厂构造函数
  factory MySingleton.fronCount(int count) {
    //factory严格意义上并不是构造函数，因为其方法体内不能够访问this,只是为了调用该方法的时候就像调用普通构造函数一样
    //而不用关心到底是返回了一个新建的对象还是一个缓存的对象
    return _factoryClass..count = count;
    // return MySingleton._internal(count);
  }

  @override
  String toString() => 'MySingleton{count: $_count}';
}

class OutImpostor implements ImplicitPerson{
  @override
  String greet(String who) => who;

  // @override
  // String get name => toString();
}
