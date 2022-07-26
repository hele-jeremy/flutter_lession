import 'package:flutter/material.dart';

import '../utils/log_utils.dart';

///Flutter中的状态管理:
///Widget 管理自己的状态。
/// Widget 管理子 Widget 状态。
/// 混合管理（父 Widget 和子 Widget 都管理状态)
/// 在 Widget 内部管理状态封装性会好一些，而在父 Widget 中管理会比较灵活。
/// 有些时候，如果不确定到底该怎么管理状态，那么推荐的首选是在父 Widget 中管理（灵活会显得更重要一些）
///
/// 全局状态管理

class WidgetStateManageRoute extends StatelessWidget {
  const WidgetStateManageRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const TapBoxA(initStatus: true);

    /*  return TabBoxB(onChanged: (active) {
      ///这种方式TabBoxB的UI界面不会变化
      ///1.TabBoxB的active值没有变化
      ///2.没有显示的调用setState来触发Flutter框架更新UI
      LogUtils.d("TabBoxB onChanged : $active");
    });*/

    // return const TapBoxBParentWidget(active: true);

    // return TabBoxC(
    //     active: true,
    //     onChanged: (active) {
    //       ///这种方式TabBoxC的UI界面的背景颜色和文字不会发生变化
    //       ///1.TabBoxC的active值没有变化
    //       ///2.没有显示的调用setState来触发Flutter框架更新UI
    //       LogUtils.d("TabBoxc active $active");
    //     });

    return const TabBoxCParentWidget(active: true);
  }
}

///widget管理自身的状态
class TapBoxA extends StatefulWidget {
  final bool initStatus;

  const TapBoxA({Key? key, required this.initStatus}) : super(key: key);

  @override
  State<TapBoxA> createState() => _TapBoxAState();
}

class _TapBoxAState extends State<TapBoxA> {
  ///TapBoxA的State维护自己的_active状态
  bool _active = false;

  @override
  void initState() {
    _active = widget.initStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("widget中的状态管理"),
      ),
      body: GestureDetector(
        onTap: _handleTap,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              color: _active ? Colors.lightGreen[700] : Colors.grey[600]),
          child: Center(
            child: Text(
              _active ? "Active" : "Inactive",
              style: const TextStyle(
                  fontSize: 32.0,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
          ),
        ),
      ),
    );
  }

  void _handleTap() {
    ///通过setState更新自己维护的状态，同时更新UI
    setState(() {
      _active = !_active;
    });
  }
}

///父widget管理子widget的状态
class TapBoxBParentWidget extends StatefulWidget {
  final bool active;

  const TapBoxBParentWidget({Key? key, required this.active}) : super(key: key);

  @override
  State<TapBoxBParentWidget> createState() => _TapBoxBParentWidgetState();
}

class _TapBoxBParentWidgetState extends State<TapBoxBParentWidget> {
  ///父widget管理子widget TabBoxB的状态
  bool _active = false;

  @override
  void initState() {
    super.initState();
    _active = widget.active;
    LogUtils.d("_TapBoxBParentWidgetState initState...");
  }

  @override
  Widget build(BuildContext context) {
    LogUtils.d("_TapBoxBParentWidgetState build...");
    return TabBoxB(
      active: _active,
      onChanged: _handleTapBoxChanged,
    );
  }

  void _handleTapBoxChanged(bool active) => setState(() {
        ///父widget通过子widget的回调通知,获得了子widget的最新的状态变化值
        ///父widget维护子widget的状态,并调用setState方法来通知flutter框架
        ///更新UI同时将子widget最新的状态传递给子widget，子widget就可以根据
        ///最新的状态值来更新UI
        _active = active;
      });
}

///由于TabBoxB将自己的状态交给了父widget来管理,自己不管理维护自己的状态
///因此将TabBoxB定义成一个StatelessWidget即可
class TabBoxB extends StatelessWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  const TabBoxB({Key? key, this.active = false, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    LogUtils.d("TabBoxB build...");
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            color: active ? Colors.lightGreen[700] : Colors.grey[600]),
        child: Center(
          child: Text(
            active ? "Active" : "Inactive",
            style: const TextStyle(
                fontSize: 32.0,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }

  void _handleTap() {
    ///子widget通过回调的方式将自己的状态变化,通知到父widget，父widget来管理状态的变化
    LogUtils.d("TabBoxB _handleTap...");
    onChanged(!active);
  }
}

///混合状态管理(父widget和子widget共同管理状态)
class TabBoxCParentWidget extends StatefulWidget {
  final bool active;

  const TabBoxCParentWidget({Key? key, required this.active}) : super(key: key);

  @override
  State<TabBoxCParentWidget> createState() => _TabBoxCParentWidgetState();
}

class _TabBoxCParentWidgetState extends State<TabBoxCParentWidget> {
  ///父widget管理子widget的active状态
  bool active = false;

  @override
  void initState() {
    super.initState();
    active = widget.active;
  }

  @override
  Widget build(BuildContext context) {
    return TabBoxC(active: active, onChanged: _handleTap);
  }

  void _handleTap(bool value) {
    ///通过回调接收子widget状态变更通知，并通过setState通知flutter框架更新UI
    ///将子widget最新的状态传递给子widget，子widget根据最新的状态来动态更新UI
    setState(() {
      active = value;
    });
  }
}

class TabBoxC extends StatefulWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  const TabBoxC({Key? key, required this.active, required this.onChanged})
      : super(key: key);

  @override
  State<TabBoxC> createState() => _TabBoxCState();
}

class _TabBoxCState extends State<TabBoxC> {
  ///同时子widget也自己维护了一个自己的状态
  bool _highLight = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("widget中的状态管理"),
      ),
      body: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTap: _handleTap,
        onTapCancel: _handleTapCancel,
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                color:
                    widget.active ? Colors.lightGreen[700] : Colors.grey[600],
                border: _highLight
                    ? Border.all(
                        color: Colors.teal[700]!,
                        width: 10.0,
                      )
                    : null),
            child: Center(
              child: Text(
                widget.active ? "Active" : "Inactive",
                style: const TextStyle(
                    fontSize: 32.0,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleTapCancel() => _toggleHighLight(false);

  void _handleTap() => widget.onChanged.call(!widget.active);

  void _handleTapUp(TapUpDetails details) => _toggleHighLight(false);

  void _handleTapDown(TapDownDetails details) => _toggleHighLight(true);

  ///子widget内部通过setState更新自己的状态同时通知flutter框架更新UI
  void _toggleHighLight(bool toggleValue) => setState(() {
        _highLight = toggleValue;
      });
}
