import 'package:flutter/material.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

class DartFunction extends StatelessWidget {
  const DartFunction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        MaterialButton(
            onPressed: _funcTest,
            child:
                Text("Dart中的函数", style: Theme.of(context).textTheme.headline6))
      ])
    ]);
  }

  void _funcTest() {
    var functionTest = FunctionTest();
    LogUtils.d(functionTest.isNoble(200));
    LogUtils.d(functionTest.isNoble(1000));
    LogUtils.d(functionTest.isNoble2(200));
    LogUtils.d(functionTest.isNoble2(1000));
    LogUtils.d(functionTest.isNoble3(200));
    LogUtils.d(functionTest.isNoble3(1000));

    LogUtils.d("----函数参数类型 命名参数-----");

    functionTest.paramFun(100, false, c: 3.22);
    functionTest.paramFun(22, true,
        c: 2.22, d: 9.99, e: "hello", f: null, g: null, obj: "dart");

    LogUtils.d("----函数参数类型 位置参数-----");
    functionTest.paramFun2(100, 1.33);
    functionTest.paramFun2(
        199, 9.32, 31.22, false, null, const Key("flutter"), Object());

    functionTest.doStuff();
    functionTest.doStuff(
        list: [4, 6, 5], map: {"a": null, false: 20, null: const Object()});

    LogUtils.d("----函数作为参数进行传递-----");
    functionTest.funcAcFuncParam();

    LogUtils.d("----匿名函数-----");
    functionTest.anonymousFunc();

    LogUtils.d("----变量作用域-----");
    functionTest.lexicalScopeFun();
  }
}

var topTopLevel = true;

class FunctionTest {
  ///dart中的函数类型
  ///Dart中一切皆对象，因此连函数也是对象,并且其类型为Function
  ///Function是所有函数类型的基类,函数对象的运行时类型是函数类型的子类型,也是[Function]的子类型。
  ///因此函数可以被赋值给一个变量或者作为其他函数的参数
  final Map<int, String> _nobleGases = {100: "Nan", 200: "NO2", 300: "NO1"};

  //定义一个函数
  bool isNoble(int type) {
    return _nobleGases[type] != null;
  }

  //也可以省略掉函数的返回值类型(不建议) 返回的类型为dynamic
  isNoble2(int type) {
    // return _nobleGases[type]!.isNotEmpty; //Null check operator used on a null value
    // return _nobleGases[type]?.isNotEmpty;  //type 'Null' is not a subtype of type 'Object'
    return _nobleGases[type]?.isEmpty != null;
  }

  //如果函数体只有一个表达式，可以省略掉大括号{}直接简写
  //语法=>表达式是{return 表达式;}的简写,=>也别称之为箭头函数
  //注意在=>与;之间只能是表达式而非语句
  bool isNoble3(int type) => _nobleGases[type] != null;

  //函数参数有两种形式:
  //必要参数:必要参数定义在参数列表前面
  //可选参数:可选参数定义在必要参数后面
  //可选参数又分为:命名参数(Named parameters)和位置参数(positional parameters)

  //paramFun:a b 为必要参数  c d e f g obj为可选参数中的命名参数
  //可选参数中的命名参数以 参数名 : 参数值 的方式进行调用
  //可选参数中的命名参数如果使用required标记的话就变成了必要参数,调用的时候必须传递值 ,且不能有默认值
  //可选参数中的命名参数如果是非空non-null的情况下，没有使用required标记的情况下，必须要有一个与之类型匹配的默认值,可空类型的默认值可有可无
  void paramFun(int a, bool b,
      {required double c,
      double d = 1.0,
      String? e,
      var f,
      dynamic g,
      Object obj = ""}) {
    LogUtils.d("a = $a b = $b c = $c d = $d e = $e f = $f g = $g obj = $obj");
    LogUtils.d("""
      a.type = ${a.runtimeType}
      b.type = ${b.runtimeType} 
      c.type = ${c.runtimeType} 
      d.type = ${d.runtimeType}
      e.type = ${e.runtimeType}
      f.type = ${f.runtimeType}
      g.type = ${g.runtimeType}
      obj.type = ${obj.runtimeType}
    """);

    //必要参数和命名参数在调用的时候传递参数的位置是可变的，这样可以让我们的函数调用看起来更合理
    repeat(times: 2, () => LogUtils.d("repeat 执行了.."));
  }

  void repeat(Function action, {required int times}) {
    if (times < 0) {
      throw Exception("times must be >= 0");
    }

    for (int i = 0; i < times; i++) {
      action();
    }
  }

  //paramFun2有两种参数类型:
  //a b 必要参数, c d e f obj为位置参数
  //位置参数调用不需要指定形式参数名称直接赋值即可
  //位置参数不能使用required进行标记
  //位置参数非空non-null的情况下,必须需要有一个默认值，否则可以可以定义成可空nullable或者var dynamic类型
  void paramFun2(int a, double b,
      [double c = 1.1,
      bool? d,
      var e,
      dynamic f,
      Object obj = const Object()]) {
    LogUtils.d("""
      a = $a
      b = $b
      c = $c
      d = $d
      e = $e
      f = $f
      obj = $obj      
    """);
  }

  //list map也可以做为默认值
  void doStuff(
      {List<int> list = const <int>[1, 2, 3],
      Map map = const <String, int>{"hoko": 22, "kobe": 39}}) {
    LogUtils.d("""
      list : $list
      list.runtimeType : ${list.runtimeType}
      map : $map
      map.runtimeType : ${map.runtimeType}
    """);
  }

  //dart中函数是一等公民,可以将函数当作参数传递给另外一个函数
  void printElement(int element) {
    LogUtils.d("element = $element");
  }

  void funcAcFuncParam() {
    var list = [1, 2, 3];
    //将printElement函数当作一个参数传递给forEach函数
    list.forEach(printElement);
    //也可以将函数赋值给一个变量
    // var loudify = (String msg) => msg.toUpperCase(); //定义局部函数的时候,建议不要将函数赋值给一个变量，而是定义局部函数的形式来使用
    String loudify(String msg) => msg.toUpperCase();
    assert(loudify("hello") == "HELLO");
  }

  //匿名函数anonymous Function
  //Dart中支持定义匿名函数(Lambda表达式,Closure闭包)，可以将匿名函数赋值给一个变量并使用它
  void anonymousFunc() {
    const list = ["a", "b", "c"];

    list.forEach((element) {
      //性能问题，不建议这种使用forEach配合匿名函数的使用方式
      LogUtils.d("${list.indexOf(element)} : $element");
    });

    //对于函数体只有一行返回语句的情况，可以直接使用=>胖箭头的形式进行简写
    list.forEach(
        (element) => LogUtils.d("${list.indexOf(element)} : $element"));
  }

  //变量作用域:Dart的作用域和java类似
  bool topLevel = true;
  void lexicalScopeFun() {
    var insideLexical = true;

    void myFunction() {
      var insideMyFunction = true;
    //nestedFunction()函数可以访问包括顶层变量以内的所有变量
      void nestedFunction() {
        var insideNestedFunction = true;
        assert(topTopLevel);
        assert(topLevel);
        assert(insideLexical);
        assert(insideMyFunction);
        assert(insideNestedFunction);
      }
      nestedFunction();
    }
    myFunction();
  }

  //https://www.ruanyifeng.com/blog/2009/08/learning_javascript_closures.html
  //闭包(Closure)

}
