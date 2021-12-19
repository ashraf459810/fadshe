import 'package:fad_shee/models/data/category.dart';
import 'package:fad_shee/models/data/product.dart';

import 'package:fad_shee/screens/categories/widgets/categories_list_item.dart';

import 'package:flutter/material.dart';

import '../../base_screen_state.dart';

class CategoriesGrid extends StatefulWidget {
  final List<Category> categories;
  CategoriesGrid(this.categories);

  @override
  _CategoriesGridState createState() => _CategoriesGridState();
}

class _CategoriesGridState extends BaseScreenState<CategoriesGrid> {
  final List<Product> products = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.8,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      children: [
        ...widget.categories
            .map((category) => CategoriesListItem(category))
            .toList(),
      ],
    );
  }
}
