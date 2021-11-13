import 'package:dio/dio.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/network/api_request.dart';
import 'package:fad_shee/network/dio_http_client.dart';
import 'package:fad_shee/network/result.dart';

class Currencies extends ApiRequest {
  Future<Result> fetchExchangeRate() async {
    String url = '${DioHttpClient.baseUrl}/CurrenciesRate';
    try {
      Response response = await getIt.get<Dio>().get(url);
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        return Result(isSuccessful: true, result: double.parse((jsonData['USDIQD'] as Map)['iqd']));
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }
}
