import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/models/data/category.dart';
import 'package:fad_shee/screens/categories/categories_screen.dart';
import 'package:fad_shee/screens/category_details/category_details_screen.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:flutter/material.dart';

class CategoriesListItem extends StatelessWidget {
  final Category category;

  CategoriesListItem(this.category);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.spacingXSmall),
      child: InkWell(
        onTap: () {
          if (category.hasChildren)
            Navigator.of(context).pushNamed(CategoriesScreen.routeName,
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
        borderRadius:
            BorderRadius.all(Radius.circular(AppDimens.borderRadiusSmall)),
        splashColor: AppColors.red,
        child: Ink(
          decoration: AppShapes.roundedRectDecoration(
              backgroundImage: category.imageUrl,
              radius: AppDimens.borderRadiusSmall),
          child: Container(
            // height: 80,
            padding: EdgeInsetsDirectional.fromSTEB(
                AppDimens.spacingXLarge,
                AppDimens.spacingMedium,
                AppDimens.spacingSmall,
                AppDimens.spacingMedium),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                Text(
                  '${category.itemsCount} ${'item'.tr()}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.white, fontSize: 10),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
