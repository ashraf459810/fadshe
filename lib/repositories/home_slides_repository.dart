import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/ui/carousel_page_data.dart';
import 'package:fad_shee/network/api_service.dart';
import 'package:fad_shee/network/result.dart';

class HomeSlidesRepository {
  List<CarouselPageData> _pagesData = [];

  List<CarouselPageData> get pagesData => [..._pagesData];

  Future<Result> fetchSliderImages() async {
    Result result = await getIt.get<ApiService>().homeSlides.fetchHomeSlides();
    if (result.isSuccessful) _pagesData = result.result as List<CarouselPageData>;
    return result;
  }
}
