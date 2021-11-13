import 'package:dio/dio.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/user.dart';
import 'package:fad_shee/network/api_request.dart';
import 'package:fad_shee/network/dio_http_client.dart';
import 'package:fad_shee/network/result.dart';

class UserInfo extends ApiRequest {
  Future<Result> fetchUserData() async {
    String url = '${DioHttpClient.baseUrl}/user';
    try {
      Response response = await getIt.get<Dio>().get(url);
      var jsonData = response.data;
      if (response.statusCode == 200) {
        return Result(isSuccessful: true, result: User.fromJson(jsonData));
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> updateUserData(User user) async {
    String url = '${DioHttpClient.baseUrl}/User/Update';
    try {
      print('User to update: ${user.toJson()}');
      Response response = await getIt.get<Dio>().post(url, data: user.toJson());
      var jsonData = response.data;
      if (response.statusCode == 200) {
        return Result(isSuccessful: true, result: User.fromJson(jsonData['UserData']));
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }
}
