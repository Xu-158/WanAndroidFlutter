import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wanandroidflutter/common/global.dart';

typedef OnSuccessList<T>(List<T> successList);
typedef OnFail(String message);
typedef OnSuccess<T>(T success);

class HttpUtil {

  static Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    contentType: 'application/json',
  ))..interceptors.add(interceptorsWrapper);

  //拦截器
  static InterceptorsWrapper interceptorsWrapper =
      InterceptorsWrapper(onRequest: (RequestOptions options) {
    debugPrint(
        "==========请求Url=================================================");
    debugPrint("===url:::${options.uri}");
    debugPrint("===params:::${options.data}");
  }, onResponse: (Response response) {
    debugPrint(
        "=========请求结果=================================================");
    debugPrint("===statusCode:::${response.statusCode}");
    debugPrint("===response:::${response.data}");
  }, onError: (DioError error) {
    debugPrint(
        "=========请求错误=================================================");
    debugPrint("===statusCode:::${error.message}");
  });

  Future requestGet(url,
      {Map<String, dynamic> parameters,
      contentType = 'application/json',
      options}) async {
    Response response =
        await dio.get(url, queryParameters: parameters, options: options);
    return response.data;
  }

  Future requestPost(url,
      {Map<String, dynamic> parameters,
      contentType = 'application/json',
      options}) async {
    Response response =
        await dio.post(url, queryParameters: parameters, options: options);
    return response.data;
  }
}
