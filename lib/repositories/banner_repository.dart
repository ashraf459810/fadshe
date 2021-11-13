import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/banner.dart';
import 'package:fad_shee/network/api_service.dart';
import 'package:fad_shee/network/result.dart';

class BannerRepository {
  List<Banner> _banners = [];

  List<Banner> get upperHomeBanners => _banners.where((element) => element.bannerPlace == BannerPlace.MAIN_PAGE_UPPER).toList();
  List<Banner> get lowerHomeBanners => _banners.where((element) => element.bannerPlace == BannerPlace.MAIN_PAGE_LOWER).toList();
  List<Banner> get categoryBanners => _banners.where((element) => element.bannerPlace == BannerPlace.CATEGORY_PAGE).toList();

  Future<Result> fetchBanners() async {
    Result result = await getIt.get<ApiService>().banners.fetchBanners();
    if (result.isSuccessful) _banners = result.result as List<Banner>;
    return result;
  }
}
