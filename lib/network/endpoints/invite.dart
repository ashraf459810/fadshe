import 'package:dio/dio.dart';
import 'package:fad_shee/main.dart';

import '../dio_http_client.dart';
import '../result.dart';

Future<Result> invite(String token) async {
  String url = '${DioHttpClient.baseUrl}/referralWebView?api_token=$token';
  try {
    Response response = await getIt.get<Dio>().get(url);
    var jsonData = response.data;
    if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
      return Result(isSuccessful: true, result: "Done");
    } else {
      return Result(isSuccessful: false, message: jsonData['Reason']);
    }
  } catch (error) {
    print(error);
    return null;
  }
}
