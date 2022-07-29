import 'dart:async';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson/flutter_lession/extensions.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

class DebugAndErrorHandleWidget extends StatefulWidget {
  static const routeName = "debug_and_error_handle_route";

  const DebugAndErrorHandleWidget({Key? key}) : super(key: key);

  @override
  State<DebugAndErrorHandleWidget> createState() =>
      _DebugAndErrorHandleWidgetState();
}

class _DebugAndErrorHandleWidgetState extends State<DebugAndErrorHandleWidget> {
  List<WordPair> _words = [];
  late String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("debug调试异常处理和捕获"),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    debugDumpApp();
                  },
                  child: const Text("打印widget树信息")),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    for (int i = 0; i < _words.length; i++)
                      Padding(

                          ///widget的build方法在执行的时候，flutter已经进行了try..catch..的异常处理
                          ///并使用了是一个ErrorWidget来显示我们的异常问题
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("${_words[i]}"))
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () => setState(() {
                        _words = 100.reduceTimes((time) {
                          var wordPair = WordPair.random();
                          LogUtils.d(
                              "reduceTimes : $time : ${wordPair.toString()}");
                          return wordPair;
                        });
                      }),
                  child: const Text("flutter为我们捕获的异常")),
              ElevatedButton(
                  onPressed: () {
                    try {
                      ///同步异常可以被try...catch...捕获
                      var length = _name.length;
                    } catch (err, stackTrace) {
                      LogUtils.d("捕获了_name.length的异常");
                    }
                    LogUtils.d('_name.length继续执行');
                  },
                  child: const Text("模拟同步异常")),
              ElevatedButton(
                  onPressed: () async {
                    ///直接抛出异常的方式，catchError无法捕获住异常,会有一个Unhandled Exception不建议这样子来处理
                    // Future.delayed(const Duration(seconds: 1),
                    //         () => throw Exception("Future类型的异常"))
                    ///通过Future.error的方式catchError可以捕获到Future的异常
                    /*Future.delayed(const Duration(seconds: 1),
                            () => Future.error(Exception("Future类型的异常")))
                        .catchError((err, stackTrace) {
                      LogUtils.d("通过catchError来捕获Future异步异常");
                    });*/
                    try {
                      ///在Flutter中，还有一些Flutter没有为我们捕获的异常，如调用空对象方法异常、Future中的异常。
                      ///在Dart中，异常分两类：同步异常和异步异常，同步异常可以通过try/catch捕获，
                      ///而异步异常（Future异常）通过try..catch..是捕获不了的
                      Future.delayed(const Duration(seconds: 1),
                          () => throw Exception("模拟的异步异常"));
                      // Future.delayed(const Duration(seconds: 1),
                      //     () => Future.error(Exception("模拟的异步异常")));
                    } catch (err, stackTrace) {
                      LogUtils.d("捕获了future的异步异常");
                    }
                    // try {
                    //   ///通过await等待Future结果,可以通过try...catch..的方式捕获异常
                    //   ///相当于同步(sync)异常是可以被try..catch..给捕获的
                    //   // await Future.delayed(const Duration(seconds: 1),
                    //   //     () => throw Exception("模拟的异步异常"));
                    //   await Future.delayed(const Duration(seconds: 1),
                    //       () => Future.error(Exception("模拟的异步异常")));
                    // } catch (err, stackTrace) {
                    //   LogUtils.d("捕获了future的异步异常");
                    // }

                    LogUtils.d("future继续执行");
                  },
                  child: const Text("模拟异步异常")),
              ElevatedButton(
                  onPressed: () {
                    Future.sync(() {
                      Future.delayed(
                              const Duration(seconds: 1),
                              () => Future.error(
                                  const FormatException("Future format 异常!")))
                          .catchError((err, stackTrace) {
                        LogUtils.d("catchError捕获Future异常");
                      });
                      throw Exception("抛出的同步sync异常");
                      LogUtils.d("future 后的运行");
                    }).catchError((err, stackTrace) {
                      LogUtils.d("Future sync catchError捕获异常$err");
                    }).whenComplete(() => LogUtils.d("Future sync() done!"));
                  },
                  child: const Text("通过Future.sync()处理Future异常")),
              ElevatedButton(
                  onPressed: () {
                    runZoned(() {
                      Future.delayed(const Duration(seconds: 1),
                          () => throw Exception("Future抛出了异常----"));

                      LogUtils.d("future后的执行代码");
                    },
                        zoneValues: {
                          "logTag": "zone_intercept_log::",
                          "handleError": true
                        },
                        zoneSpecification: ZoneSpecification(

                            ///拦截print打印方法
                            print: (Zone self, ZoneDelegate parent, Zone zone,
                                String line) {
                          var logTag = zone["logTag"];
                          parent.print(zone, "$logTag :$line");
                        }, handleUncaughtError: (Zone self,
                                ZoneDelegate parent,
                                Zone zone,
                                Object error,
                                StackTrace stackTrace) {
                          // parent.print(zone, "${error.toString()} $stackTrace");
                          if (zone["handleError"] as bool) {
                            parent.print(
                                zone, "zone捕获到了异常: ${error.toString()} $stackTrace");
                          }
                        }));
                  },
                  child: const Text("runZone捕获Future异步异常"))
            ],
          ),
        ));
  }
}
