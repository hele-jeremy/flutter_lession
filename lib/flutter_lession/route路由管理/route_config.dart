import 'package:flutter/material.dart';
import 'package:flutter_lesson/dart_lesson/asynchrony/dart_%E5%BC%82%E6%AD%A5_future_async_await.dart';
import 'package:flutter_lesson/dart_lesson/asynchrony/data_%E5%BC%82%E6%AD%A5stream_%E7%94%9F%E6%88%90%E5%99%A8.dart';
import 'package:flutter_lesson/dart_lesson/dart_%E5%86%85%E5%BB%BA%E6%95%B0%E6%8D%AE%E7%B1%BB%E5%9E%8B.dart';
import 'package:flutter_lesson/dart_lesson/dart_%E5%87%BD%E6%95%B0function.dart';
import 'package:flutter_lesson/dart_lesson/dart_%E5%BC%82%E5%B8%B8.dart';
import 'package:flutter_lesson/dart_lesson/dart_%E7%B1%BBclass.dart';
import 'package:flutter_lesson/dart_lesson/dart_%E7%BB%A7%E6%89%BFextensions_%E5%AE%9E%E7%8E%B0implements_%E6%B7%B7%E5%90%88mixin.dart';
import 'package:flutter_lesson/dart_lesson/dart_%E8%BF%90%E7%AE%97%E7%AC%A6_%E6%B5%81%E7%A8%8B%E6%8E%A7%E5%88%B6%E8%AF%AD%E5%8F%A5.dart';
import 'package:flutter_lesson/dart_lesson/dart_basic.dart';
import 'package:flutter_lesson/dart_lesson/enum/dart_enum%E6%9E%9A%E4%B8%BE.dart';
import 'package:flutter_lesson/dart_lesson/extension/dart_extensions%E6%89%A9%E5%B1%95.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/page_args.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/route_page_1.dart';
import 'package:flutter_lesson/flutter_lession/widget%E6%A0%91%E4%B8%AD%E8%8E%B7%E5%8F%96State%E5%AF%B9%E8%B1%A1.dart';

import '../../_main.dart';
import '../flutter中的state状态的管理.dart';
import '../state生命周期.dart';
import '路由管理.dart';

const String initRoute = "/";
const String dartBasic = "dart_basic";
const String dartBuiltInType = "dart_built_in_type";
const String dartFunction = "dart_function";
const String dartOperatorAndFlowControll = "dart_operator_and_flow_controll";
const String dartOOPClass = "dart_oop_class";
const String dartExtendsImplementsMixin = "dart_extends_implements_mixin";
const String dartException = "dart_exception";
const String dartExtension = "dart_extension";
const String dartEnum = "dart_enum";
const String dartFutureAsyncAwait = "dart_future_async_await";
const String dartStream = "dart_stream";
const String routeTest = "route_test";
const String widgetStateLifecycleTest = "widget_state_lifecycle_test";
const String widgetStateManageTest = "widget_state_manage_test";
const String widgetStateObjectGetTest = "widget_state_object_get_test";

Map<String, WidgetBuilder> routeTableGenerator() => {
      initRoute: (context) => const MyHomePage(title: "重新学习Flutter"),
      dartBasic: (context) => const DartBasicIntroductionWidget(),
      dartBuiltInType: (context) => const DartBuiltInTypes(),
      dartFunction: (context) => const DartFunction(),
      dartOperatorAndFlowControll: (context) => const DartOperator(),
      dartOOPClass: (context) => const DartClasses(),
      dartExtendsImplementsMixin: (context) =>
          const DartExtensionImplementsMixin(),
      dartException: (context) => const DartException(),
      dartExtension: (context) => const DartExtensions(),
      dartEnum: (context) => const DartEnums(),
      dartFutureAsyncAwait: (context) => const DartAsyncAwaitFuture(),
      dartStream: (context) => const DartStream(),
      routeTest: (context) => const RouteTestWidget(),
      RoutePage1.routeName: (context) => RoutePage1(
          args: (ModalRoute.of(context)?.settings.arguments ??
              PageArgs(id: "000000000", action: 0)) as PageArgs),
      widgetStateLifecycleTest: (context) => const StateLifecycleTestRoute(),
      widgetStateManageTest: (context) => const WidgetStateManageRoute(),
      widgetStateObjectGetTest: (context) => const GetStateObjectRoute(),
    };
