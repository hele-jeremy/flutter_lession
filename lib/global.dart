import 'package:flutter_lesson/utils/log_utils.dart';

///全局初始化类
class Global {
  static void init() {
    LogUtils.init(isDebug: true);
  }
}
