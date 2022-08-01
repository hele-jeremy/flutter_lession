import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

import 'main.dart';

void init() {
  LogUtils.init(isDebug: true);
}

FlutterExceptionHandler? onError;
const String logTag = "print_intercept";

void errorHandler(FlutterErrorDetails details) {
  onError?.call(details);
  reportErrorAndLog(details);
}

void collectLog(String line) {
  ///不能在print的钩子函数调用的方法中再执行print方法
  ///会导致栈stack溢出
  // LogUtils.d("全局日志收集....");
}

void reportErrorAndLog(FlutterErrorDetails details) {
  LogUtils.d("统一上报错误error和日志log");
  LogUtils.d("未处理异常:${details.exceptionAsString()}");
}

/// Flutter 应用启动的方法，做了全局print方法的hook处理
/// 同时捕获了全局为捕获的异常
void launch() {
  init();
  ///暂时先屏蔽掉全局异常捕获
  runApp(const MyApp());

  // onError = FlutterError.onError;
  // FlutterError.onError = errorHandler;
  // runZoned(() {
  //   runApp(const MyApp());
  // },
  //     zoneValues: {"logTag": logTag},
  //     zoneSpecification: ZoneSpecification(
  //         print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
  //           collectLog(line);
  //           parent.print(zone, "${zone["logTag"]}: $line");
  //         }, handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone,
  //         Object error, StackTrace stackTrace) {
  //       reportErrorAndLog(
  //           FlutterErrorDetails(exception: error, stack: stackTrace));
  //       parent.print(zone, "${error.toString()} $stackTrace");
  //     }));
}
