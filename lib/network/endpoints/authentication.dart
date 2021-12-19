import 'package:dio/dio.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/network/api_request.dart';
import 'package:fad_shee/network/api_service.dart';
import 'package:fad_shee/network/dio_http_client.dart';
import 'package:fad_shee/network/result.dart';

class Authentication extends ApiRequest {
  Future<Result> register(name, email, phone, password, cityid) async {
    String url = '${DioHttpClient.baseUrl}/Register';
    FormData data = FormData.fromMap({
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'cities_id': cityid
    });
    try {
      Response response = await getIt.get<Dio>().post(url, data: data);

      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        return Result(isSuccessful: true, result: jsonData['api_token']);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> login(email, password) async {
    String url = '${DioHttpClient.baseUrl}/GetToken/$email/$password';
    try {
      Response response = await getIt.get<Dio>().post(url);
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        return Result(isSuccessful: true, result: jsonData['api_token']);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> loginWithFacebook(String facebookToken) async {
    String url =
        '${DioHttpClient.baseUrl}/socialtoken/facebook/callback?token=$facebookToken';
    try {
      Response response = await getIt.get<Dio>().get(
            url,
          );
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        return Result(isSuccessful: true, result: jsonData['Token']);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  ///here for apple
  Future<Result> signwithapple(String email) async {
    String url =
        'https://fadshee.com/api/GetTokenByAppleEmail/$email/askldaslkdn32klrlk32rnlk32nfkl32';
    try {
      Response response = await getIt.get<Dio>().get(
            url,
          );
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        print(jsonData['Token']);
        return Result(isSuccessful: true, result: jsonData['Token']);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> fetchUserData() async {
    Result result = await getIt<ApiService>().user.fetchUserData();
    return result;
  }
}
