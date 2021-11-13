import 'package:dio/dio.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/category.dart';
import 'package:fad_shee/network/api_request.dart';
import 'package:fad_shee/network/dio_http_client.dart';
import 'package:fad_shee/network/result.dart';

class Categories extends ApiRequest {
  Future<Result> fetchCategories() async {
    String url = '${DioHttpClient.baseUrl}/Categories';
    try {
      print(url);
      Response response = await getIt.get<Dio>().get(url);
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        List<Category> categories = (jsonData['Categories'] as List)
            .map((e) => Category.fromJson(e))
            .toList();
        return Result(isSuccessful: true, result: categories);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }
}
