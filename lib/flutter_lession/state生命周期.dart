import 'package:flutter/material.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

class CounterStateWidget extends StatefulWidget {
  final int initValue;

  const CounterStateWidget({Key? key, this.initValue = 0}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyCounterState();
}

class MyCounterState extends State<CounterStateWidget> {
  //计数器的值
  int _count = 0;

  @override
  void initState() {
    super.initState();
    LogUtils.d("initState.......");
    _count = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => setState(() {
            _count++;
          }),
          child: Text("$_count",style: Theme.of(context).textTheme.headline3,),
        ),
      ),
    );
  }
}
