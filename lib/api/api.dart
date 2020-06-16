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

  ///Login Api===================================================================
  static Future login({username, password}) {
    FormData form =
        FormData.fromMap({'username': username, 'password': password});
    return HttpUtil.requestPost('/user/login', data: form);
  }

  static Future register({username, password, repassword}) {
    FormData form = FormData.fromMap(
        {'username': username, 'password': password, 'repassword': repassword});
    return HttpUtil.requestPost('/user/register', data: form);
  }

  static Future logout() {
    return HttpUtil.requestGet('/user/logout/json');
  }

  ///Integral Api================================================================
  static Future getUserIntegral() {
    return HttpUtil.requestGet('/lg/coin/userinfo/json');
  }

  ///Collect Api===================================================================
  static Future getCollectArticleList({page = 0}) {
    return HttpUtil.requestGet('/lg/collect/list/$page/json');
  }

  static Future doCollectArticle({articleId = 1186}) {
    return HttpUtil.requestPost('/lg/collect/$articleId/json');
  }

  static Future unCollectArticleByHome({articleId = 1186}) {
    return HttpUtil.requestPost('/lg/uncollect_originId/$articleId/json');
  }

  static Future unCollectArticleByMine({articleId = 1186,originId = -1}) {
    FormData form =
    FormData.fromMap({'originId': originId});
    return HttpUtil.requestPost('/lg/uncollect/$articleId/json',data: form);
  }
}
