import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/category.dart' as cat;
import 'package:fad_shee/repositories/category_repository.dart';
import 'package:flutter/foundation.dart';

class CategoriesProvider with ChangeNotifier {
  CategoryRepository categoryRepo = getIt();
  List<cat.Category> categories = [];
  String categoryTitle;

  CategoriesProvider(Map<String, dynamic> args) {
    if (args['category_id'] == null) {
      categoryTitle = 'categories'.tr();
      categories = categoryRepo.parentCategories;
    } else {
      categoryTitle = args['category_title'];
      categories = categoryRepo.getSubcategories(args['category_id']);
    }
  }
}
