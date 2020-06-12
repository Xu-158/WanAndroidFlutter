import 'package:dio/dio.dart';
import 'package:wanandroidflutter/util/http_util.dart';

class Api {
  ///HomePage Api=====================================================================
  static Future getBanner({page = 0}) => HttpUtil.requestGet('/banner/json');

  static Future getHomeArticleList({page = 0}) =>
      HttpUtil.requestGet('/article/list/$page/json');

  ///ProjectPage Api==================================================================
  static Future getProjectTree() => HttpUtil.requestGet('/project/tree/json');

  static Future getProjectList({page = 0, cid = 294}) =>
      HttpUtil.requestGet('/project/list/$page/json?cid=$cid');

  ///SearchPage Api===================================================================
  static Future getHotSearch() => HttpUtil.requestGet('/hotkey/json');

  static Future postSearch({page = 0, key = 'flutter'}) {
    FormData form = FormData.fromMap({'k': key});
    return HttpUtil.requestPost('/article//query/$page/json',
        data: form, contentType: 'application/x-www-form-urlencoded');
  }
}
