import 'package:wanandroidflutter/util/http_util.dart';

class Api {
  ///HomePage Api======================================================================
//  static Stream getBanner() => Stream.fromFuture(HttpUtil.requestGet('/banner/json1'));
  static Future getBanner({page = 0}) => HttpUtil.requestGet('/banner/json');

  static Future getHomeArticleList({page = 0}) =>
      HttpUtil.requestGet('/article/list/$page/json');

  ///ProjectPage Api======================================================================
  static Future getProjectTree() => HttpUtil.requestGet('/project/tree/json');

  static Future getProjectList({page = 0, cid = 294}) =>
      HttpUtil.requestGet('/project/list/$page/json?cid=$cid');
}
