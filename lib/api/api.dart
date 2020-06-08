import 'package:wanandroidflutter/util/http_util.dart';

class Api{
///HomePage Api======================================================================
  static Stream getBanner() => Stream.fromFuture(HttpUtil.requestGet('/banner/json'));

  static Future  getHomeArticleList({page=0}) =>HttpUtil.requestGet('/article/list/$page/json');
}