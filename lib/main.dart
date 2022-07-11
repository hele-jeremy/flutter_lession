import 'package:flutter/material.dart';
import 'package:flutter_lesson/dart_lesson/dart_%E7%BB%A7%E6%89%BFextensions_%E5%AE%9E%E7%8E%B0implements_%E6%B7%B7%E5%90%88mixin.dart';

import 'dart_lesson/dart_类class.dart';
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
          // const DartBuiltInTypes() // This trailing comma makes auto-formatting nicer for build methods.
          // const DartFunction() // This trailing comma makes auto-formatting nicer for build methods.
          // const DartOperator(),
          // const DartException(),
          const DartClasses(),
          // const DartExtensions(),
          // const DartEnums(),
          // const DartExtensionImplementsMixin(),
    );
  }
}
