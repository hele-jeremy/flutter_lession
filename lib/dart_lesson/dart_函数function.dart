import 'package:flutter/material.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

class DartFunction extends StatelessWidget {
  const DartFunction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dart中的函数"),
        centerTitle: true,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          MaterialButton(
              onPressed: _funcTest,
              child: Text("Dart中的函数",
                  style: Theme.of(context).textTheme.headline6))
        ]),
        Container(
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              MaterialButton(
                  onPressed: _typeDefTest,
                  child: Text(
                    "类型别名typedef",
                    style: Theme.of(context).textTheme.headline6,
                  ))
            ]))
      ]),
    );
  }

  void _funcTest() {
    var functionTest = FunctionTest();
    LogUtils.d(functionTest.isNoble(200));
    LogUtils.d(functionTest.isNoble(1000));
    LogUtils.d(functionTest.isNoble2(200));
    LogUtils.d(functionTest.isNoble2(1000));
    LogUtils.d(functionTest.isNoble3(200));
    LogUtils.d(functionTest.isNoble3(1000));
    functionTest.wrapPrint("testPrint");
    var simplifyTest = functionTest.simplifyTest(true);
    //打印test()方法的类型为set集合类型所以例子中的 => 和 ; 之间依然是一个表达式
    LogUtils.d(
        "simplifyTest : $simplifyTest simplifyTest.runtimeType = ${simplifyTest.runtimeType}");

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

    LogUtils.d("----闭包Closure-----");
    functionTest.closureTest();

    LogUtils.d("----函数相等性-----");
    functionTest.funcEqualsTest();

    LogUtils.d("----函数返回值-----");
    functionTest.funcRetrunValueTest();

    LogUtils.d("----类型别名typedef-----");
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
  //注意在=>与;之间只能是表达式而非语句 比如 => 和 ; 之间不能放 if 语句，但可以放 条件表达式(condition ? expr1 : expr2)
  // 但是经过测试发现 => 和 ; 之间可以放一条非控制流语句，如：
  // ignore: avoid_print
  wrapPrint(String msg) => print("::$msg");

  ////上面提到 => 和 ; 之间不能放 if语句, 可能开发者在把普通函数改成箭头函数忘记了删除花括号{}
  //这不是使用了 if表达式 了吗？但是下面的例子 => 和 ; 之间其实是一个 Set 集合, {}不仅在定义函数的时候用到，
  // 在构建 Set、Map集合字面量 的时候也用到了，然后在构建 Set 字面量的时候使用 if 语句而已(collection if-for)
  simplifyTest(bool flag) => {
        // if (flag) {LogUtils.d("success")} //注意有{}表示的是set或者map这里要去掉{}才能表示添加一个非set/map类型的元素到set集合中
        if (flag) LogUtils.d("success")
      }; //{{null}} simplifyTest.runtimeType = _CompactLinkedHashSet<Set<void>>  / {null} simplifyTest.runtimeType = _CompactLinkedHashSet<void>

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
  // 1. Lexical scope
// Lexical scope 也称之为 静态作用域(Static Scope), 也就是说变量的作用域是静态确定的
// 外部不能访问内部作用域的变量, 但是内部作用域可以访问外部作用域的变量
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

  //  相对地, 有 Static Scope 就有 Dynamic Scope , 动态作用域就是说变量的作用域是动态确定的
  // void fun() {
  //   print("x = $x");
  // }
  //
  // void dummy1() {
  //   int x = 5;
  //   fun();
  // }
//  例如上面的代码, 在 fun 函数中并没有定义 x 变量, 该变量在 dummy1 函数中定义了, dummy1 函数调用了 fun 函数,所以 fun 函数中使用的 x 变量就是 dummy1 函数的中 x

  //https://www.ruanyifeng.com/blog/2009/08/learning_javascript_closures.html
  //https://flutter.cn/community/tutorials/deep-dive-into-dart-s-function-closure
  //https://cloud.tencent.com/developer/article/1644633
  //Lexical closures
  //闭包(Closure) :closures 可以理解为一个匿名函数, 它可以访问它自己的作用域内的变量, 哪怕变量已经超过了外部函数的作用域
  //makeAdder函数，接收一个int类型的参数，返回一个Function即函数
  Function makeAdder(int addBy) {
    return (int i) => addBy + i;
  }

  void closureTest() {
    //add add2的类型都是函数类型 表达方式为: (参数类型) => 返回值类型
    var add = makeAdder(10); //(int) => int  add相当于一个这种函数: (int i) => i + 10;
    var add2 = makeAdder(20); //(int) => int  add2相当于一个这种函数: (int i) => i + 20
    var add3 = Function.apply(
        makeAdder, [30]); //(int) => int add3相当于一个这种函数 (int i) => i + 30;

    LogUtils.d("add(2) = ${add(2)} add.runtimeType =  ${add.runtimeType}");
    LogUtils.d("add2(10) = ${add2(10)} add2.runtimeType = ${add2.runtimeType}");
    LogUtils.d("add3(10) = ${add3(10)} add3.runtimeType = ${add3.runtimeType}");
    LogUtils.d(
        "Function.apply(makeAdder, [10]) ${Function.apply(makeAdder, [10])}");
    LogUtils.d("Function.apply(add2, [10]) ${Function.apply(add2, [10])}");
    //函数的调用方式
    assert(add(2) == 12); //简写方式
    assert(add2.call(10) == 30); //通过call()方式调用
    assert(Function.apply(add3, [2]) == 32); //通过Function.apply()静态方法来调用
  }

//函数相等性测试
  void funcEqualsTest() {
    Function x;
    x = topTopLevelFunc;
    assert(x == topTopLevelFunc);

    x = FunctionEqualsTest.sFunc;

    assert(FunctionEqualsTest.sFunc == x);

    var a = FunctionEqualsTest();
    var b = FunctionEqualsTest();

    var c = b;

    x = b.func;
    assert(c.func == x);

    assert(c.func != a.func);

    LogUtils.d("""
            topTopLevelFunc : ${topTopLevelFunc.runtimeType}
            FunctionEqualsTest.sFunc : ${FunctionEqualsTest.sFunc.runtimeType}
            a.func : ${a.func.runtimeType}
    """);
  }

  //函数的返回值
  //dart中函数如果没有显式的返回语句,最后一行默认认为执行return null
  rFunc1() {}

  //void 是一个例外，不会默认返回null
  void rFunc2() {}

  Function rFunc3() => (int i) => i * i;

  rFunc4() => "hello";

  double rFunc5() {
    return 43.22;
  }

  dynamic rFunc6() {}

  dynamic rFunc7() {
    return "dart";
  }

  rFunc8() {
    return "flutter";
  }

  String? rFunc9() {
    "default";
  }

  void funcRetrunValueTest() {
    LogUtils.d("rFunc1() : ${rFunc1()}");
    // LogUtils.d("rFunc2() : ${rFunc2()}");  //This expression has a type of 'void' so its value can't be used
    LogUtils.d("rFunc3() : ${rFunc3()}");
    LogUtils.d("rFunc4() : ${rFunc4()}");
    LogUtils.d("rFunc5() : ${rFunc5()}");
    LogUtils.d("rFunc6() : ${rFunc6()}");
    LogUtils.d("rFunc7() : ${rFunc7()}");
    LogUtils.d("rFunc8() : ${rFunc8()}");
    LogUtils.d("rFunc9() : ${rFunc9()}");
  }
}

