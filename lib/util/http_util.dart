import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:wanandroidflutter/util/path_util.dart';

class HttpUtil {
  static var cookieJar = PersistCookieJar(dir: '${PathUtil.appDocPath}/');
  static Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    contentType: 'application/json',
  ))
    ..interceptors.add(interceptorsWrapper)
    ..interceptors.add(CookieManager(cookieJar));

  //拦截器
  static InterceptorsWrapper interceptorsWrapper =
      InterceptorsWrapper(onRequest: (RequestOptions options) {
    debugPrint("===================== 请求Url:::${options.uri} ===========");
    debugPrint("===params:::${options.queryParameters}");
    debugPrint("===cookieHeader:::${options.headers[HttpHeaders.setCookieHeader]}");
  }, onResponse: (Response response) {
    debugPrint("===cookieHeader:::${response.headers[HttpHeaders.setCookieHeader]}");
    debugPrint(
        "===================== 请求结果 statusCode:::${response.statusCode} =========");
    debugPrint("response:::${response.data}");
  }, onError: (DioError error) {
    debugPrint(
        "===================== 请求错误 statusCode:::${error.message} =========");
  });

  static Future requestGet(url,
      {Map<String, dynamic> parameters,
      contentType = 'application/json',
      Options options}) async {
    Response response =
        await dio.get(url, queryParameters: parameters, options: options);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  }

  static Future requestPost(url,
      {Map<String, dynamic> parameters,
      contentType = 'application/json',
      Options options,
      dynamic data}) async {
    Response response = await dio.post(url,
        queryParameters: parameters, data: data, options: options);
    if (response.statusCode == 200) {
      print('headerheader${response.headers}');
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  }
}
