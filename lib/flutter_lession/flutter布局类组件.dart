import 'package:flutter/material.dart';
import 'package:flutter_lesson/utils/KeepAliveWrapper.dart';

import '../utils/log_utils.dart';

class FlutterLayoutTypeWidget extends StatefulWidget {
  static const String routeName = "flutter_layout_type_widget_route";

  const FlutterLayoutTypeWidget({Key? key}) : super(key: key);

  @override
  State<FlutterLayoutTypeWidget> createState() =>
      _FlutterLayoutTypeWidgetState();
}

class _FlutterLayoutTypeWidgetState extends State<FlutterLayoutTypeWidget>
    with SingleTickerProviderStateMixin<FlutterLayoutTypeWidget> {
  final List<String> _tabTitles = [
    "布局原理与约束",
    "线性布局",
    "弹性布局",
  ];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: _tabTitles.length, vsync: this)
      ..addListener(() {
        LogUtils.d("_tabController :${_tabController.index}");
      });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("layout布局类型组件"),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.purple,
          unselectedLabelColor: Colors.grey,
          tabs: _tabTitles
              .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(e,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16)),
                  ))
              .toList(),
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: _tabTitles.map((e) {
            switch (_tabTitles.indexOf(e)) {
              case 0:
                return const KeepAliveWrapper(child: LayoutConstraintWidget());
              default:
                return KeepAliveWrapper(child: Center(child: Text(e)));
            }
          }).toList()),
    );
  }
}

///布局类(Layout)组件都会包含一个或多个子组件，不同的布局类组件对子组件排列（layout）方式不同
///LeafRenderObjectWidget	非容器类组件基类	Widget树的叶子节点，用于没有子节点的widget，通常基础组件都属于这一类，如Image。
///SingleChildRenderObjectWidget	单子组件基类	包含一个子Widget，如：ConstrainedBox、DecoratedBox等
///MultiChildRenderObjectWidget	多子组件基类	包含多个子Widget，一般都有一个children参数，接受一个Widget数组。如Row、Column、Stack等
///Flutter 中有两种布局模型：
///基于 RenderBox 的盒模型布局。
/// 基于 Sliver ( RenderSliver ) 按需加载列表布局。
/// 两种布局方式在细节上略有差异，但大体流程相同，布局流程如下：
/// 上层组件向下层组件传递约束（constraints）条件。
/// 下层组件确定自己的大小，然后告诉上层组件。注意下层组件的大小必须符合父组件的约束。
/// 上层组件确定下层组件相对于自身的偏移和确定自身的大小（大多数情况下会根据子组件的大小来确定自身的大小）。
///
/// 盒模型布局组件有两个特点：
/// 组件(widget)对应的渲染对象(RenderObject)都继承自 RenderBox 类。
/// 在布局(layout)过程中父级传递给子级的约束信息由 BoxConstraints 描述。

class LayoutConstraintWidget extends StatelessWidget {
  const LayoutConstraintWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
      child: Column(
        children: [
          ///BoxConstraints 是盒模型布局过程中父渲染对象传递给子渲染对象的约束信息，包含最大宽高信息，子组件大小需要在约束的范围内
          ConstrainedBox(
            constraints: const BoxConstraints(
                minWidth: 100, maxWidth: 190, minHeight: 50.0, maxHeight: 100),
            child: const SizedBox(
                height: 60,
                child:
                    DecoratedBox(decoration: BoxDecoration(color: Colors.red))),
          ),

          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          const SizedBox(
            height: 80,
            width: 80,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.greenAccent),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

          ///上面的SizedBox等价与一下的BoxConstraints.tightFor()的调用
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 80, height: 80),
            child: const DecoratedBox(
              decoration: BoxDecoration(color: Colors.greenAccent),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "多重constraints约束限制",
              style: TextStyle(color: Colors.red, fontSize: 22),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
                minWidth: 60, minHeight: 60, maxWidth: 60, maxHeight: 60),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                  minWidth: 90, minHeight: 20, maxWidth: 90, maxHeight: 20),
              child: const DecoratedBox(
                decoration: BoxDecoration(color: Colors.red), // w 90 h 60
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "父子constraints约束对换",
              style: TextStyle(color: Colors.red, fontSize: 22),
            ),
          ),

          ConstrainedBox(
            constraints: const BoxConstraints(
                minWidth: 90, minHeight: 20, maxWidth: 90, maxHeight: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                  minWidth: 60, minHeight: 60, maxWidth: 60, maxHeight: 60),
              child: const DecoratedBox(
                decoration: BoxDecoration(color: Colors.red), // w 90 h 60
              ),
            ),
          )
        ],
      ),
    ));
  }
}
