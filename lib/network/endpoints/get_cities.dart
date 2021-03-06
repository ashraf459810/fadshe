import 'package:dio/dio.dart';
import 'package:fad_shee/main.dart';

import 'package:fad_shee/models/data/cities_model.dart';
import 'package:fad_shee/network/api_request.dart';
import 'package:fad_shee/network/dio_http_client.dart';
import 'package:fad_shee/network/result.dart';

class GetCities extends ApiRequest {
  Future<Result> getCities() async {
    String url = '${DioHttpClient.baseUrl}/Cities';
    // try {
    print(url);
    Response response = await getIt.get<Dio>().get(url);
    var jsonData = response.data;
    if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
      List<City> banners =
          (jsonData['Cities'] as List).map((e) => City.fromJson(e)).toList();
      return Result(isSuccessful: true, result: banners);

      // if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
      //   var cities = citiesModelFromJson(jsonData);

      //   return Result(isSuccessful: true, result: cities.cities);
      // } else {
      //   return Result(isSuccessful: false, message: jsonData['Reason']);
      // }
      // } catch (error) {
      //   print(error);
      //   return handleError(error);
      // }
    }
  }
}
