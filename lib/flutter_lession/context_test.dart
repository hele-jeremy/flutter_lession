import 'package:flutter/material.dart';

class ContextRoute extends StatelessWidget {
  const ContextRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //通过context上下文向上寻找最近的父级Scfford对象
    var scaffold = context.findAncestorWidgetOfExactType<Scaffold>();
    return (scaffold == null)
        ? Center(
            child: Container(
              color: Colors.yellow,
              child: const Text(
                "未找到最近的父级Scaffold对象",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          )
        : (scaffold.appBar as AppBar).title!;
  }
}
