import 'package:flutter/material.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/route_config.dart';

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
      theme: ThemeData(primarySwatch: Colors.green),

      ///设置初始路由
      initialRoute: initRoute,

      ///注册路由表 Map<String,WidgetBuilder>
      routes: routeTableGenerator(),
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(dartBasic);
                          },
                          child: const Text("Dart基础"));
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(routeTest);
                          },
                          child: const Text("路由Route测试"));
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(widgetStateLifecycleTest);
                          },
                          child: const Text("Widget的State生命周期测试"));
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(widgetStateManageTest);
                          },
                          child: const Text("Widget的State状态管理测试"));
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(widgetStateObjectGetTest);
                          },
                          child: const Text("Widget的State对象获取测试"));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