void topTopLevelFunc() {}

class FunctionEqualsTest {
  static void sFunc() {}

  void func() {}
}

///类型别名typedef:类型别名是引用某一类型的简便方法，因为其使用关键字 typedef，因此通常被称作 typedef。
typedef IntList = List<int>; //定义一个类型为List<int>的类型
typedef ListMapper<X> = Map<X, List<X>>; //typedef也可以有泛型的类型参数
typedef Compare<T> = int Function(T a, T b); //typedef表示函数的类型

int _sort(int a, int b) => a - b;

void _typeDefTest() {
  IntList i1 = [for (int i = 0; i < 5; i++) i * i];
  LogUtils.d("i1 = $i1");
  assert(i1 is List<int>);

  ListMapper<String> m1 = {
    for (int i2 = 0; i2 < 5; i2++) "key-$i2": ["list-item-$i2"]
  };
  LogUtils.d("m1:\n$m1");
  assert(m1 is Map<String, List<String>>);

  assert(_sort is Compare<int>);
}

class _Event {}

///在一般情况下，我们 优先使用内联函数类型，而后是 typedef
///如果函数类型特别长或经常使用，那么还是有必要使用 typedef 进行定义。
///但在大多数情况下，使用者更希望知道函数使用时的真实类型，这样函数类型语法使它们清晰。
class FilteredObservable {
  final bool Function(_Event) _predicate; //定义了一个函数类型 返回值为bool 接受参数为_Event
  final List<void Function(_Event)>
      _observers; //定义了一个List类型，定义元素泛型为函数类型:返回值为void 接受参数为_Event

  FilteredObservable(this._predicate, this._observers);

  //定义一个函数notify，返回值为函数类型(nullable)其返回值为void,接收一个_Event类型的参数
  void Function(_Event)? notify(_Event event) {
    if (!_predicate(event)) return null;

    void Function(_Event)? last;
    for (final observer in _observers) {
      observer(event);
      last = observer;
    }

    return last;
  }

  //定义函数参数也可以使用,Function同时可以使用泛型
  Iterable<T> where<T>(bool Function(T) predicate, T value) {
    if (predicate(value)) {
      return [value];
    }
    return [];
  }
}
