import 'package:dio/dio.dart';
import 'package:wanandroidflutter/common/global_val.dart';

Future requestGet({
  contentType = '',
  data,
  url,
}) async {
  Dio dio = Dio();
  dio.options.contentType = contentType;
  dio.options.connectTimeout = 5000;
  dio.options.receiveTimeout = 3000;
  dio.options.baseUrl = baseUrl;
  Response response = await dio.get(url, queryParameters: data);
  return response;
}
