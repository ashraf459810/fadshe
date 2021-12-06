import 'package:fad_shee/models/data/category.dart';
import 'package:fad_shee/screens/home/widgets/categories_grid_item.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:flutter/material.dart';

class CategoriesGrid extends StatelessWidget {
  final List<Category> categories;

  CategoriesGrid(this.categories);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 5,
      childAspectRatio: 0.85,
      crossAxisSpacing: AppDimens.spacingXSmall,
      mainAxisSpacing: AppDimens.spacingXSmall,
      children: [
        ...categories.map((category) => CategoriesGridItem(category)).toList()
      ],
    );
  }
}
