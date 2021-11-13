import 'package:dio/dio.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/brand.dart';
import 'package:fad_shee/network/api_request.dart';
import 'package:fad_shee/network/dio_http_client.dart';
import 'package:fad_shee/network/result.dart';

class Brands extends ApiRequest {
  Future<Result> fetchBrands() async {
    String url = '${DioHttpClient.baseUrl}/GetBrands';
    try {
      Response response = await getIt.get<Dio>().get(url);
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        List<Brand> brands = (jsonData['Brands'] as List).map((e) => Brand.fromJson(e)).toList();
        return Result(isSuccessful: true, result: brands);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }
}
