import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson/flutter_lession/extensions.dart';

class FlutterCommonBasicWidget extends StatefulWidget {
  static const routeName = "flutter_common_basic_widget_route";

  const FlutterCommonBasicWidget({Key? key}) : super(key: key);

  @override
  State<FlutterCommonBasicWidget> createState() =>
      _FlutterCommonBasicWidgetState();
}

class _FlutterCommonBasicWidgetState extends State<FlutterCommonBasicWidget> {
  static const String url = "https://www.google.com/";
  static const String girlUrl =
      "https://pic.3gbizhi.com/2019/0907/thumb_1680_0_20190907025106350.jpg";
  late TapGestureRecognizer _recognizer;

  bool _switchState = true;
  bool _checkboxState = true;
  bool? _checkboxState2 = true;

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("常用基础组件"),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "文本组件" * 30,

                  ///对齐的参考系是Text widget 本身
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                  ///代表文本相对于当前字体大小的缩放因子，相对于去设置文本的样式style属性的fontSize，
                  ///它是调整字体大小的一个快捷方式。该属性的默认值可以通过MediaQueryData.textScaleFactor获得，
                  ///如果没有MediaQuery，那么会默认值将为1.0。
                  textScaleFactor: 2,
                )),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "文本组件2" * 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,

                    ///fontSize可以精确指定字体大小，而textScaleFactor只能通过缩放比例来控制。
                    /// textScaleFactor主要是用于系统字体大小设置改变时对 Flutter 应用字体进行全局调整，
                    /// 而fontSize通常用于单个文本，字体大小不会跟随系统字体大小变化
                    fontSize: 18.0,

                    ///该属性用于指定行高，但它并不是一个绝对值，而是一个因子，具体的行高等于fontSize*height
                    height: 1.5,
                    background: Paint()..color = Colors.yellow,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed),
              ),
            ),
            Text.rich(TextSpan(children: [
              const TextSpan(text: "首页地址:"),
              TextSpan(
                  text: url,
                  style: const TextStyle(color: Colors.blue),
                  recognizer: _recognizer
                    ..onTap = () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("打开网址:\n$url"),
                        duration: Duration(milliseconds: 500),
                      ));
                    })
            ], style: const TextStyle(fontSize: 20))),

            ///在 Widget 树中，文本的样式默认是可以被继承的（子类文本类组件未指定具体样式时可以使用 Widget 树中父级设置的默认样式），
            ///因此，如果在 Widget 树的某一个节点处设置一个默认的文本样式，那么该节点的子树中所有文本都会默认使用这个样式，
            ///而DefaultTextStyle正是用于设置默认文本样式的
            DefaultTextStyle(
                style: const TextStyle(color: Colors.red, fontSize: 22),
                child: Column(
                  children: [
                    // ...3.reduceTimes((time) => Text(
                    //       "子文本${++time}",
                    //       style: time == 3
                    //           ? TextStyle(
                    //
                    //               ///是否继承DefaultTextStyle中的样式
                    //               inherit: false,
                    //               color: Colors.green,
                    //               fontSize: 30,
                    //               background: Paint()..color = Colors.purple)
                    //           : null,
                    //     ))

                    for (int i = 0; i < 3; i++)
                      Text(
                        "子文本${i + 1}",
                        style: i == 2
                            ? TextStyle(

                                ///是否继承DefaultTextStyle中的样式
                                inherit: false,
                                color: Colors.green,
                                fontSize: 30,
                                background: Paint()..color = Colors.purple)
                            : null,
                      ),
                  ],
                )),
            ElevatedButton(
                onPressed: () {}, child: const Text("ElevatedButton")),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.send),
                label: const Text("EvelatedButton发送")),
            TextButton(onPressed: () {}, child: const Text("TextButton")),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.info),
                label: const Text("TextButton详情")),
            OutlinedButton(
                onPressed: () {}, child: const Text("OutlinedButton")),
            OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text("OutlinedButton添加")),
            IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_up)),
            const Image(
              image: AssetImage("assets/images/user_avatar.png"),
              width: 100,
              height: 100,
            ),
            Image.asset(
              "assets/images/user_avatar.png",
              height: 200,
              width: 200,
            ),
            const Image(
                image: NetworkImage(girlUrl) /*,width: 100,height: 100,*/),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.network(
                  girlUrl,
                  width: 160,
                  height: 90,
                )),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Image的缩放模式(BoxFit)",
                style: TextStyle(
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                    fontSize: 22),
              ),
            ),
            ...<BoxFit, String>{
              BoxFit.fill:
                  "https://flutter.github.io/assets-for-api-docs/assets/painting/box_fit_fill.png",
              BoxFit.contain:
                  "https://flutter.github.io/assets-for-api-docs/assets/painting/box_fit_contain.png",
              BoxFit.cover:
                  "https://flutter.github.io/assets-for-api-docs/assets/painting/box_fit_cover.png",
              BoxFit.fitWidth:
                  "https://flutter.github.io/assets-for-api-docs/assets/painting/box_fit_fitWidth.png",
              BoxFit.fitHeight:
                  "https://flutter.github.io/assets-for-api-docs/assets/painting/box_fit_fitHeight.png",
              BoxFit.none:
                  "https://flutter.github.io/assets-for-api-docs/assets/painting/box_fit_none.png",
              BoxFit.scaleDown:
                  "https://flutter.github.io/assets-for-api-docs/assets/painting/box_fit_scaleDown.png"
            }.transformMap((entry) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text("Boxfit.${entry.key.name}"),
                    ),
                    Image.network(entry.value)
                  ],
                )),

            ///图标IconFont的使用(Flutter内置和自定义字体图标)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.accessible, color: Colors.green),
                  Icon(Icons.error, color: Colors.red),
                  Icon(Icons.fingerprint, color: Colors.green)
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("是否开启:"),
                Switch(
                    value: _switchState,
                    activeColor: Colors.blue,
                    onChanged: (value) => setState(() {
                          _switchState = value;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(value ? "开" : "关"),
                            duration: const Duration(milliseconds: 100),
                          ));
                        })),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("是否选择:"),
                  Checkbox(
                    value: _checkboxState,
                    activeColor: Colors.red,
                    onChanged: (value) => setState(() {
                      _checkboxState = value ?? false;
                    }),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("三种选择状态:"),
                Checkbox(
                    value: _checkboxState2,
                    activeColor: Colors.black,
                    tristate: true,
                    onChanged: (value) => setState(() {
                          _checkboxState2 = value;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text((value == null)
                                ? "没有选项的状态"
                                : (value ? "选择" : "不选择")),
                            duration: const Duration(milliseconds: 100),
                          ));
                        }))
              ],
            )
          ],
        ))));
  }
}
