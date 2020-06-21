import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  //key
  static String get historySearch => 'historySearch';
  static String get userInfo => 'userInfo';
  static String get qqAvatarUrl => 'qqAvatarUrl';
  static String get themeColor => 'themeColor';

  static Future setData({@required type, @required key, @required value}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    switch (type) {
      case String:
        sp.setString(key, value);
        break;
      case bool:
        sp.setBool(key, value);
        break;
      case double:
        sp.setDouble(key, value);
        break;
      case int:
        sp.setInt(key, value);
        break;
      case List:
        sp.setStringList(key, value);
        break;
      default:
        break;
    }
  }

  static Future get({@required type, @required key, defaultValue}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    switch (type) {
      case String:
        return sp.getString(key) ?? defaultValue;
        break;
      case bool:
        return sp.getBool(key) ?? defaultValue;
        break;
      case double:
        return sp.getDouble(key) ?? defaultValue;
        break;
      case int:
        return sp.getInt(key) ?? defaultValue;
        break;
      case List:
        return sp.getStringList(key) ?? defaultValue;
        break;
      default:
        break;
    }
  }

  static Future remove(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (!sp.containsKey(key)) return;
    sp.remove(key);
  }

  static Future<bool> containsKey(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.containsKey(key);
  }
}
