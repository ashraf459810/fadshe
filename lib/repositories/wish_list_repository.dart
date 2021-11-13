import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/models/data/wish_list_item.dart';
import 'package:fad_shee/network/api_service.dart';
import 'package:fad_shee/network/result.dart';
import 'package:fad_shee/repositories/base_repository.dart';

class WishListRepository extends BaseRepository {
  List<WishListItem> _items = [];

  List<WishListItem> get items => [..._items];

  bool isProductFavorite(int productId) => _items.where((element) => element.product.id == productId).isNotEmpty;

  Future<Result> fetchWishListItems() async {
    Result result = await getIt.get<ApiService>().wishList.fetchWishListItems();
    if (result.isSuccessful) {
      _items.addAll(result.result as List<WishListItem>);
    }
    return result;
  }

  Future<Result> toggleFavorite(Product product) async {
    if (isProductFavorite(product.id))
      return await _removeItem(product.id);
    else
      return await _addItem(product);
  }

  Future<Result> _addItem(Product product) async {
    Result result = await getIt.get<ApiService>().wishList.addToWishList(product.id);
    if (result.isSuccessful) {
      _items.add(WishListItem(id: result.result as int, product: product));
    }
    return result;
  }

  Future<Result> _removeItem(int productId) async {
    int itemId = _items.where((element) => element.product.id == productId).first.id;
    Result result = await getIt.get<ApiService>().wishList.removeFromWishList(itemId);
    if (result.isSuccessful) {
      _items.removeWhere((element) => element.id == itemId);
    }
    return result;
  }

  @override
  clearData() {
    _items.clear();
  }
}
