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
import 'package:flutter_lesson/flutter_lession/%E8%B5%84%E6%BA%90assets%E7%AE%A1%E7%90%86.dart';
import 'package:flutter_lesson/flutter_lession/flutter%E4%B8%AD%E7%9A%84%E5%8C%85%E7%9A%84%E7%AE%A1%E7%90%86_%E5%BC%95%E5%85%A5_%E4%BD%BF%E7%94%A8.dart';
import 'package:flutter_lesson/flutter_lession/flutter%E5%B8%83%E5%B1%80%E7%B1%BB%E7%BB%84%E4%BB%B6.dart';
import 'package:flutter_lesson/flutter_lession/flutter%E5%B8%B8%E7%94%A8%E5%9F%BA%E7%A1%80%E7%BB%84%E4%BB%B6.dart';
import 'package:flutter_lesson/flutter_lession/flutter%E5%B8%B8%E7%94%A8%E7%BB%84%E4%BB%B6TextField%E5%92%8CForm.dart';
import 'package:flutter_lesson/flutter_lession/flutter%E8%B0%83%E8%AF%95debug_%E5%85%A8%E5%B1%80%E9%94%99%E8%AF%AF%E5%A4%84%E7%90%86.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/NotFoundPage.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/login_page.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/mine_page.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/page_args.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/route_page_1.dart';
import 'package:flutter_lesson/flutter_lession/widget%E6%A0%91%E4%B8%AD%E8%8E%B7%E5%8F%96State%E5%AF%B9%E8%B1%A1.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

import '../../main.dart';
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
////////
const String minePageRoute = "mine_page_route";
const String loginPageRoute = "login_page_route";
const String unknownPageRoute = "unknown_page_route";

///定义路由表
Map<String, WidgetBuilder> routeTables = {
  initRoute: (context) => const MyHomePage(title: "重新学习Flutter"),
  dartBasic: (context) => const DartBasicIntroductionWidget(),
  dartBuiltInType: (context) => const DartBuiltInTypes(),
  dartFunction: (context) => const DartFunction(),
  dartOperatorAndFlowControll: (context) => const DartOperator(),
  dartOOPClass: (context) => const DartClasses(),
  dartExtendsImplementsMixin: (context) => const DartExtensionImplementsMixin(),
  dartException: (context) => const DartException(),
  dartExtension: (context) => const DartExtensions(),
  dartEnum: (context) => const DartEnums(),
  dartFutureAsyncAwait: (context) => const DartAsyncAwaitFuture(),
  dartStream: (context) => const DartStream(),
  routeTest: (context) => const RouteTestWidget(),

  ///如果没有传递参数，通过构造传递一个默认的参数
  RoutePage1.routeName: (context) => RoutePage1(
      args: (ModalRoute.of(context)?.settings.arguments ??
          PageArgs(id: "000000000", action: 0)) as PageArgs),
  widgetStateLifecycleTest: (context) => const StateLifecycleTestRoute(),
  widgetStateManageTest: (context) => const WidgetStateManageRoute(),
  widgetStateObjectGetTest: (context) => const GetStateObjectRoute(),
  //////
  minePageRoute: (context) => const MinePageWidget(),
  loginPageRoute: (context) => const LoginPageWidget(),
  RandomWordWidget.routeName: (context) => const RandomWordWidget(),
  AssetsManageWidget.routeName: (context) => const AssetsManageWidget(),
  DebugAndErrorHandleWidget.routeName: (context) =>
      const DebugAndErrorHandleWidget(),
  FlutterCommonBasicWidget.routeName: (context) =>
      const FlutterCommonBasicWidget(),
  FlutterTextFieldAndFormWidget.routeName: (context) =>
      const FlutterTextFieldAndFormWidget(),
  FlutterLayoutTypeWidget.routeName: (context) =>
      const FlutterLayoutTypeWidget()
};

Map<String, WidgetBuilder> routeTableGenerator() => routeTables;

///暂时先用静态变量记录当前的登录状态
var hasLogin = false;

///路由生成钩子
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  LogUtils.d("onGenerateRoute:{${settings.name} : ${settings.arguments}}");

  if (checkNeedLoginPermissionRoute(settings.name) && !hasLogin) {
    return buildJumpToLoginPageRoute(
        name: settings.name, arguments: settings.arguments);
  }

  try {
    return MaterialPageRoute(
        builder: routeTables[settings.name]!, settings: settings);
  } catch (err, stackTrace) {
    LogUtils.d(
        "onGenerateRoute:${err.toString()}\nstackTrace:${stackTrace.toString()}");
    return MaterialPageRoute(builder: (context) {
      return NotFoundPageWidget(settings: settings);
    });
  }
}

Route buildJumpToLoginPageRoute({String? name, Object? arguments}) {
  return MaterialPageRoute(
      builder: (context) {
        return const LoginPageWidget();
      },
      settings: RouteSettings(name: name, arguments: arguments));
}

var needCheckLogiRouteName = [minePageRoute];

bool checkNeedLoginPermissionRoute(String? name) {
  return needCheckLogiRouteName.contains(name);
}

//////////////////
Route<dynamic>? onUnknownRoute(RouteSettings settings) {
  return MaterialPageRoute(builder: (context) {
    return NotFoundPageWidget(
      settings: settings,
    );
  });
}
