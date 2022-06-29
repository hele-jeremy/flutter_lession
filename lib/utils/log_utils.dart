///日志工具类
class LogUtils {
  static const String _logTagDef = "::j_logger::";
  static bool debuggable = false;
  static String tag = _logTagDef;

  static void init({bool isDebug = false, String logTag = _logTagDef}) {
    debuggable = isDebug;
    tag = logTag;
  }

  static void e(Object printObj, {String? tag}) {
    if (debuggable) {
      _printLog(tag, ' e ', printObj);
    }
  }

  static void d(Object printObj, {String? tag}) {
    if (debuggable) {
      _printLog(tag, ' d ', printObj);
    }
  }

  static void _printLog(String? logTag, String sTag, Object needPrintObject) {
    var sb = StringBuffer();
    sb.write((logTag == null || logTag.isEmpty) ? tag : logTag);
    sb.write(sTag);
    sb.write(needPrintObject);
    // ignore: avoid_print
    print(sb.toString());
  }
}
