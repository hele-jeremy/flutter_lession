import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWordWidget extends StatefulWidget {
  static const routeName = "random_word_widget_route";

  const RandomWordWidget({Key? key}) : super(key: key);

  @override
  State<RandomWordWidget> createState() => _RandomWordWidgetState();
}

class _RandomWordWidgetState extends State<RandomWordWidget> {
  WordPair _wordPair = WordPair("Dart", "Flutter");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Flutter中包package的管理.引入.使用",
            style: TextStyle(fontSize: 16),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(("first:${_wordPair.first}-second:${_wordPair.second}")),
              const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              ElevatedButton(
                  onPressed: () {
                    mockRandomEnglishWordAndUpdateUI();
                  },
                  child: const Text("获取随机字母单词"))
            ],
          ),
        ));
  }

  void mockRandomEnglishWordAndUpdateUI() {
    setState(() {
      _wordPair = WordPair.random();
    });
  }
}
