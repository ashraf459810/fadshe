import 'package:fad_shee/models/data/category.dart';
import 'package:fad_shee/screens/categories/widgets/categories_list_item.dart';
import 'package:flutter/material.dart';

class CategoriesGrid extends StatelessWidget {
  final List<Category> categories;

  CategoriesGrid(this.categories);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.9,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      children: [...categories.map((category) => CategoriesListItem(category)).toList()],
    );
  }
}
