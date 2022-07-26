import 'package:flutter/material.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/route_config.dart';

class DartBasicIntroductionWidget extends StatelessWidget {
  const DartBasicIntroductionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dart基本介绍"),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(dartBuiltInType);
                          },
                          child: const Text("Dart内建数据类型"));
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(dartFunction);
                          },
                          child: const Text("Dart中的Function函数"));
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
                                .pushNamed(dartOperatorAndFlowControll);
                          },
                          child: const Text(
                            "Dart中的操作符\n流程控制语句",
                            textAlign: TextAlign.center,
                          ));
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(dartOOPClass);
                          },
                          child: const Text(
                            "Dart中的Class\noop面向对象",
                            textAlign: TextAlign.center,
                          ));
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
                                .pushNamed(dartExtendsImplementsMixin);
                          },
                          child: const Text(
                            "Dart中的Extends\nimplements\nmixin",
                            textAlign: TextAlign.center,
                          ));
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(dartException);
                          },
                          child: const Text(
                            "Dart中的异常",
                            textAlign: TextAlign.center,
                          ));
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(dartExtension);
                          },
                          child: const Text(
                            "Dart中的扩展extensions",
                            textAlign: TextAlign.center,
                          ));
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(dartEnum);
                          },
                          child: const Text(
                            "Dart中的枚举Enum",
                            textAlign: TextAlign.center,
                          ));
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
                                .pushNamed(dartFutureAsyncAwait);
                          },
                          child: const Text(
                            "Dart异步async,await,Future",
                            textAlign: TextAlign.center,
                          ));
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(dartStream);
                          },
                          child: const Text(
                            "Dart异步Stream",
                            textAlign: TextAlign.center,
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
