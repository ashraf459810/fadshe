import 'dart:developer';

import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/category.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/network/result.dart';
import 'package:fad_shee/repositories/category_repository.dart';
import 'package:fad_shee/repositories/product_repository.dart';
import 'package:flutter/foundation.dart' hide Category;

class CategoryDetailsProvider with ChangeNotifier {
  CategoryRepository categoryRepo = getIt<CategoryRepository>();
  ProductRepository productRepo = getIt<ProductRepository>();
  Category category;
  List<Product> products = [];
  bool loading = true;
  int page = 1, lastPage = 1;

  CategoryDetailsProvider(Map<String, dynamic> categoryInfo) {
    category = categoryRepo.getCategory(categoryInfo['category_id']);
    productRepo
        .fetchCategoryProductsPage(categoryInfo['category_id'], page)
        .then((result) {
      log("success");
      if (result.isSuccessful) products.addAll(result.result as List<Product>);
      loading = false;
      notifyListeners();
    });
  }

  loadMoreProducts() async {
    if (++page <= lastPage) {
      Result result =
          await productRepo.fetchCategoryProductsPage(category.id, page);
      if (result.isSuccessful) {
        products.addAll(result.result as List<Product>);
      }
      notifyListeners();
    }
  }
}
