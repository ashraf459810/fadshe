import 'package:dio/dio.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/ui/carousel_page_data.dart';
import 'package:fad_shee/network/api_request.dart';
import 'package:fad_shee/network/dio_http_client.dart';
import 'package:fad_shee/network/result.dart';

class HomeSlides extends ApiRequest {
  Future<Result> fetchHomeSlides() async {
    String url = '${DioHttpClient.baseUrl}/GetSliders';
    try {
      Response response = await getIt.get<Dio>().get(url);
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        List<CarouselPageData> pagesData = (jsonData['Slides'] as List).map((e) => CarouselPageData.fromJson(e)).toList();
        return Result(isSuccessful: true, result: pagesData);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }
}
