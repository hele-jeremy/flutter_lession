import 'package:flutter/material.dart';

///Flutter中的状态管理:
///Widget 管理自己的状态。
/// Widget 管理子 Widget 状态。
/// 混合管理（父 Widget 和子 Widget 都管理状态)
/// 在 Widget 内部管理状态封装性会好一些，而在父 Widget 中管理会比较灵活。
/// 有些时候，如果不确定到底该怎么管理状态，那么推荐的首选是在父 Widget 中管理（灵活会显得更重要一些）

class WidgetStateManageRoute extends StatelessWidget {
  const WidgetStateManageRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const TapBoxA(initStatus: true);

    // return TabBoxB(onChanged: (active) {
    //   LogUtils.d("TabBoxB onChanged : $active");
    // });

    return const TapBoxParentWidget();
  }
}

//widget管理自身的状态
class TapBoxA extends StatefulWidget {
  final bool initStatus;

  const TapBoxA({Key? key, required this.initStatus}) : super(key: key);

  @override
  State<TapBoxA> createState() => _TapBoxAState();
}

class _TapBoxAState extends State<TapBoxA> {
  bool _active = false;

  @override
  void initState() {
    _active = widget.initStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }
}

//父widget管理子widget的状态

class TapBoxParentWidget extends StatefulWidget {
  const TapBoxParentWidget({Key? key}) : super(key: key);

  @override
  State<TapBoxParentWidget> createState() => _TapBoxParentWidgetState();
}

class _TapBoxParentWidgetState extends State<TapBoxParentWidget> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    return TabBoxB(
      active: _active,
      onChanged: _handleTapBoxChanged,
    );
  }

  void _handleTapBoxChanged(bool active) => setState(() {
        _active = active;
      });
}

class TabBoxB extends StatelessWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  const TabBoxB({Key? key, this.active = false, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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

  void _handleTap() => onChanged(!active);
}



