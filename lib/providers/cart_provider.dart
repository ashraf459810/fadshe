import 'dart:async';

import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/cart_item.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/repositories/cart_repository.dart';
import 'package:fad_shee/repositories/user_repository.dart';
import 'package:fad_shee/screens/login/login_screen.dart';
import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  CartRepository cartRepo = getIt<CartRepository>();
  UserRepository userRepo = getIt<UserRepository>();
  StreamController loading = StreamController();

  List<CartItem> get items => cartRepo.items;

  int get itemsCount => items.length;

  int get totalItemsCount => items.fold(0, (previousValue, item) => previousValue + item.quantity);

  int getProductQuantity(int productId) => cartRepo.getProductQuantity(productId);

  int getProductWithAttributesQuantity(int productId, String attributes) =>
      cartRepo.getProductWithAttributesQuantity(productId, attributes);

  double get checkoutAmount => cartRepo.cartTotal;

  fetchCartItem() async {
    await cartRepo.fetchCartItems();
    notifyListeners();
  }

  addToCart(Product product, String attributes) async {
    if (userRepo.isLoggedIn) {
      loading.sink.add(true);
      await cartRepo.addToCart(product, attributes);
      loading.sink.add(false);
      notifyListeners();
    } else
      navService.pushNamed(LoginScreen.routeName);
  }

  increaseItemQuantity(Product product, String attributes) async {
    loading.sink.add(true);
    await cartRepo.increaseItemQuantity(product, attributes);
    loading.sink.add(false);
    notifyListeners();
  }

  decreaseItemQuantity(Product product, String attributes) async {
    loading.sink.add(true);
    await cartRepo.decreaseItemQuantity(product, attributes);
    loading.sink.add(false);
    notifyListeners();
  }

  removeItem(Product product, String attributes) async {
    loading.sink.add(true);
    await cartRepo.removeItem(product, attributes);
    loading.sink.add(false);
    notifyListeners();
  }

  @override
  void dispose() {
    loading.close();
    super.dispose();
  }
}
