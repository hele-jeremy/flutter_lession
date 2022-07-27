import 'package:flutter/material.dart';

class NotFoundPageWidget extends StatelessWidget {
  final RouteSettings? settings;

  const NotFoundPageWidget({Key? key, this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("异常"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("未找到以下的路由界面"),
            const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
            Text("路由名:${settings?.name ?? "unknown"}"),
            const Padding(padding: EdgeInsets.fromLTRB(0, 10, 10, 10)),
            Text("参数:${settings?.arguments ?? "unknown"}")
          ],
        ),
      ),
    );
  }
}
