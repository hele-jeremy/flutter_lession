import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_lesson/dart_lesson/dart_%E5%BC%82%E5%B8%B8.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

///Dart中的异步支持

class DartAsyncAwaitFuture extends StatelessWidget {
  const DartAsyncAwaitFuture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dart中的async,await,Future"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              MaterialButton(
                  onPressed: _dartAsync,
                  child: Text("dart异步",
                      style: Theme.of(context).textTheme.headline6))
            ]))
      ]),
    );
  }

  void _dartAsync() {
    // _test1();
    // _test2();
    // _test3();
    // _test4();
    // _test5();
    // _test6();
    // _test7();
    // _test8();
    // _test9();
    // _test10();
    // _test11();
    _test12();
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
  // return Future.value(throw Exception("error from two"));
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
  LogUtils.d("five future error handling.............................");
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

///Future处理特定类型的异常
class AuthNameIlleagalException implements Exception {}

class AgeArgumentError extends Error {}

var _testCount = 0;

Future<Map<String, Object>> handleAuthResponse(Map<String, Object> authData) {
  ///在handleAuthResponse方法内部，不是通过Future抛出的异常，是不会被下游Future的catchError给捕获到的
  // throw AuthNameIlleagalException();
  // throw AgeArgumentError();
  // return Future.delayed(const Duration(seconds: 2), () => authData);
  var ret = ++_testCount % 3;
  return Future.delayed(const Duration(seconds: 1), () {
    if (ret == 0) {
      throw AuthNameIlleagalException();
    } else if (ret == 1) {
      throw AgeArgumentError();
    } else {
      throw TestIllegalArgumentException();
    }
  });
}

void _test6() {
  LogUtils.d("six Future handle spcific error..................");
  handleAuthResponse(const {"userName": "hoko", "age": 3})
      .then((value) => value)
      .catchError((err, stackTrace) {
    LogUtils.d("handle auth error: $err");

    /// catchError在onError中捕获异常了以后，同时需要返回一个和上游Future类型一样的Future,否则在运行时会抛出一个异常
    return <String, Object>{};

    ///通过test来指定catchError处理指定类型的异常
  }, test: (err) => err is AuthNameIlleagalException).catchError(
          (err, stackTrace) {
    LogUtils.d("handle age error : $err");
    return <String, Object>{};
  }, test: (err) => err is AgeArgumentError).catchError((err, stackTrace) {
    LogUtils.d("handle other common error: $err");
    return <String, Object>{};
  })

      ///无论上游的Future是成功还是失败，whenCompleted都会执行
      ///可以在里面执行释放，资源回收等一定需要执行的操作
      .whenComplete(() => LogUtils.d("handle auth response completed"));
}

///whenCompleted的错误处理
void _test7() {
  two()
      .then((value) => LogUtils.d("two then value : $value"))

      ///whenCompleted的Future以two()的error完成(complete wieh a error)，同时会回调whenCompleted注册的回调(这个和then不同,then不会回调注册的callback)
      .whenComplete(() => LogUtils.d("two then whenCompletd....."))
      .then(
          (value) => LogUtils.d("two then whenCompleted then value ....void}"))
      .catchError((err, stackTrace) {
    LogUtils.d("test7 handle error : $err");
  });

  LogUtils.d("------------------------------------------");
  two()
      .then((value) => LogUtils.d("************two then value $value"))
      .catchError((err, stackTrace) {
    LogUtils.d("************two then catchError handle error $err");
    // ignore: invalid_return_type_for_catch_error
    return "catchError complete with a new value";

    ///whenCompleted是以catchError的Future(complete with a value)来完成的
    // ignore: void_checks
  }).whenComplete(() {
    LogUtils.d("************two then catchError whenCompleted....");
    throw Exception("new exception from whenCompelted...");
  }).catchError((err, stackTrace) {
    LogUtils.d("************catch error from whenCompelted:$err");
  });
}

///future的错误处理方式
void _test8() {
  ///在接收到Future消息后500毫秒才附加错误处理程序。如果future在此之前失败，
  ///则将错误转发给全局错误处理程序（global error-handler），即使有最终处理错误(catchError)的代码(就在下面)。
  var futureTwo = two();

  Future.delayed(const Duration(milliseconds: 500), () {
    ///先调用two()方法生成一个Future对象,然后再去使用catchError进行错误的处理
    ///错误是不会被catchError捕获的,而是应该在Future.delayed里面进行错误的捕获(future的错误处理越早越好)
    futureTwo
        // two()
        .then((value) => LogUtils.d("futureTwo then..."))
        .catchError((err, stackTrace) {
      LogUtils.d("futureTwo catchError....$err");
    });
  });

  Timer(const Duration(milliseconds: 5), () {
    LogUtils.d("timer excuted....");
  });
}

///Future的同步和异步错误处理

String obtainFileName(Map<String, dynamic> data) {
  throw Exception("error from obtain file name....");
  // return data["fileName"];
}

Future<String> obtainFileNameSuffix(String name, String suffix) {
  return Future.delayed(
      const Duration(microseconds: 100), () => "$name.$suffix");
}

int parseFileData(String content) {
  throw Exception("parse file data error....");
  return content.length;
}

Future<int> parseAndRead(Map<String, dynamic> data) {
  ///obtainFileName方法抛出的异常，由于其没有注册catchError错误处理回调(其返回值是一个String)
  ///因此当其出现异常的时候,会同步的抛出一个异常，并且这个异常是不会被parseAndRead方法的Future的
  ///catchError给捕获的
  final fileName = obtainFileName(data);

  return obtainFileNameSuffix(fileName, ".jpg").then((value) {
    ///虽然parseFileData方法也会抛出异常，但是它的异常不会泄漏(leak)到外部，而是会被then的Future返回的错误
    ///来完成(completed with an error)同理parseAndRead方法的catchError会捕获到该error(completed with an error)
    return parseFileData(value);
  });
}

Future<int> parseAndRead2(Map<String, dynamic> data) {
  ///确保函数不会意外抛出同步(sync)错误的常见模式是将函数体包装在新的 Future.sync() 回调中
  return Future.sync(() {
    var fileName = obtainFileName(data);
    return obtainFileNameSuffix(fileName, ".png").then((value) {
      return parseFileData(value);
    });
  });
}

void _test9() {
  ///外部的parseAndRead方法为了捕获抛出的同步异常,必须使用try..catch来捕获异常
  try {
    parseAndRead(const {"fileName": "hello"}).catchError((err, stackTrace) {
      LogUtils.d("inside catch error....$err!");
      return -1;
    }).whenComplete(() => LogUtils.d("parseAndRead completed....!"));
  } catch (err) {
    LogUtils.d("parseAndRead handle error outside : $err");
  }

  LogUtils.d("-----------------------------------------");
  parseAndRead2(const {"fileName": "flutter first"})

      ///可以处理parseAndRead2里面的所有的异常
      ///Future.sync() 不仅允许您处理您知道可能发生的错误，还可以防止错误意外泄漏到您的函数中(简单理解类似给Future加了一个try..catch..)
      .catchError((err, stackTrace) {
    LogUtils.d("parseAndRead2 handle error : $err");
    return 22;
  }).whenComplete(() => LogUtils.d("parseAndRead2 completed....."));
}

///多个Future结果的等待

void _test10() {
  num ret = 0;
  Future.wait([
    Future.delayed(const Duration(seconds: 2), () {
      LogUtils.d("future 1....");
      return 100;
    }),
    Future.value(200)
  ]).then((value) => LogUtils.d("Future.wait result : $value"));
}

//Dart中Future的回调地狱(callback hell)消除

class HellUser {
  final String userName;
  final String phone;

  HellUser({required this.userName, required this.phone});

  HellUser.from(Map<String, String> data)
      : this(userName: data["name"]!, phone: data["phone"]!);

  @override
  String toString() {
    return 'HellUser{userName: $userName, phone: $phone}';
  }
}

Future<String> login(String userName, String pwd) {
  return Future.delayed(const Duration(seconds: 1), () {
    LogUtils.d("user:$userName : $pwd login...!");
    return "1000010001";
  });
}

Future<Map<String, String>> fetchUserInfo(String userId) {
  return Future.delayed(const Duration(seconds: 2), () {
    LogUtils.d("fetchUserInfo by id:$userId");
    return <String, String>{"name": "hoko", "phone": "13528459546"};
  });
}

Future<void> saveUserInfoToLocal(HellUser user) {
  return Future(() {
    LogUtils.d("save helluser to local:$user");
  });
}

void _test11() {
  //回调地狱的调用方式
  // login("hoko", "3213")
  //     .then((userId) {
  //       fetchUserInfo(userId)
  //           .then((userInfo) {
  //             saveUserInfoToLocal(HellUser.from(userInfo))
  //                 .then((value) => LogUtils.d("saveUserInfo success...!"))
  //                 .then((value) => LogUtils.d("then..........C"))
  //                 .catchError(
  //                     (err, stackTrace) => LogUtils.d("saveUserInfo faile...!"))
  //                 .whenComplete(() => LogUtils.d("saveUserInfo done!"));
  //           })
  //           .then((value) => LogUtils.d("then ......... A"))
  //           .whenComplete(() => LogUtils.d("completed ....... A"));
  //     })
  //     .then((value) => LogUtils.d("then ........."))
  //     .whenComplete(() => LogUtils.d("completed ..........."));

  LogUtils.d("---------------------------------------------");
  //使用Future所有方法api都是返回一个Future的特点来解决回调地狱
  login("hoko", "3213")
      .then((userId) {
        ///在then中返回了一个Future,相当于把这个Future任务添加进了微任务(microTask queue)优先级最高
        return fetchUserInfo(userId)
            .then((userInfo) {
              return saveUserInfoToLocal(HellUser.from(userInfo))
                  .then((value) => LogUtils.d("saveUserInfo success...!"))
                  .then((value) => LogUtils.d("then..........C"))
                  .catchError(
                      (err, stackTrace) => LogUtils.d("saveUserInfo faile...!"))
                  .whenComplete(() => LogUtils.d("saveUserInfo done!"));
            })
            .then((value) => LogUtils.d("then ......... A"))
            .whenComplete(() => LogUtils.d("completed ....... A"));
      })
      .then((value) => LogUtils.d("then ........."))
      .whenComplete(() => LogUtils.d("completed ..........."));
}

//通过使用async / await的方式来解决回调地狱(callback hell)的问题
Future<void> _test12() async {
  try {
    LogUtils.d("save userInfo begin...!");
    var userId = await login("lebron", "f32424224");
    var userInfo = await fetchUserInfo(userId);
    await saveUserInfoToLocal(HellUser.from(userInfo));
    LogUtils.d("save userInfo done...!");
  } catch (err, stackTrace) {
    LogUtils.d("save userInfo error...!");
  }
}
