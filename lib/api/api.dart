import 'package:wanandroidflutter/util/http_util.dart';

class Api{
  static Stream getBanner() => Stream.fromFuture(HttpUtil.requestGet('/banner/json'));

//  static Stream getHomeArticleList() => Stream.fromFuture(HttpUtil.requestGet('/article/list/0/json'));

  static Future  getHomeArticleList() =>HttpUtil.requestGet('/article/list/0/json');
}