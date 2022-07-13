import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

///Dart中的异步支持

class DartAsync extends StatelessWidget {
  const DartAsync({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MaterialButton(
                onPressed: _dartAsync,
                child: Text("dart异步",
                    style: Theme.of(context).textTheme.headline6))
          ]))
    ]);
  }

  void _dartAsync() {
    // _test1();
    // _test2();
    // _test3();
    // _test4();
    _test5();
  }
}

///异步编程通常使用回调方法来实现,但在dart中提供了其他的方案:Future 和  Stream
///Future代表将来的某一个时刻会返回一个结果,Stream可以用来获取一系列的值,比如，一系列的事件
///但是实现异步编程不仅仅可以是Future/Stream，也可以是async/await来实现

Future<String> fetchUserOrder() =>
    Future<String>.delayed(const Duration(seconds: 2), () => "Large latte");

String createOrderMessage() {
  ///返回的是一个Future对象：表示的是一个未完成等待执行结果的Future对象
  var userOrder = fetchUserOrder();
  return "Your order is $userOrder";
}

/// 同步操作:同步操作阻止其他操作的执行，直到它完成。
/// 同步函数:同步函数只执行同步操作。
/// 异步操作:异步操作一旦启动，就允许在它完成之前执行其他操作。
/// 异步函数:异步函数至少执行一个异步操作，也可以执行同步操作。

///什么是future?
/// future(小写“f”)是Future类的一个实例。future表示异步操作的结果，可以有两种状态:完成 未完成
///未完成:当您调用异步函数时，它返回一个未完成的future。该future等待函数的异步操作完成或抛出错误。
///完成:如果异步操作成功，future将以一个值完成。否则，它将以一个错误结束。
///
///使用async和await时的两个基本准则:
/// 要定义一个async函数，请在函数体之前添加async:
/// await关键字仅在异步函数中有效。

/// await 表达式的返回值通常是一个 Future 对象；如果不是的话也会自动将其包裹在一个 Future 对象里。
/// Future 对象代表一个“承诺”， await 表达式会阻塞直到需要的对象返回。

void _test1() {
  ///打印的结果不符合我们的预期:Your order is Large latte
  LogUtils.d(createOrderMessage()); //Your order is Instance of 'Future<String>'
}

//将上面的同步(sync)代码改造成异步(async)
Future<String> fetchUserOrder2() =>
    Future.delayed(const Duration(seconds: 2), () => "Large latte!");

///使用async标记一个函数为异步函数
Future<String> createUserOrder2() async {
  ///使用await来等待获得异步表达式的结果(成功或者失败)
  ///await关键字只在异步函数中工作
  var userOrder2 = await fetchUserOrder2();
  return "create user order $userOrder2";
}

void _test2() async {
  LogUtils.d("--------------------------------");
  var orderResult = await createUserOrder2();
  LogUtils.d("user order result $orderResult");
}

///async函数会同步(sync)运行，直到执行到第一个await关键字。
///这意味着在异步(async)函数体中，在第一个await关键字之前的所有同步(sync)代码都会立即执行。

Future<String> fetchUserOrder3() {
  LogUtils.d("excute fetchUserOrder3....!");
  return Future.delayed(const Duration(seconds: 4), () => "large latte!");

  ///也可以抛出异常
  // Future.delayed(const Duration(seconds: 4), () => throw "Cannot locate uesr order!!!");
}

Future<void> printOrderMessage() async {
  ///在异步函数中，可以像在同步代码中一样编写try-catch子句。
  try {
    ///async函数体中的Future结果必须使用await来等待Future结果或标记为unawaited显式的忽略结果
    unawaited(fetchUserOrder3());
    var userOrder = await fetchUserOrder3();
    LogUtils.d("Awaiting user order....");
    LogUtils.d("Your order is $userOrder");
  } catch (err) {
    LogUtils.d("Caught error: $err");
  }
}

void _countSeconds(int seconds) {
  for (var i = 1; i <= seconds; i++) {
    Future.delayed(Duration(seconds: i), () => LogUtils.d("i = $i"));
  }
}

void _test3() async {
  LogUtils.d("-----------------------------------------------");
  _countSeconds(4);
  await printOrderMessage();
}

///Future的使用和错误处理
Future<int> myFunc() {
  LogUtils.d("myFunc execute....!");

  ///抛出异常
  return Future.delayed(const Duration(seconds: 2),
      () => throw ArgumentError("myFunc argument illegal...!"));

  // return Future.delayed(const Duration(seconds: 2), () => Future.value(100));
}

void _test4() {
  LogUtils.d("_test4--------------------------");
  myFunc().then((value) {
    LogUtils.d("then value = $value");

    ///then中接收处理了myFunc的成功值(completed value),然后then中抛出了一个异常
    // throw Exception("then process error....!");
  }, onError: (err, stackTrace) {
    //一般不建议注册多个错误处理回调
    ///then中注册了一个error错误处理回调,然后then的onError错误处理回调，先自己处理了myFunc的error
    LogUtils.d("then handle error...!");

    ///然后再重新抛出了一个异常,这个异常被下游的catchError处理
    throw Exception("then onError throw another error...!");
  }).catchError((err, stackTrace) {
    LogUtils.d("catchError .....!");
    LogUtils.d("err:$err\n$stackTrace");
  });
}

Future<String> one() {
  LogUtils.d("one excute...!");
  return Future.value("from one");
}

Future<String> two() {
  LogUtils.d("two excute...!");
  return Future.error("error from two");
}

Future<String> three() {
  LogUtils.d("three excute....!");
  return Future.value("from three");
}

Future<String> four() {
  LogUtils.d("four excute...!");
  return Future.value("from four");
}

void _test5() {
  one() //以一个值完成(completed a value)
      .then((_) => two()) //以一个错误完成(complete a error)
      .then((_) => three()) //以two的error完成(completed a error form two)
      .then((_) => four()) //以two的error完成(completed a error form two)
      .then((value) => value.length) //以two的error完成(completed a error form two)
      .catchError((err, stackTrace) {
    LogUtils.d("Got error:$err"); //捕获了two的error
    ///重新以42完成(Future completed with a value)
    return 42;
  }).then((value) => LogUtils.d("The value is $value"));
}
