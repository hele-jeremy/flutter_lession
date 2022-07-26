import 'package:flutter/material.dart';

class MinePageWidget extends StatefulWidget {
  const MinePageWidget({Key? key}) : super(key: key);

  @override
  State<MinePageWidget> createState() => _MinePageWidgetState();
}

class _MinePageWidgetState extends State<MinePageWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("个人中心"),
      ),
      body: const Center(
        child: Text("个人中心页面"),
      ),
    );
  }
}
