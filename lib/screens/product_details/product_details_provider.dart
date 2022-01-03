import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/attribute.dart';
import 'package:fad_shee/models/data/comment.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/models/data/value.dart';
import 'package:fad_shee/network/result.dart';
import 'package:fad_shee/repositories/cart_repository.dart';
import 'package:fad_shee/repositories/category_repository.dart';
import 'package:fad_shee/repositories/product_repository.dart';
import 'package:fad_shee/repositories/user_repository.dart';
import 'package:fad_shee/repositories/wish_list_repository.dart';

import 'package:flutter/material.dart';

class ProductDetailsProvider with ChangeNotifier {
  CategoryRepository categoryRepo = getIt<CategoryRepository>();
  WishListRepository wishListRepo = getIt<WishListRepository>();
  ProductRepository productRepo = getIt<ProductRepository>();
  CartRepository cartRepo = getIt<CartRepository>();
  Product product;
  String productName, categoryName;
  bool productDetailsLoading = true;
  bool similarProductsLoading = true;
  List<Product> similarProducts;
  TextEditingController commentController = TextEditingController();
  StreamController<String> message = StreamController.broadcast();
  // to show loading while post the comment to server
  bool addingComment = false;

  // Selected Attributes
  Map<Attribute, Value> selectedAttrValues =
      {}; // key: Attribute, value: selectedValue

  ProductDetailsProvider(Map<String, dynamic> productInfo) {
    // to show product name and category name immediately (do not wait the request)
    this.productName = productInfo['product_name'];
    this.categoryName =
        categoryRepo.getCategory(productInfo['category_id']).title;
    productRepo.fetchProductDetails(productInfo['product_id']).then((result) {
      if (result.isSuccessful) {
        product = result.result as Product;
        product.attributes.forEach((attribute) {
          selectedAttrValues.putIfAbsent(attribute, () => null);
        });
        productDetailsLoading = false;
      }
      notifyListeners();
    });
    productRepo
        .fetchCategoryProductsPage(productInfo['category_id'], 1)
        .then((result) {
      if (result.isSuccessful) {
        similarProducts = (result.result as List<Product>).take(4).toList();
        // exclude current product from similar products
        similarProducts
            .removeWhere((element) => element.id == productInfo['product_id']);
        similarProductsLoading = false;
      }
      notifyListeners();
    });
  }

  Future rateProduct(int rate) async {
    Result result = await productRepo.rateProduct(product.id, rate);
    if (result.isSuccessful) {
      message.sink.add('your_rating_saved_successfully'.tr());
      product.rating = rate;
      notifyListeners();
    } else
      message.sink.add(result.message);
  }

  Future addComment() async {
    if (commentController.text.trim().isNotEmpty) {
      addingComment = true;
      Result result =
          await productRepo.addComment(product.id, commentController.text);
      if (result.isSuccessful) {
        product.comments.add(Comment(
            id: -1,
            text: commentController.text,
            date: DateTime.now(),
            user: getIt<UserRepository>().user));
        commentController.clear();
      } else
        message.sink.add(result.message);
      addingComment = false;
      notifyListeners();
    }
  }

  bool get isFavorite => wishListRepo.isProductFavorite(product.id);

  int get quantityInCart => cartRepo.getProductQuantity(product.id);

  Future toggleFavorite() async {
    await product.toggleFavorite();
    notifyListeners();
  }

  @override
  void dispose() {
    if (!message.isClosed) message.close();
    super.dispose();
  }
}
