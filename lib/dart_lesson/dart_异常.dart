import 'package:flutter/material.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

///dart中的异常
///Dart 代码可以抛出(throw / rethrow)和捕获(catch)异常。异常表示一些未知的错误情况，如果异常没有捕获则会被抛出从而导致抛出异常的代码终止执行。
/// 与 Java 不同的是，Dart 的所有异常都是非必检异常，方法不必声明会抛出哪些异常，并且你也不必捕获任何异常。
/// Dart 提供了 Exception 和 Error 两种类型的异常以及它们一系列的子类，你也可以定义自己的异常类型。但是在 Dart 中可以将任何非 null 对象作为异常抛出而不局限于 Exception 或 Error 类型。

class DartException extends StatelessWidget {
  const DartException({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MaterialButton(
                onPressed: _dartExcption1,
                child: Text("Dart中的异常",
                    style: Theme.of(context).textTheme.headline6))
          ]))
    ]);
  }

  void _dartExcption1() {
    //抛出异常
    // throw const FormatException("illegal format..!");

    //同时也是可以抛出任意的对象(非null对象)
    // throw null; //null不允许抛出
    // throw "out of memory";
    // throw 3.22;

    //虽然dart允许我们抛出初null以外的任意对象，但是在需要抛出异常的地方
    //最佳的做法是抛出Exception或者Error类型的异常

    // excepTest();

    //捕获异常
    _testCatchExcep();
  }

  //抛出异常是一个表达式操作，因此可以在=>语句中使用
  //同时也是可以在任何使用表达式的地方抛出异常
  void excepTest() => throw UnimplementedError("not implementation yet!");

  void excepTest2(int value) {
    if (value < 0) throw TestIllegalArgumentException();
    switch (value) {
      case 0:
      case 1:
        throw FormatException("$value format is invalid..!");
      case 2:
        throw value;
      default:
        throw UnimplementedError(
            "The specific operation has not been implemented!");
    }
  }

  void _testCatchExcep() {
    //可以使用  on或者catch来捕获异常，使用on来指定异常类型，使用catch来捕获异常对象，且两者可以同时使用
    try {
      // excepTest2(-3);
      excepTest2(3);
      // excepTest2(1);
      // excepTest2(2);
    } on UnimplementedError {
      LogUtils.d("捕获了一个未实现操作的异常..!");
      rethrow; //也可以使用rethrow将异常重新抛出
    } on TestIllegalArgumentException {
      LogUtils.d("输入参数异常..!");
    } on Exception catch (e, s) {
      LogUtils.d("捕获了一个Exception detail: $e\nstackTrace: $s");
    } catch (e, s) {
      //catch可以指定两个参数 Exception StatckTrace
      LogUtils.d("未知异常: $e\nstackTrace: $s");
    } finally {
      //无论是否抛出异常，finally代码块里面的语句一定会执行
      LogUtils.d("excute resource recycling..!");
    }
  }
}

class TestIllegalArgumentException implements Exception {}
