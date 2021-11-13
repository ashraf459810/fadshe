import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/network/result.dart';

abstract class ApiRequest {
  Result handleError(DioError error) {
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CONNECT_TIMEOUT:
          return Result(isSuccessful: false, message: 'check_connection'.tr());
        case DioErrorType.RESPONSE:
          if (error.response.statusCode == 403) {
            try {
              Map<String, dynamic> errorObj = json.decode(error.response.toString());
              return Result(isSuccessful: false, message: errorObj['message']);
            } catch (err) {
              // Case Wrong credentials in login (Code 400 , Response: [])
              return Result(isSuccessful: false, message: error.response.headers.value('message'));
            }
          }
          return Result(isSuccessful: false, message: error.message);

        default:
          return Result(isSuccessful: false, message: error.message);
      }
    } else
      return Result(isSuccessful: false, message: error.message);
  }
}
