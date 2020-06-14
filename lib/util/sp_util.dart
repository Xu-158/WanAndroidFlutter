import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroidflutter/widget/common/toast.dart';

class SPUtil {
  //key
  static String get historySearch => 'historySearch';
  static String get userInfo => 'userInfo';

  static Future setData(
      {@required String type, @required key, @required value}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    switch (type) {
      case 'String':
        sp.setString(key, value);
        break;
      case 'bool':
        sp.setBool(key, value);
        break;
      case 'double':
        sp.setDouble(key, value);
        break;
      case 'int':
        sp.setInt(key, value);
        break;
      case 'List':
        sp.setStringList(key, value);
        break;
      default:
        break;
    }
  }

  static Future get({@required String type, @required key}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    switch (type) {
      case 'String':
        return sp.getString(key);
        break;
      case 'bool':
        return sp.getBool(key);
        break;
      case 'double':
        return sp.getDouble(key);
        break;
      case 'int':
        return sp.getInt(key);
        break;
      case 'List':
        return sp.getStringList(key);
        break;
      default:
        break;
    }
  }

  static Future remove(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if(!sp.containsKey(key)){
      showToast(message: '删除失败');
    }
    sp.remove(key);
  }
}
