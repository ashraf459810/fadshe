import 'package:fad_shee/main.dart';
import 'package:fad_shee/repositories/wish_list_repository.dart';
import 'package:flutter/foundation.dart';

class AccountProvider with ChangeNotifier {
  WishListRepository wishListRepo = getIt<WishListRepository>();

  int get itemsInWishList => wishListRepo.items.length;
}
