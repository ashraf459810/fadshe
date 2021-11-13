import 'package:dio/dio.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/banner.dart';
import 'package:fad_shee/network/api_request.dart';
import 'package:fad_shee/network/dio_http_client.dart';
import 'package:fad_shee/network/result.dart';

class Banners extends ApiRequest {
  Future<Result> fetchBanners() async {
    String url = '${DioHttpClient.baseUrl}/GetBanners';
    try {
      Response response = await getIt.get<Dio>().get(url);
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        List<Banner> banners = (jsonData['Banners'] as List).map((e) => Banner.fromJson(e)).toList();
        return Result(isSuccessful: true, result: banners);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }
}
