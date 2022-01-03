import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/cart_item.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/network/api_service.dart';
import 'package:fad_shee/network/result.dart';
import 'package:fad_shee/repositories/base_repository.dart';

class CartRepository extends BaseRepository {
  List<CartItem> _items = [];

  List<CartItem> get items => [..._items];

  double _cartTotal;

  dynamic _cartFees;

  dynamic _deliveryDays;

  // if(true) => we should refresh cart from api to calculate cartTotal
  bool fetchCart = true;

  double get cartTotal => _cartTotal;

  dynamic get cartFees => _cartFees;

  dynamic get deliveryDays => _deliveryDays;

  int getProductQuantity(int productId) => _items
      .where((element) => element.product.id == productId)
      .fold(0, (previousValue, item) => previousValue + item.quantity);

  int getProductWithAttributesQuantity(int productId, String attributes) =>
      searchForItem(productId, attributes)?.value?.quantity ?? 0;

  fetchCartItems() async {
    if (fetchCart) {
      Result result = await getIt.get<ApiService>().cart.fetchCartItems();
      if (result.isSuccessful) {
        fetchCart = false;
        _deliveryDays = result.deliveryDays;

        _cartFees = result.deliveryFees;

        MapEntry cartData = result.result as MapEntry;
        _cartTotal = cartData.key;
        _items.addAll(cartData.value);
      }
    }
  }

  Future<Result> addToCart(Product product, String attributes) async {
    Result result =
        await getIt.get<ApiService>().cart.addToCart(product.id, 1, attributes);
    if (result.isSuccessful) {
      int createdItemId = result.result as int;
      _items.add(CartItem(
          id: createdItemId,
          product: product,
          quantity: 1,
          attributes: attributes));
      await updateCartTotal();
    }
    return result;
  }

  Future<Result> increaseItemQuantity(
      Product product, String attributes) async {
    CartItem processedItem = searchForItem(product.id, attributes).value;
    Result result = await getIt
        .get<ApiService>()
        .cart
        .updateItemQuantity(processedItem.id, processedItem.quantity + 1);
    if (result.isSuccessful) {
      fetchCart = true;
      ++processedItem.quantity;
      await updateCartTotal();
    }
    return result;
  }

  Future<Result> decreaseItemQuantity(
      Product product, String attributes) async {
    MapEntry<int, CartItem> processedItem =
        searchForItem(product.id, attributes);
    Result result;
    if (processedItem.value.quantity == 1) {
      // Remove Item from cart
      result = await getIt
          .get<ApiService>()
          .cart
          .removeFromCart(processedItem.value.id);
      if (result.isSuccessful) {
        fetchCart = true;
        _items.removeAt(processedItem.key);
        await updateCartTotal();
      }
    } else {
      // Update Item Quantity
      result = await getIt.get<ApiService>().cart.updateItemQuantity(
          processedItem.value.id, processedItem.value.quantity - 1);
      if (result.isSuccessful) {
        fetchCart = true;
        --processedItem.value.quantity;
        await updateCartTotal();
      }
    }
    return result;
  }

  Future<Result> removeItem(Product product, String attributes) async {
    MapEntry<int, CartItem> processedItem =
        searchForItem(product.id, attributes);
    Result result = await getIt
        .get<ApiService>()
        .cart
        .removeFromCart(processedItem.value.id);
    if (result.isSuccessful) {
      fetchCart = true;
      _items.removeAt(processedItem.key);
      await updateCartTotal();
    }
    return result;
  }

  // returns <index, item>
  MapEntry<int, CartItem> searchForItem(int productId, String attributes) {
    List<CartItem> matchedItems = _items
        .where((item) =>
            item.product.id == productId && item.attributes == attributes)
        .toList();
    if (matchedItems.isNotEmpty)
      return MapEntry(_items.indexOf(matchedItems.first), matchedItems.first);
    else
      return null;
  }

  // Compares current cart total (without promo code) with the cart total with promo code
  Future<Result> getPromoCodeDiscount(String promoCode) async {
    Result result =
        await getIt.get<ApiService>().cart.fetchCartTotal(promoCode: promoCode);
    if (result.isSuccessful) {
      double discount = _cartTotal - (result.result as double);
      if (discount > 0)
        return Result(isSuccessful: true, result: discount);
      else
        return Result(isSuccessful: false, message: 'invalid_promo_code'.tr());
    }
    return result;
  }

  Future updateCartTotal() async {
    Result result = await getIt.get<ApiService>().cart.fetchCartTotal();
    if (result.isSuccessful) {
      _cartTotal = result.result.cartTotal as double;
      _cartFees = result.result.cartFees as double;
    }
  }

  @override
  clearData() {
    _items.clear();
  }
}
