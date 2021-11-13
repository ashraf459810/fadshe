import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/network/api_service.dart';
import 'package:fad_shee/network/result.dart';
import 'package:fad_shee/repositories/wish_list_repository.dart';

class ProductRepository {
  WishListRepository wishListRepo = getIt<WishListRepository>();
  List<Product> _newArrivalProducts = [];
  List<Product> _trendingProducts = [];

  List<Product> get newArrivalProducts => [..._newArrivalProducts];

  List<Product> get trendingProducts => [..._trendingProducts];

  Future<Result> fetchNewArrivalProducts() async {
    Result result = await getIt.get<ApiService>().products.fetchNewArrivalProducts();
    if (result.isSuccessful) {
      _newArrivalProducts = result.result as List<Product>;
      return result;
    } else
      return result;
  }

  Future<Result> fetchTrendingProducts() async {
    Result result = await getIt.get<ApiService>().products.fetchTrendingProducts();
    if (result.isSuccessful) {
      _trendingProducts = result.result as List<Product>;
      return result;
    } else
      return result;
  }

  Future<Result> fetchCategoryProductsPage(int categoryId, int page) async {
    Result result = await getIt.get<ApiService>().products.fetchCategoryProductsPage(categoryId, page);
    return result;
  }

  Future<Result> fetchProductDetails(int productId) async {
    Result result = await getIt.get<ApiService>().products.fetchProductDetails(productId);
    return result;
  }

  Future<Result> searchProducts(Map<String, dynamic> filters, int page) async {
    Result result = await getIt.get<ApiService>().products.searchProducts(filters, page);
    return result;
  }

  Future<Result> rateProduct(int productId, int rate) async {
    Result result = await getIt.get<ApiService>().products.rateProduct(productId, rate);
    return result;
  }

  Future<Result> addComment(int productId, String comment) async {
    Result result = await getIt.get<ApiService>().products.addComment(productId, comment);
    return result;
  }
}
