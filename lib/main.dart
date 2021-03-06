import 'package:flutter/material.dart';
import 'package:flutter_lesson/flutter_lession/%E8%B5%84%E6%BA%90assets%E7%AE%A1%E7%90%86.dart';
import 'package:flutter_lesson/flutter_lession/flutter%E4%B8%AD%E7%9A%84%E5%8C%85%E7%9A%84%E7%AE%A1%E7%90%86_%E5%BC%95%E5%85%A5_%E4%BD%BF%E7%94%A8.dart';
import 'package:flutter_lesson/flutter_lession/flutter%E5%B8%83%E5%B1%80%E7%B1%BB%E7%BB%84%E4%BB%B6.dart';
import 'package:flutter_lesson/flutter_lession/flutter%E5%B8%B8%E7%94%A8%E5%9F%BA%E7%A1%80%E7%BB%84%E4%BB%B6.dart';
import 'package:flutter_lesson/flutter_lession/flutter%E5%B8%B8%E7%94%A8%E7%BB%84%E4%BB%B6TextField%E5%92%8CForm.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/route_config.dart';

import 'flutter_lession/flutter调试debug_全局错误处理.dart';
import 'global.dart';

void main() {
  launch();
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
      // routes: routeTableGenerator(),

      ///路由生成钩子
      ///onGenerateRoute 只会对命名路由生效
      ///当调用Navigator.pushNamed(...)打开命名路由时，如果指定的路由名在路由表中已注册，
      ///则会调用路由表中的builder函数来生成路由组件；如果路由表中没有注册，才会调用onGenerateRoute来生成路由
      onGenerateRoute: onGenerateRoute,

      ///当push一个不存在的路由页面的时候，需要进行提示操作。可以使用UnknownRoute的属性
      onUnknownRoute: onUnknownRoute,
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
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RandomWordWidget.routeName);
                    },
                    child: const Text("flutter的包package管理和使用"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AssetsManageWidget.routeName);
                    },
                    child: const Text("assets资源管理引入使用"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(DebugAndErrorHandleWidget.routeName);
                          },
                          child: const Text("debug调试和错误处理error handle"));
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(FlutterCommonBasicWidget.routeName);
                    },
                    child: const Text("Flutter常用基础组件"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(FlutterTextFieldAndFormWidget.routeName);
                    },
                    child: const Text("Flutter常用基础组件TextField_Form"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(FlutterLayoutTypeWidget
                          .routeName);
                    },
                    child: const Text("Flutter布局layout类组件"),
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
