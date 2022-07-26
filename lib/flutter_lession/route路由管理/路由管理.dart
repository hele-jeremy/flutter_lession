import 'package:flutter/material.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/page_args.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/page_modle1.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/route_page_1.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

///路由管理
///路由（Route）在移动开发中通常指页面（Page），这跟 Web 开发中单页应用的 Route 概念意义是相同的，
///Route 在 Android中 通常指一个 Activity，在 iOS 中指一个 ViewController。
///所谓路由管理，就是管理页面之间如何跳转，通常也可被称为导航管理。
///Flutter 中的路由管理和原生开发类似，无论是 Android 还是 iOS，导航管理都会维护一个路由栈，
///路由入栈（push）操作对应打开一个新页面，路由出栈（pop）操作对应页面关闭操作，
///而路由管理主要是指如何来管理路由栈。

class RouteTestWidget extends StatefulWidget {
  const RouteTestWidget({Key? key}) : super(key: key);

  @override
  State<RouteTestWidget> createState() => _RouteTestWidgetState();
}

class _RouteTestWidgetState extends State<RouteTestWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("路由测试界面"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () async {
                    ///Navigator打开一个新的路由页面,同时push方法会返回一个Future
                    ///使用Future可以接收打开目标页面返回给当前页面的数据
                    var returnData = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RoutePage1(
                        args: PageArgs.from(["1000100101", 2]),
                      );
                    }));

                    LogUtils.d("RoutePage1 returu data:$returnData");
                    // assert(returnData is PageModel1);
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("接收到返回的数据:\n$returnData"),
                      duration: const Duration(milliseconds: 1200),
                    ));
                  },
                  child: const Text(
                    "非命名路由的方式:\n打开页面一",
                    textAlign: TextAlign.center,
                  ))),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RoutePage1.routeName,
                        arguments: PageArgs(id: "2131313", action: 33))
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("命名路由接收页面结果:\n$value")));
                });
              },
              child: const Text(
                "命名路由的方式:\n打开页面一(传参数)",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () async {
                var nameRouteReturnValue =
                    await Navigator.of(context).pushNamed(RoutePage1.routeName);

                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("命名路由不传参接收结果:\n$nameRouteReturnValue")));
              },
              child: const Text("命名路由方式:\n打开页面一(不传参)"),
            ),
          )
        ],
      ),
    );
  }
}
