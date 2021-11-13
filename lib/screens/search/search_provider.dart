import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/category.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/models/data/sort_by_option.dart';
import 'package:fad_shee/models/data/sort_direction.dart';
import 'package:fad_shee/network/result.dart';
import 'package:fad_shee/repositories/category_repository.dart';
import 'package:fad_shee/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  ProductRepository productRepo = getIt<ProductRepository>();
  CategoryRepository categoryRepo = getIt<CategoryRepository>();

  Map<String, dynamic> data = {
    //"title": null,
    "days": null,
    "quantity": null,
    'categories_id': null,
    'orderBy': null,
    'orderDir': null,
    'hasDiscount': false,
  };

  final formKey = GlobalKey<FormState>();
  Category _selectedCategory;
  int currentPage = 1, lastPage = 1;
  ScrollController scrollController = ScrollController();

  Category get selectedCategory => _selectedCategory;

  bool _showOnlyWithDiscount = false;

  bool get showOnlyWithDiscount => _showOnlyWithDiscount;

  set showOnlyWithDiscount(bool value) {
    _showOnlyWithDiscount = value;
    notifyListeners();
  }

  set selectedCategory(Category value) {
    _selectedCategory = value;
    notifyListeners();
  }

  List<SortDirection> sortDirections = [
    SortDirection(1, 'asc', 'ascending'.tr()),
    SortDirection(2, 'desc', 'descending'.tr()),
  ];

  int _selectedSortDirectionId = 1;

  int get selectedSortDirectionId => _selectedSortDirectionId;

  set selectedSortDirectionId(int value) {
    _selectedSortDirectionId = value;
    notifyListeners();
  }

  List<SortByOption> sortByOptions = [
    SortByOption(1, 'title', 'title'.tr()),
    SortByOption(2, 'quantity', 'quantity'.tr()),
    SortByOption(3, 'days', 'days'.tr()),
    SortByOption(4, 'price', 'price'.tr()),
    SortByOption(5, 'discount', 'discount'.tr()),
    SortByOption(6, 'last_push_time', 'default'.tr()),
    SortByOption(7, 'created_at', 'newly_added'.tr()),
    SortByOption(8, 'updated_at', 'newly_updated'.tr()),
  ];

  int _selectedSortByOptionId = 1;

  int get selectedSortByOptionId => _selectedSortByOptionId;

  set selectedSortByOptionId(int value) {
    _selectedSortByOptionId = value;
    notifyListeners();
  }

  List<Product> searchResults = [];

  List<Category> get categories => categoryRepo.categories;

  SearchProvider() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) loadMoreProducts();
    });
    searchResults..addAll(productRepo.newArrivalProducts);
  }

  searchProduct() async {
    currentPage = lastPage = 1;
    formKey.currentState.save();
    data['categories_id'] = selectedCategory?.id;
    data['orderBy'] = sortByOptions.firstWhere((element) => element.id == selectedSortByOptionId).key;
    data['orderDir'] = sortDirections.firstWhere((element) => element.id == selectedSortDirectionId).key;
    data['hasDiscount'] = showOnlyWithDiscount;
    Result result = await productRepo.searchProducts(data, currentPage);
    if (result.isSuccessful) {
      searchResults = ((result.result as Map<String, dynamic>)['products'] as List<Product>);
      lastPage = (result.result as Map<String, dynamic>)['last_page'] as int;
      notifyListeners();
    }
  }

  loadMoreProducts() async {
    print('load more: currentPage: $currentPage, lastPage: $lastPage');
    if (++currentPage <= lastPage) {
      Result result = await productRepo.searchProducts(data, currentPage);
      if (result.isSuccessful) {
        searchResults.addAll((result.result as Map<String, dynamic>)['products'] as List<Product>);
        lastPage = (result.result as Map<String, dynamic>)['last_page'] as int;
        notifyListeners();
      }
    }
  }
}
