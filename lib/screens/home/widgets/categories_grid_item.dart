import 'package:cached_network_image/cached_network_image.dart';
import 'package:fad_shee/models/data/category.dart';
import 'package:fad_shee/screens/categories/subcategories_screen.dart';
import 'package:fad_shee/screens/category_details/category_details_screen.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CategoriesGridItem extends StatelessWidget {
  final Category category;

  CategoriesGridItem(this.category);

  @override
  Widget build(BuildContext context) {
    print("here the image ");

    return InkWell(
      onTap: () {
        if (category.hasChildren)
          Navigator.of(context).pushNamed(SubcategoriesScreen.routeName,
              arguments: {
                'category_id': category.id,
                'category_title': category.title
              });
        else
          Navigator.of(context).pushNamed(CategoryDetailsScreen.routeName,
              arguments: {
                'category_id': category.id,
                'category_title': category.title
              });
      },
      child: Column(
        children: [
          CachedNetworkImage(
              imageUrl: category.imageUrl.split(",").first,
              height: 50,
              fit: BoxFit.cover),
          SizedBox(height: AppDimens.spacingXSmall),
          Text(category.title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.black)),
        ],
      ),
    );
  }
}
