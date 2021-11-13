import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/wishlist/wishlist_provider.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:fad_shee/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget {
  static const routeName = '/wishlist';

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends BaseScreenState<WishListScreen> {
  WishListProvider provider;

  @override
  onBuildStart() {
    provider = Provider.of<WishListProvider>(context);
  }

  @override
  Widget appBar(BuildContext context) => CustomAppBar(context: context, titleText: 'my_wishlist'.tr());

  @override
  Widget buildState(BuildContext context) {
    return provider.productsCount == 0
        ? emptyState()
        : Padding(
            padding: const EdgeInsets.all(AppDimens.spacingLarge),
            child: ProductsGrid(
              provider.products,
              itemInRow: 2,
              showCellBorder: true,
            ),
          );
  }

  emptyState() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ic_empty_wishlist.png', color: AppColors.blueGrey.withOpacity(0.2)),
            SizedBox(height: AppDimens.spacingLarge),
            Text(
              'no_items_in_your_wishlist'.tr(),
              style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.blueGrey.withOpacity(0.3)),
            )
          ],
        ),
      );
}
