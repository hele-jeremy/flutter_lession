import 'package:flutter/material.dart';

///继承Extensions:
///实现implements:
///混合:mixin

class DartExtensionImplementsMixin extends StatelessWidget {
  const DartExtensionImplementsMixin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MaterialButton(
                onPressed: _extensionTest,
                child: Text("继承Extension",
                    style: Theme.of(context).textTheme.headline6))
          ])),
      Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MaterialButton(
                onPressed: _implementsTest,
                child: Text("实现implements",
                    style: Theme.of(context).textTheme.headline6))
          ])),
      Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MaterialButton(
                onPressed: _mixinTest,
                child: Text("混合mixin",
                    style: Theme.of(context).textTheme.headline6))
          ]))
    ]);
  }

  void _extensionTest() {

  }

  void _implementsTest() {

  }

  void _mixinTest() {

  }
}
