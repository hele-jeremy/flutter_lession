import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

///Dart异步之Stream
///Stream 提供一个异步的数据序列
///可以使用 Stream API 中的 listen() 方法和 await for 关键字来处理一个 Stream
///Stream 有两种类型：Single-Subscription 和 Broadcast
///Stream 是一系列异步事件的序列。其类似于一个异步的 Iterable，不同的是当你向 Iterable 获取下一个事件时它会立即给你，但是 Stream 则不会立即给你而是在它准备好时告诉你

class DartStream extends StatelessWidget {
  const DartStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MaterialButton(
                onPressed: _dartStream,
                child: Text(
                  "Dart中的Stream",
                  style: Theme.of(context).textTheme.headline6,
                ))
          ]))
    ]);
  }

  void _dartStream() {
    // _test1();
    // _test2();
    // _test3();
    // _test4();
    // _test5();
    // _test6();
    // _test7();
    _test8();
  }

  ///通过生成器生成一个Stream流(类似于一个异步的可迭代的Iterator),使用  async* 配合 yield
  Stream<int> countStream(int to) async* {
    for (int i = 0; i <= to; i++) {
      if (i == 4) {
        throw Exception("Stream error....");
      }
      yield i;
    }
  }

  Stream<int> genNum() async* {
    for (int i = 0; i < 10; i++) {
      yield (i + 1);
    }
  }

  ///内部使用 await for 循环的函数需要使用 async 关键字标记。
  void _test1() async {
    var sum = countStream(10);
    var result = 0;

    try {
      ///使用 await for异步for循环迭代(for in loop)一个Stream 对象
      await for (final i in sum) {
        result += i;
      }
    } catch (err) {
      LogUtils.d("catch stream error...");
      // result = -1;
    }
    LogUtils.d("stream result $result");

    var lastWhere = await genNum().lastWhere((element) => element.isOdd);
    LogUtils.d("stream genNum result : $lastWhere");
  }

  ///Stream的创建方式:
  /// 转换现有的 Stream。
  /// 使用 async* 生成器函数创建 Stream。
  /// 使用 StreamController 生成 Stream。

  //使用 async* 生成器函数创建 Stream。
  Stream<String> _createStringSteram() async* {
    for (int i = 0; i < 10; i++) {
      // yield "hello dart stream${(i.isOdd ? "- $i|" : "- $i\n")}";
      yield "hello dart stream${("- $i\n flutter - $i")}";
    }
  }

  ///转换现有的流
  Stream<String> _lines(Stream<String> source) async* {
    var partial = "";

    ///异步for循环遍历订阅Stream ，并转换源Stream流的数据
    await for (final chunk in source) {
      var lines = chunk.split("\n");
      LogUtils.d("lines : $lines length : ${lines.length}");
      lines[0] = partial + lines[0];
      partial = lines.removeLast();
      LogUtils.d("partial :$partial, lines : $lines length : ${lines.length}");
      for (final line in lines) {
        yield line;
      }
    }

    if (partial.isNotEmpty) yield partial;
  }

  void _test2() {
    // _createStringSteram().listen((event) {
    //   LogUtils.d("test2 - $event");
    // });

    LogUtils.d("-----------------------------------------");

    _lines(_createStringSteram()).listen((event) {
      LogUtils.d("_lines transform is $event");
    });
  }

  Stream<List<int>> _getCharBytes() async* {
    for (int i = 0; i < 3; i++) {
      switch (i) {
        case 0:
          yield "Flutter\nDevelop by".codeUnits;
          break;
        case 1:
          yield "Dart\n".codeUnits;
          break;
        case 2:
          yield "MulitiPlatform\n".codeUnits;
          break;
      }
    }

    yield "awsome".codeUnits;
  }

  void _test3() async {
    LogUtils.d("------------------------------------");
    //Stream的一些列的操作变换符
    Stream.periodic(const Duration(seconds: 1), (count) => count + 1)
        .take(10)
        .map((event) => event.isOdd ? "奇数:$event" : "偶数:$event")
        .where((event) => (event.startsWith("偶数")))
        .expand((element) => [for (int i = 0; i < 3; i++) "$element($i)"])
        .take(5)
        .forEach((element) {
      LogUtils.d("count : $element");
    });

    LogUtils.d("------------------------------------");

    ///对于一些复杂的需求，我们可以通过自定义StreamTransformer来是实现我们自己需求的转换器

    //使用Dart已经提供的StreamTransformer
    Stream<List<int>> charBytes = _getCharBytes();
    charBytes.transform(utf8.decoder).transform(const LineSplitter()).listen(
        (event) => LogUtils.d('transform charBytes : $event'),
        onError: (err, stackTrace) =>
            LogUtils.d("transform charBtyes err:$err"),
        onDone: () => LogUtils.d("transform charBytes complete"),
        cancelOnError: false);

    LogUtils.d("------------------------------------");

    List<String> lines = await _getCharBytes()
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .toList();

    LogUtils.d("lines : $lines");
  }

  ///从零开始创建Stream
  ///通过异步生成器 (async*) 函数来完完全全地创建一个 Stream。
  ///当异步生成器函数被调用时会创建一个 Stream，而函数体则会在该 Stream 被监听时开始运行。
  ///当函数返回时，Stream 关闭。在函数返回前，你可以使用 yield 或 yield* 语句向该 Stream 提交事件

  //通过异步生成器，创建一个周期性发送整数的例子
  Stream<int> _interval(Duration interval, [int? maxCount]) async* {
    int i = 0;
    while (true) {
      await Future.delayed(interval);
      yield i++;
      if (i == maxCount) break;
    }
  }

  void _test4() {
    StreamSubscription<int> streamSubscription =
        _interval(const Duration(seconds: 1)).listen((event) {
      LogUtils.d("_interval event : $event");
    },
            onError: (err, stackTrace) => LogUtils.d("_interval err:$err"),
            onDone: () => LogUtils.d("_interval done!"),
            cancelOnError: false);

    ///通过Stream.listen()方法返回的StreamSubscription对象可以操作我们的Stream
    ///如：cancel取消 ，暂停pause resume重新回复等
    Future.delayed(const Duration(seconds: 5), () {
      // streamSubscription.cancel();
      ///暂定三秒钟，然后接着继续执行
      //   streamSubscription.pause(Future.delayed(const Duration(seconds: 3)));
    });
  }

  ///将Future序列转换成Stream
  Stream<T> streamFromFutures<T>(Iterable<Future<T>> futures) async* {
    for (final future in futures) {
      var result = await future;
      yield result;
    }
  }

  void _test5() async {
    var sff = streamFromFutures(
        <Future<int>>[for (int i = 0; i < 5; i++) Future.value(i * i)]);

    await for (final si in sff) {
      LogUtils.d("streamFromFuture : $si");
    }

    LogUtils.d("----------------------------------------");
    StreamSubscription<Set<String>> ssb =
        streamFromFutures(<Future<Set<String>>>[
      for (int i1 = 0; i1 < 5; i1++) Future.value({"flutter - $i1"})
    ]).listen((event) {
      LogUtils.d("streamFromFuture2 - $event");
    }, onDone: () => LogUtils.d("streamFromFuture2 done!"));
  }

  ///StreamController的使用,通过一步步的演进，来构建一个属于自己的Stream
  Stream<int> _timedInterval(Duration interval, [int? maxCount]) {
    //创建StreamController
    var streamController = StreamController<int>();
    int count = 0;

    void tick(Timer timer) {
      count++;
      streamController.add(count);
      if (maxCount != null && count == maxCount) {
        timer.cancel();
        streamController.close();
      }
    }

    //通过Timer实现指定间隔的定时器
    Timer.periodic(interval, tick);
    //返回StreamController关联的Stream
    return streamController.stream;
  }

  ///以上_timedInterval函数有两个问题:
  ///1.生成的Stream在拥有订阅者之前就开始生成事件。
  ///2.即使Stream的订阅者请求暂停，它也会继续生成事件。

  ///一般来说，Stream 应该在它生成事件前等待订阅者，否则事件的生成毫无意义。
  ///对 async* 异步生成器函数而言，它可以自行处理该问题。
  ///但是当使用 StreamController 时，因为你可以有比使用 async* 函数更多的控制能力，
  ///因此你完全可以无视相关规则自行添加并控制事件。
  ///如果一个 Stream 没有订阅者，它的 StreamController 会不断缓存事件，这可能会导致内存泄露。

  Future<void> _test6() async {
    ///调用 _timedInterval函数,生成Stream并一开始就开始工作生成数据,但是一开始的5秒钟内是不会打印任何输出的
    var intervalStream = _timedInterval(const Duration(seconds: 1), 10);
    await Future.delayed(const Duration(seconds: 5));

    ///5秒之后我们向Stream添加监听器,此时前面的5个事件会立刻马上输出,然后是每次间隔一秒输出一个事件
    ///说明一开始生成的5个事件被Stream给缓存了
    intervalStream.listen((event) {
      LogUtils.d("_timedInterval : $event");
    }, onDone: () => LogUtils.d("_timedInterval done!"));
  }

  ///当Stream监听器请求暂停时应当避免继续生成事件。
  ///当 Stream 订阅暂停时，async* 函数可以自动地在一个 yield 语句执行时暂停。
  ///而 StreamController 则会在暂停时缓存事件。
  ///如果代码在处理事件生成时不考虑暂停功能，则缓存的大小可以无限制地增长。
  ///而且如果在暂停后监听器很快又请求停止，那么在暂停到停止这段时间内所做的缓存工作都是浪费的。
  void _test7() {
    var intervalStream = _timedInterval(const Duration(seconds: 1), 15);
    late StreamSubscription<int> streamSubscription;
    streamSubscription = intervalStream.listen((event) {
      ///当五秒钟的暂停时间结束时，在此期间生成的事件将同时被输出。
      ///出现这种状况的原因是因为生成 Stream 的源没有遵循暂停规则，因此其会持续不断地向向 Stream 中添加事件。
      ///进而导致 Stream 缓存事件，然后，当 Stream 从暂停中恢复时，它会清空并输出其缓存。
      LogUtils.d("intervalStream count $event");
      if (event == 5) {
        //pause暂停Stream源5秒钟,然后resume恢复
        streamSubscription.pause(Future.delayed(const Duration(seconds: 5)));
      }
    }, onDone: () => LogUtils.d("intervalStream done!"));
  }

  ///针对以上_timedInterval的问题，进行秀修复的版本如下
  Stream<int> _timedCounter(Duration interval, [int? maxCount]) {
    late StreamController<int> controller;
    Timer? timer;
    int count = 0;

    void tick(Timer timer) {
      count++;
      controller.add(count);
      if (maxCount != null && count == maxCount) {
        timer.cancel();
        controller.close();
      }
    }

    void starter() {
      timer = Timer.periodic(interval, tick);
    }

    void stopper() {
      timer?.cancel();
      timer = null;
    }

    controller = StreamController<int>(
        onListen: starter,
        onPause: stopper,
        onResume: starter,
        onCancel: stopper);
    return controller.stream;
  }

  void _test8() {
    var streamCounter = _timedCounter(const Duration(seconds: 1), 10);
    late StreamSubscription<int> streamSubscription;


    streamSubscription = streamCounter.listen((event) {
      LogUtils.d("streamCounter : $event");

      if (event == 5) {
        streamSubscription.pause(Future.delayed(const Duration(seconds: 5)));
      }
    }, onDone: () => LogUtils.d("streanCounter done!"));

  }



}
