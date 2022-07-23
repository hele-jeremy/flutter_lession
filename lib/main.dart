import 'package:flutter/material.dart';

import 'dart_lesson/asynchrony/dart_异步_future_async_await.dart';
import 'dart_lesson/asynchrony/data_异步stream_生成器.dart';
import 'dart_lesson/dart_函数function.dart';
import 'global.dart';

void main() {
  Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lesson',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Flutter学习之旅'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body:
      // const DartBuiltInTypes()
      // const DartFunction()
      // const DartOperator(),
      // const DartException(),
      // const DartClasses(),
      // const DartExtensions(),
      // const DartEnums(),
      // const DartExtensionImplementsMixin(),
      const DartAsync(),
      // const DartStream(),
    );
  }
}
