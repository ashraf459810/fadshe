import 'package:dio/dio.dart';
import 'package:fad_shee/network/request_interceptor.dart';

class DioHttpClient {
  DioHttpClient._();

  static Dio _instance;
  static String baseUrl = 'https://fadshee.com/api';

  static Dio getInstance() {
    if (_instance == null) {
      //_instance = Dio();
      _instance = Dio()
        ..interceptors.add(RequestInterceptor())
        ..interceptors.add(LogInterceptor(responseBody: true));
    }
    return _instance;
  }
}
