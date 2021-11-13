import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/category.dart';
import 'package:fad_shee/network/api_service.dart';
import 'package:fad_shee/network/result.dart';

class CategoryRepository {
  List<Category> _categories = [];

  List<Category> get categories => [..._categories];

  Future<Result> fetchCategories() async {
    Result result = await getIt.get<ApiService>().categories.fetchCategories();
    if (result.isSuccessful) {
      _categories = result.result as List<Category>;
      _categories.forEach((category) {
        category.hasChildren = _categories.any((element) => element.parentId == category.id);
      });
      return result;
    } else
      return result;
  }

  List<Category> get parentCategories => _categories.where((element) => element.parentId == null).toList();

  List<Category> getSubcategories(int categoryId) =>
      _categories.where((element) => element.parentId == categoryId).toList();

  Category getCategory(int categoryId) => _categories.firstWhere((element) => element.id == categoryId);
}
