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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                  onPressed: _dartStream,
                  child: Text(
                    "Dart中的Stream",
                    style: Theme.of(context).textTheme.headline6,
                  ))
            ],
          ),
        )
      ],
    );
  }

  void _dartStream() {
    _test1();
  }

  ///通过异步生成器生成一个Stream流(类似于一个异步的可迭代的Iterator),使用  async* 配合 yield
  Stream<int> countStream(int to) async* {
    for (int i = 0; i <= to; i++) {
      if (i==4) {
        throw Exception("Stream error....");
      }
      yield i;
    }
  }

  Stream<int> genNum()async*{
    for (int i = 0; i < 10; i++) {
      yield (i + 1);
    }
  }

  void _test1() async {
    var sum = countStream(10);
    var result = 0;


    try{
      ///使用 await for 迭代(for in loop)一个Stream 对象
      await for (final i in sum) {
        result += i;
      }
    }catch (err){
      LogUtils.d("catch stream error...");
      // result = -1;
    }
    LogUtils.d("stream result $result");

    var lastWhere = await genNum().lastWhere((element) => element.isOdd);
    LogUtils.d("stream genNum result : $lastWhere");
  }
}
