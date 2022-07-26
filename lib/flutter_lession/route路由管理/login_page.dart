import 'package:flutter/material.dart';
import 'package:flutter_lesson/flutter_lession/route%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/route_config.dart';
import 'package:flutter_lesson/utils/log_utils.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("登录"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            children: [
              const TextField(),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: const TextField(),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    hasLogin = true;
                    var settings = ModalRoute.of(context)?.settings;
                    var name = settings?.name;
                    var arguments = settings?.arguments;

                    LogUtils.d(
                        "_LoginPageWidgetState name:$name : arguments:$arguments");
                    // Navigator.of(context).pop();
                    if (name?.isNotEmpty ?? false) {
                      Navigator.of(context)
                          .popAndPushNamed(name!, arguments: arguments);
                    }

                  },
                  child: const Text("登录"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
