import 'package:flutter/material.dart';
import 'package:flutter_lesson/flutter_lession/extensions.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

class FlutterTextFieldAndFormWidget extends StatefulWidget {
  static const String routeName = "flutter_textfield_and_form_widget_route";

  const FlutterTextFieldAndFormWidget({Key? key}) : super(key: key);

  @override
  State<FlutterTextFieldAndFormWidget> createState() =>
      _FlutterTextFieldAndFormWidgetState();
}

class _FlutterTextFieldAndFormWidgetState
    extends State<FlutterTextFieldAndFormWidget> {
  late TextEditingController _textEditingUserNameController;
  late TextEditingController _textEditingUserPwdController;

  late FocusNode _userNameFocusNode;
  late FocusNode _userPwdFocusNode;
  FocusScopeNode? _focusScopeNode;
  bool _enableUserName = true;

  late FocusNode _userPhoneFocusNode;
  Color _userPhoneUnderLineBorderColor = Colors.grey;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _formUserNameController = TextEditingController();
  final TextEditingController _formUserPwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingUserNameController = TextEditingController()
      ..text = "190610420@qq.com"
      ..addListener(() {
        LogUtils.d(
            "_textEditingUserNameController text : ${_textEditingUserNameController.text}");
      });

    _textEditingUserNameController.selection = TextSelection(
        baseOffset: 3,
        extentOffset: _textEditingUserNameController.text.length);

    _textEditingUserPwdController = TextEditingController()
      ..addListener(() {
        LogUtils.d(
            "_textEditingUserPwdController text : ${_textEditingUserPwdController.text}");
      });

    ///焦点控制以及监听焦点的改变
    _userNameFocusNode = FocusNode()
      ..addListener(() {
        LogUtils.d(
            "focus _userNameFocusNode : ${_userNameFocusNode.hasFocus} - ${_userNameFocusNode.size}}");
      });
    _userPwdFocusNode = FocusNode()
      ..addListener(() {
        LogUtils.d(
            "focus _userPwdFocusNode : ${_userPwdFocusNode.hasFocus} - ${_userPwdFocusNode.size}}");
      });

    _userPhoneFocusNode = FocusNode()
      ..addListener(() {
        setState(() {
          _userPhoneUnderLineBorderColor =
              _userPhoneFocusNode.hasFocus ? Colors.black : Colors.grey;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("TextFidld和Form组件"),
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        "TextField和Form表单",
                        style: TextStyle(
                            color: Colors.red,
                            fontStyle: FontStyle.italic,
                            fontSize: 22),
                      )),
                  TextField(
                    autofocus: true,
                    focusNode: _userNameFocusNode,
                    enabled: _enableUserName,
                    //自动获取焦点
                    controller: _textEditingUserNameController,
                    onChanged: (value) {
                      LogUtils.d('username onChanged:$value');
                    },
                    onSubmitted: (value) {
                      LogUtils.d("username onSubmitted:$value");
                    },
                    onEditingComplete: () {
                      LogUtils.d("username onEdittingComplete");
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        labelText: "用户名",
                        hintText: "用户名或邮箱",
                        prefixIcon: Icon(Icons.person),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue))),
                    cursorColor: Colors.red,
                    cursorWidth: 2,
                    cursorRadius: const Radius.circular(45),
                  ),
                  TextField(
                    focusNode: _userPwdFocusNode,
                    controller: _textEditingUserPwdController,
                    onChanged: (value) {
                      LogUtils.d("userpwd onChanged:$value");
                    },
                    onSubmitted: (value) {
                      LogUtils.d("userpwd onSubmitted:$value");
                    },
                    onEditingComplete: () {
                      LogUtils.d("userpwd onEdittingComplete");
                    },
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        labelText: "密码",
                        hintText: "你的登录密码",
                        prefixIcon: Icon(Icons.lock)),
                    obscureText: true, //掩码展示文字
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: 3.reduceTimes(
                            (value) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  switch (value) {
                                    case 0:
                                      moveTextFieldFocus(context);
                                      break;
                                    case 1:
                                      hideSoftKeyboard();
                                      break;
                                    case 2:
                                      _toggleUserNameEnable();
                                      break;
                                  }
                                },
                                child: Text((value < 2)
                                    ? ((value == 0) ? "移动焦点" : "影藏键盘")
                                    : "禁用用户名输入"),
                              ),
                            ),
                          ))),

                  ///通过Theme主题来设置TextField样式style
                  const Padding(padding: EdgeInsets.all(10)),
                  Theme(
                      data: Theme.of(context).copyWith(
                        hintColor: Colors.redAccent[200],
                        inputDecorationTheme: const InputDecorationTheme(
                            labelStyle: TextStyle(color: Colors.redAccent),
                            hintStyle:
                                TextStyle(color: Colors.yellow, fontSize: 14)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: _userPhoneUnderLineBorderColor,
                                        width: 1.0))),
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              focusNode: _userPhoneFocusNode,
                              decoration: const InputDecoration(
                                  labelText: "手机号码",
                                  hintText: "请输入手机号码",
                                  prefixIcon: Icon(Icons.phone),
                                  border: InputBorder.none),
                            ),
                          ),
                          const TextField(
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                labelText: "密码",
                                hintText: "您的密码",
                                prefixIcon: Icon(Icons.lock),
                                hintStyle: TextStyle(
                                    color: Colors.purple, fontSize: 10)),
                          )
                        ],
                      )),

                  ///Form表单的使用
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                controller: _formUserNameController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                                validator: (content) {
                                  return (content?.trim().isNotEmpty ?? false)
                                      ? null
                                      : "用户名不能为空";
                                },
                                decoration: const InputDecoration(
                                    label: Text("用户名"),
                                    hintText: "请输入用户名",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                    prefixIcon: Icon(Icons.person)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                              child: TextFormField(
                                controller: _formUserPwdController,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                                obscureText: true,
                                validator: (content) {
                                  return (content?.trim().length ?? 0) < 6
                                      ? "密码不能少于6位"
                                      : null;
                                },
                                decoration: const InputDecoration(
                                    label: Text("密码"),
                                    hintText: "请输入密码",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                    prefixIcon: Icon(Icons.lock)),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: Builder(
                                      builder: (context) => ElevatedButton(
                                          onPressed: () {
                                            doLogin(context);
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(15),
                                            child: Text("登录"),
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  )
                ])),
          ),
        ));
  }

  ///影藏软键盘
  void hideSoftKeyboard() {
    _userPwdFocusNode.unfocus();
    _userNameFocusNode.unfocus();
  }

  ///移动TextField焦点
  void moveTextFieldFocus(BuildContext context) {
    ///第一种写法
    // FocusScope.of(context).requestFocus(_userPwdFocusNode);
    (_focusScopeNode ??= FocusScope.of(context))
        .requestFocus(_userPwdFocusNode);
  }

  void _toggleUserNameEnable() {
    setState(() {
      _enableUserName = !_enableUserName;
    });
  }

  void doLogin(BuildContext context) {
    //Null check operator used on a null value
    ///通过Form.of(context)的方式来寻找FormState需要注意传入的context是哪一个context对象
    if (Form.of(context)!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("验证通过,执行登录"),
        duration: Duration(milliseconds: 300),
      ));
      Navigator.of(context).pop();
    }

    ///GlobalKey则不受影响
    // if (_formKey.currentState!.validate()) {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text("验证通过,执行登录"),
    //     duration: Duration(milliseconds: 300),
    //   ));
    //   Navigator.of(context).pop();
    // }
  }
}
