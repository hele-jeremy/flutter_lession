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
    _test3();
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

Future<String> fetchUserOrder3() =>
    // Future.delayed(const Duration(seconds: 4), () => "large latte!");
    ///也可以抛出异常
    Future.delayed(
        const Duration(seconds: 4), () => throw "Cannot locate uesr order!!!");

Future<void> printOrderMessage() async {
  ///在异步函数中，可以像在同步代码中一样编写try-catch子句。
  try {
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
