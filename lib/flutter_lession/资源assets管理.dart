import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AssetsManageWidget extends StatefulWidget {
  static const routeName = "assets_manage_widget_route";

  const AssetsManageWidget({Key? key}) : super(key: key);

  @override
  State<AssetsManageWidget> createState() => _AssetsManageWidgetState();
}

class _AssetsManageWidgetState extends State<AssetsManageWidget> {
  String _configJson = "";
  String _rootBundleConfigJson = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("资源管理"),
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Builder(builder: (context) {
                    return ElevatedButton(
                        onPressed: () {
                          ///应用可以通过AssetBundle对象访问其asset.有两种主要方法允许从 Asset bundle 中加载字符串或图片（二进制）文件
                          ///rootBundle
                          ///DefaultAssetBundle
                          _loadLocalJson(context);
                        },
                        child: const Text("通过DefaultAssetBundle加载assets文本资源"));
                  }),
                  Text("asset加载文本:\n$_configJson"),
                  const Padding(padding: EdgeInsets.all(10)),
                  ElevatedButton(
                      onPressed: () {
                        _loadLocalJsonFromRootBundle();
                      },
                      child: const Text("通过rootBundle来加载assets文本资源")),
                  const Padding(padding: EdgeInsets.all(5)),
                  Text("rootBundle load assets json:\n$_rootBundleConfigJson"),
                  const Padding(padding: EdgeInsets.all(10)),
                  const Text(
                    "通过AssetImage图片加载(自动处理图片分辨率)",
                    style: TextStyle(
                        color: Colors.red, fontStyle: FontStyle.italic),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  const DecoratedBox(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/user_avatar.png"))),
                      child: SizedBox(
                        width: 150,
                        height: 150,
                      )),
                  const Text(
                    "通过Image.asseet加载图片(自动适配分辨率)",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontStyle: FontStyle.italic),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Image.asset(
                          "assets/images/to_wechat_realname_auth.png")),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      "还可以加载本地平台资源",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          color: Colors.red),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _loadLocalJson(BuildContext context) async {
    ///依赖于BuildContext上下文句柄
    _configJson =
        await DefaultAssetBundle.of(context).loadString("assets/config.json");
    setState(() {});
  }

  void _loadLocalJsonFromRootBundle() async {
    _rootBundleConfigJson = await rootBundle.loadString("assets/config.json");
    setState(() {});
  }
}
