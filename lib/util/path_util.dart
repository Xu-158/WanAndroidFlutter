import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PathUtil {
  static String appDocPath;

  static Future getTemporary() async {
    Directory appDocDir = await getTemporaryDirectory();
    appDocPath = appDocDir.path;
    return appDocPath;
  }
}
