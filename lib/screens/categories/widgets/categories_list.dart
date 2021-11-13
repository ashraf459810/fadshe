import 'package:fad_shee/models/data/category.dart';
import 'package:fad_shee/screens/categories/widgets/categories_list_item.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  final List<Category> categories;

  CategoriesList(this.categories);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior()..buildViewportChrome(context, null, AxisDirection.down),
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (ctx, index) => CategoriesListItem(categories[index]),
      ),
    );
  }
}
