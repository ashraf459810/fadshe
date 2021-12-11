import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fad_shee/extensions/list_extensions.dart';
import 'package:fad_shee/models/data/category.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/models/enum/list_item_location.dart';
import 'package:fad_shee/screens/categories/widgets/categories_list_item.dart';
import 'package:fad_shee/screens/category_details/category_details_provider.dart';
import 'package:fad_shee/screens/product_details/product_details_screen.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:fad_shee/widgets/price_widget.dart';
import 'package:fad_shee/widgets/products_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
