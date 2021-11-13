import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/repositories/wish_list_repository.dart';
import 'package:flutter/foundation.dart';

class WishListProvider with ChangeNotifier {
  WishListRepository wishListRepo = getIt<WishListRepository>();

  List<Product> get products => wishListRepo.items.map((e) => e.product).toList();

  int get productsCount => products.length;
}
