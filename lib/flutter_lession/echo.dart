import 'package:flutter/material.dart';

class Echo extends StatelessWidget {
  final String text;
  final Color backgroundColors;

  const Echo(
      {Key? key, required this.text, this.backgroundColors = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColors,
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
