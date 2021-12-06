import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/repositories/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RequestInterceptor extends Interceptor {
  @override
  Future onRequest(
    RequestOptions options,
  ) async {
    if (isProtectedEndpoint(
      options.path,
    )) {
      String token = await getIt<FlutterSecureStorage>().read(key: 'token');

      options.queryParameters.addAll({'api_token': token});
      options.headers.addAll({'X-Requested-With': 'XMLHttpRequest'});
      return options;
    }
  }

  bool isProtectedEndpoint(String path) {
    return path.contains('user') ||
        path.contains('User') ||
        path.contains('Wishlist') ||
        path.contains('Cart') ||
        path.contains('Order') ||
        path.contains('Invoice') ||
        path.contains('Rates') ||
        path.contains('Comments') ||
        path.contains('Payments');
  }

  @override
  Future onError(DioError err) async {
    log(err.message);
    if (err.response.statusCode == 401) {
      await getIt<UserRepository>().logout();
      navService.pushNamedAndRemoveUntil('/');
    } else
      return super.onError(err);
  }
}
