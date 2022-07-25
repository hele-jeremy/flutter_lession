import 'package:flutter/material.dart';

class GetStateObjectRoute extends StatelessWidget {
  const GetStateObjectRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetStateObjectWidget(text: "widget树中获取State对象");
  }
}

class GetStateObjectWidget extends StatefulWidget {
  final String text;

  const GetStateObjectWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<GetStateObjectWidget> createState() => _GetStateObjectWidgetState();
}

class _GetStateObjectWidgetState extends State<GetStateObjectWidget> {
  ///定义一个globalKey, 由于GlobalKey要保持全局唯一性，我们使用静态变量存储
  ///GlobalKey 是 Flutter 提供的一种在整个 App 中引用 element 的机制。
  ///如果一个 widget 设置了GlobalKey，那么我们便可以通过globalKey.currentWidget获得该 widget 对象、
  ///globalKey.currentElement来获得 widget 对应的element对象，
  ///如果当前 widget 是StatefulWidget，则可以通过globalKey.currentState来获得该 widget 对应的state对象。
  /// 注意：使用 GlobalKey 开销较大，如果有其他可选方案，应尽量避免使用它。
  /// 另外，同一个 GlobalKey 在整个 widget 树中必须是唯一的，不能重复。
  static final GlobalKey<ScaffoldState> _globalKey =
      GlobalKey(debugLabel: "key_find_scaffold");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///对scaffold添加全局key
      key: _globalKey,
      appBar: AppBar(
        title: Text(widget.text),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Builder(builder: (context) {
                return ElevatedButton(
                    onPressed: () {
                      ///通过BuildContext提供的findAncestorStateOfType方法,
                      ///从当前节点沿着 widget 树向上查找指定类型的 StatefulWidget 对应的 State 对象
                      var scaffoldState =
                          context.findAncestorStateOfType<ScaffoldState>();

                      ///使用使用查找到的指定的最近的一个ScffloldState对象,打开其抽屉栏
                      scaffoldState?.openDrawer();
                    },
                    child: const Text("代开Drawer抽屉(findAncestorStateOfType)"));
              }),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                      onPressed: () {
                        ///Flutter中的通用做法是，如果一个StatefulWidget希望暴露其State对象
                        ///通常会提供静态的of()方法，用于获取该StatefulWidget对应的State对象
                        var scaffold = Scaffold.of(context);
                        scaffold.openDrawer();
                      },
                      child: const Text("打开Drawer抽屉(Flutter通用做法of)"));
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                      onPressed: () {
                        var scaffoldMessengerState =
                            ScaffoldMessenger.of(context);
                        scaffoldMessengerState.showSnackBar(
                            const SnackBar(content: Text("我是一个SnackBar")));
                      },
                      child: const Text("展示SnakeBar(Flutter通用做法of"));
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                      onPressed: () {
                        assert(_globalKey.currentContext != context);
                        ///通过全局Globalkey来获取指定的State对象
                        _globalKey.currentState?.openDrawer();
                      },
                      child: const Text("通过GlobalKey获取State对象"));
                },
              ),
            )
          ],
        ),
      ),
      drawer: const Drawer(
        backgroundColor: Colors.yellow,
      ),
    );
  }
}
