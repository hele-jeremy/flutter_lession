import 'package:flutter/material.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

class StateLifecycleTestRoute extends StatelessWidget {
  const StateLifecycleTestRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CounterStateWidget();
    ///测试CounterStateWidget从树中被移除
    // return const Text("将CounterStateWidget从Widget树中移除");
  }
}

class CounterStateWidget extends StatefulWidget {
  final int initValue;

  const CounterStateWidget({Key? key, this.initValue = 0}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyCounterState();
}

class _MyCounterState extends State<CounterStateWidget> {
  //计数器的值
  int _count = 0;

  ///initState：当 widget 第一次插入到 widget 树时会被调用，对于每一个State对象，
  ///Flutter 框架只会调用一次该回调，所以，通常在该回调中做一些一次性的操作，
  ///如状态初始化、订阅子树的事件通知等。
  @override
  void initState() {
    super.initState();
    _count = widget.initValue;
    LogUtils.d("initState.......");
  }

  ///当State对象的依赖发生变化时会被调用
  ///例如：在之前build() 中包含了一个InheritedWidget，然后在之后的build() 中Inherited widget发生了变化，
  ///那么此时InheritedWidget的子 widget 的didChangeDependencies()回调都会被调用。
  ///典型的场景是当系统语言 Locale 或应用主题改变时，Flutter 框架会通知 widget 调用此回调。
  ///需要注意，组件第一次被创建后挂载的时候（包括重创建）对应的didChangeDependencies也会被调用。
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LogUtils.d("didChangeDependencies.......");
  }

  ///用于构建 widget 子树的，会在如下场景被调用：
  /// 在调用initState()之后。
  /// 在调用didUpdateWidget()之后。
  /// 在调用setState()之后。
  /// 在调用didChangeDependencies()之后。
  /// 在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其它位置之后。
  @override
  Widget build(BuildContext context) {
    LogUtils.d("build.......");
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.yellow,
          child: TextButton(
            onPressed: () => setState(() {
              _count++;
            }),
            child: Text(
              "$_count",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
      ),
    );
  }

  ///此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用
  @override
  void reassemble() {
    super.reassemble();
    LogUtils.d("reassemble.......");
  }

  ///在 widget 重新构建时，Flutter 框架会调用widget.canUpdate来检测 widget 树中同一位置的新旧节点，
  ///然后决定是否需要更新，如果widget.canUpdate返回true则会调用此回调。
  ///widget.canUpdate方法会在新旧 widget 的 key 和 runtimeType 同时相等时会返回true，
  ///也就是说在新旧 widget 的key和runtimeType同时相等时didUpdateWidget()就会被调用。
  @override
  void didUpdateWidget(covariant CounterStateWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    LogUtils.d("didUpdateWidget.......");
  }


  ///当 State 对象从树中被移除时，会调用此回调。在一些场景下，Flutter 框架会将 State 对象重新插到树中，
  ///如包含此 State 对象的子树在树的一个位置移动到另一个位置时（可以通过GlobalKey 来实现）。
  ///如果移除后没有重新插入到树中则紧接着会调用dispose()方法
  @override
  void deactivate() {
    super.deactivate();
    LogUtils.d("deactivate.......");
  }

  ///当 State 对象从树中被永久移除时调用；通常在此回调中释放资源。
  @override
  void dispose() {
    super.dispose();
    LogUtils.d("dispose.......");
  }
}
