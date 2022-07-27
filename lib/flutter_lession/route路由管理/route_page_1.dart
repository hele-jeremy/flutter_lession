import 'package:flutter/material.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/page_args.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/page_modle1.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

class RoutePage1 extends StatefulWidget {
  static const String routeName = "route_page1";
  final PageArgs args;
  ///通过构造函数传递参数，这种方式一般适用于非命名路由的方式进行参数的传递
  const RoutePage1({Key? key, required this.args}) : super(key: key);

  @override
  State<RoutePage1> createState() => _RoutePage1State();
}

class _RoutePage1State extends State<RoutePage1> {
  @override
  void initState() {
    super.initState();
    ///在initState的时机获取界面传参会抛出异常
    //dependOnInheritedWidgetOfExactType<_ModalScopeStatus>() or dependOnInheritedElement() was called before _RoutePage1State.initState() completed.
    // var arguments = ModalRoute.of(context)?.settings.arguments;
    // LogUtils.d("_RoutePage1State initState args:$arguments");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var arguments = ModalRoute.of(context)?.settings.arguments;
    LogUtils.d("_RoutePage1State didChangeDependencies args:$arguments");
  }

  @override
  Widget build(BuildContext context) {
    ///通过ModalRoute的方式在页面之间传递参数的方式，比通过构造函数传递参数的方式要灵活
    ///这种传参方式一般适用于命名路由页面间的跳转
    var arguments = ModalRoute.of(context)?.settings.arguments;
    LogUtils.d("_RoutePage1State build args:$arguments");
    return Scaffold(
      appBar: AppBar(
        title: const Text("页面一"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(widget.args.toString())]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: ElevatedButton(
                onPressed: () {
                  ///当前界面在导航栈中出栈
                  Navigator.pop(
                      context,

                      ///返给上一个界面一个PageModel1数据对象
                      PageModel1.from(
                          {"id": widget.args.id, "count": 32, "price": 3.33}));
                },
                child: const Text("返回")),
          )
        ],
      ),
    );
  }
}
