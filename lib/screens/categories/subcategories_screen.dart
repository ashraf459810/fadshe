import 'package:cached_network_image/cached_network_image.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/categories/categories_provider.dart';
import 'package:fad_shee/screens/categories/widgets/categories_grid.dart';
import 'package:fad_shee/screens/category_details/category_details_provider.dart';
import 'package:fad_shee/screens/product_details/product_details_screen.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:fad_shee/widgets/price_widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SubcategoriesScreen extends StatefulWidget {
  static const routeName = '/categories';

  @override
  _SubcategoriesScreenState createState() => _SubcategoriesScreenState();
}

class _SubcategoriesScreenState extends BaseScreenState<SubcategoriesScreen> {
  CategoriesProvider provider;

  @override
  onBuildStart() {
    provider = Provider.of(context);
  }

  @override
  Widget appBar(BuildContext context) =>
      CustomAppBar(context: context, titleText: provider.categoryTitle);

  @override
  Widget buildState(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          CategoryDetailsProvider({'category_id': provider.categories[0].id}),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.spacingMedium),
                child: CategoriesGrid(provider.categories),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(builder: (context) {
                return Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: Provider.of<CategoryDetailsProvider>(context)
                          .products
                          .length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, ProductDetailsScreen.routeName,
                              arguments: {
                                'product_id':
                                    Provider.of<CategoryDetailsProvider>(
                                            context)
                                        .products[index]
                                        .id,
                                'product_name':
                                    Provider.of<CategoryDetailsProvider>(
                                            context)
                                        .products[index]
                                        .title,
                                'category_id':
                                    Provider.of<CategoryDetailsProvider>(
                                            context)
                                        .products[index]
                                        .categoryId,
                              }),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: AppColors.lightGrey))),
                            padding: EdgeInsets.only(
                                bottom: AppDimens.spacingMedium,
                                top: AppDimens.spacingMedium),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      Provider.of<CategoryDetailsProvider>(
                                              context)
                                          .products[index]
                                          .images
                                          .split(",")
                                          .first,
                                  width: 110,
                                  height: 110,
                                ),
                                SizedBox(width: AppDimens.spacingXLarge),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          Provider.of<CategoryDetailsProvider>(
                                                  context)
                                              .products[index]
                                              .title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4),
                                      if (Provider.of<CategoryDetailsProvider>(
                                                  context)
                                              .products[index]
                                              .description !=
                                          null)
                                        Text(
                                            Provider.of<CategoryDetailsProvider>(
                                                    context)
                                                .products[index]
                                                .description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                .copyWith(
                                                    color: AppColors.grey)),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: AppDimens.spacingSmall),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AppDimens.spacingLarge,
                                            vertical: 2),
                                        decoration:
                                            AppShapes.roundedRectDecoration(
                                                radius: AppDimens.spacingXSmall,
                                                borderColor: AppColors.red),
                                        child: Text(
                                            Provider.of<CategoryDetailsProvider>(
                                                    context)
                                                .products[index]
                                                .categoryName
                                                .toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2
                                                .copyWith(
                                                    color: AppColors.red)),
                                      ),
                                      PriceWidget(
                                          price: Provider.of<
                                                      CategoryDetailsProvider>(
                                                  context)
                                              .products[index]
                                              .price,
                                          discount: Provider.of<
                                                      CategoryDetailsProvider>(
                                                  context)
                                              .products[index]
                                              .discount),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ));
              }),
            )
          ],
        ),
      ),
    );
  }
}
