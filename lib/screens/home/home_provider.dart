import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/banner.dart';
import 'package:fad_shee/models/data/brand.dart';
import 'package:fad_shee/models/data/category.dart' as cat;
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/models/ui/carousel_page_data.dart';
import 'package:fad_shee/repositories/banner_repository.dart';
import 'package:fad_shee/repositories/brand_repository.dart';
import 'package:fad_shee/repositories/category_repository.dart';
import 'package:fad_shee/repositories/home_slides_repository.dart';
import 'package:fad_shee/repositories/product_repository.dart';
import 'package:flutter/foundation.dart';

class HomeProvider with ChangeNotifier {
  CategoryRepository _categoryRepo = getIt<CategoryRepository>();
  ProductRepository _productRepo = getIt<ProductRepository>();
  HomeSlidesRepository _homeSlidesRepo = getIt<HomeSlidesRepository>();
  BannerRepository _bannerRepo = getIt<BannerRepository>();
  BrandRepository _brandRepo = getIt<BrandRepository>();

  List<CarouselPageData> get topSliderPagesData => _homeSlidesRepo.pagesData;
  List<cat.Category> get parentCategories => _categoryRepo.parentCategories.take(5).toList();
  List<Banner> get upperBanners => _bannerRepo.upperHomeBanners;
  List<Product> get newArrivalProducts => _productRepo.newArrivalProducts.take(5).toList();
  List<Banner> get lowerBanners => _bannerRepo.lowerHomeBanners;
  List<Product> get trendingProducts => _productRepo.trendingProducts.take(5).toList();
  List<Brand> get brands => _brandRepo.brands;
}
