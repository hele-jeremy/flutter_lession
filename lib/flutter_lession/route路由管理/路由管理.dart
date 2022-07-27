import 'package:flutter/material.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/page_args.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/route_config.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/route_page_1.dart';

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
                        ///通过构造函数的方式传递参数(这种一般适用于非命名路由的方式进行传值)
                        args: PageArgs.from(["1000100101", 2]),
                      );
                    }));

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
                ///通过路由名打开新路由页
                Navigator.of(context)
                    .pushNamed(RoutePage1.routeName,

                        ///传递参数(命名路由的方式进行传参)
                        arguments: PageArgs(id: "2131313", action: 33))
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("命名路由接收页面结果:\n$value")));
                });
              },
              child: const Text(
                "命名路由的方式:\n打开页面一(传参)",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () async {
                ///没有传递参数,在路由表中会传递一个默认参数
                var nameRouteReturnValue =
                    await Navigator.of(context).pushNamed(RoutePage1.routeName);

                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("命名路由不传参接收结果:\n$nameRouteReturnValue")));
              },
              child: const Text("命名路由方式:\n打开页面一(不传参)"),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                //https://zhuanlan.zhihu.com/p/56289929
                Navigator.of(context).pushNamed(minePageRoute,
                    arguments: "传递给MinePage的参数:xxxxxx");
              },
              child: const Text("通过路由生成钩子"),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/unkonwn_route",
                  arguments: "未知参数:xxxx"),
              child: const Text("测试打开一个未知的路由"),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(

                    ///如果想在弹出新路由之前，删除路由栈中的部分路由
                    ///利用ModalRoute.withName(name)，来执行判断，当所传的name跟堆栈中的路由所定义的时候，
                    ///会返回true值，不匹配的话，则返回false
                    context,
                    minePageRoute,
                    ModalRoute.withName(initRoute));

                ///popUntil()方法的过程其实跟上面差不多，就是是少了push一个新页面的操作，只是单纯的进行移除路由操作
                ///pushReplacementNamed() popAndPushNamed() () 移除跳转到新界面或者用界面替换当前的界面
              },
              child: const Text("测试pushNamedAndRemoveUntil使用"),
            ),
          )
        ],
      ),
    );
  }
}
