import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

///Dart中的类

class DartClasses extends StatelessWidget {
  const DartClasses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MaterialButton(
                onPressed: _dartClassTest,
                child: Text("Dart中的类",
                    style: Theme.of(context).textTheme.headline6))
          ]))
    ]);
  }

  void _dartClassTest() {
    var point = const Point<double>(2.22, 3.32);
    assert(point.x == 2.22);
    var distanceTo = point.distanceTo(const Point(0.0, 1.11));
    LogUtils.d("distanceTo : $distanceTo");




  }
}

class DClass {

}
