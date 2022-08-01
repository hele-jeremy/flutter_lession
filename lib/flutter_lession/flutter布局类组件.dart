import 'package:flutter/material.dart';
import 'package:flutter_lesson/utils/KeepAliveWrapper.dart';

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
        /*  ..addListener(() {
        LogUtils.d("_tabController :${_tabController.index}");
      })*/
        ;
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

class LayoutConstraintWidget extends StatelessWidget {
  const LayoutConstraintWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
                minWidth: 100,maxWidth: 190, minHeight: 50.0,maxHeight: 100),
            child: const SizedBox(
                height: 20,
                child:
                    DecoratedBox(decoration: BoxDecoration(color: Colors.red))),
          )
        ],
      ),
    ));
  }
}
