import 'package:flutter/material.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/route_config.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

class MinePageWidget extends StatefulWidget {
  const MinePageWidget({Key? key}) : super(key: key);

  @override
  State<MinePageWidget> createState() => _MinePageWidgetState();
}

class _MinePageWidgetState extends State<MinePageWidget> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments ?? "";
    LogUtils.d("MinePageWidget args:$args");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("个人中心"),
      ),
      body: Center(
        child: Column(children: [
          Text("个人中心页面\n接收数据:${args.toString()}"),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Text(""),
          ),
          ElevatedButton(
              onPressed: () {
                hasLogin = false;
                Navigator.pushNamedAndRemoveUntil(
                    context, loginPageRoute, (route) => false);
              },
              child: const Text("退出登录"))
        ]),
      ),
    );
  }
}
