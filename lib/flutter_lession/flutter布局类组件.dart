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
    "布局类型组件简介",
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
          children: _tabTitles
              .map((e) => KeepAliveWrapper(child: Center(child: Text(e))))
              .toList()),
    );
  }
}


