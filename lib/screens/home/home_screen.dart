import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/home/home_provider.dart';
import 'package:fad_shee/screens/home/widgets/categories_grid.dart';
import 'package:fad_shee/screens/home/widgets/home_carousel.dart';
import 'package:fad_shee/screens/home/widgets/search_field.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/widgets/banners_carousel.dart';
import 'package:fad_shee/widgets/brands_carousel.dart';
import 'package:fad_shee/widgets/products_grid.dart';
import 'package:fad_shee/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreenState<HomeScreen> {
  ScrollController scrollController = ScrollController();
  HomeProvider provider;

  @override
  onBuildStart() {
    provider = Provider.of<HomeProvider>(context);
  }

  @override
  Widget buildState(BuildContext context) {
    log(provider.lowerBanners[0].toString());
    return ScrollConfiguration(
      behavior: ScrollBehavior()
        ..buildViewportChrome(context, null, AxisDirection.down),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(color: AppColors.red, child: SearchField()),
            SizedBox(height: AppDimens.pagePadding),
            HomeCarousel(provider.topSliderPagesData),
            SizedBox(height: AppDimens.pagePadding),
            sectionTitle('top_categories'.tr()),
            Padding(
              padding: const EdgeInsets.all(AppDimens.pagePadding),
              child: CategoriesGrid(provider.parentCategories),
            ),
            if (provider.upperBanners.isNotEmpty)
              BannersCarousel(provider.upperBanners),
            if (provider.newArrivalProducts.isNotEmpty) newArrivalProducts(),
            if (provider.lowerBanners.isNotEmpty)
              BannersCarousel(provider.lowerBanners),
            if (provider.trendingProducts.isNotEmpty) trendingProducts(),
            if (provider.brands.isNotEmpty)
              SizedBox(
                  width: 400,
                  height: 200,
                  child: BrandsCarousel(provider.brands)),
          ],
        ),
      ),
    );
  }

  sectionTitle(title) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: AppDimens.pagePadding, height: 1, color: AppColors.grey),
          Text('  $title  ',
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(color: AppColors.grey)),
        ],
      );

  newArrivalProducts() => Column(
        children: [
          sectionTitle('latest_products'.tr()),
          Padding(
            padding: const EdgeInsets.only(
                left: AppDimens.pagePadding,
                right: AppDimens.pagePadding,
                top: AppDimens.spacingSmall),
            child: ProductsList(provider.newArrivalProducts),
          ),
        ],
      );

  trendingProducts() => Column(
        children: [
          sectionTitle('trending_products'.tr()),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.pagePadding,
                vertical: AppDimens.spacingLarge),
            child: ProductsGrid(provider.trendingProducts),
          ),
        ],
      );
}
