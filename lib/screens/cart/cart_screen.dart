import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/providers/cart_provider.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/cart/widgets/cart_list.dart';
import 'package:fad_shee/screens/cart/widgets/cart_summary.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  final bool showBack;

  CartScreen({this.showBack = true});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends BaseScreenState<CartScreen> {
  @override
  Widget appBar(BuildContext context) => CustomAppBar(
        context: context,
        titleText: 'cart'.tr(),
        showBackButton: widget.showBack,
      );

  @override
  Widget buildState(BuildContext context) {
    CartProvider cartProvider = Provider.of(context);
    return cartProvider.itemsCount == 0
        ? emptyState(context)
        : Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: CartList(),
              ),
              PositionedDirectional(
                bottom: AppDimens.spacingMedium,
                start: AppDimens.spacingMedium,
                end: AppDimens.spacingMedium,
                child: CartSummary(),
              )
            ],
          );
  }

  emptyState(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: AppColors.lightGrey,
          ),
          SizedBox(height: 12),
          Text('your_cart_is_empty'.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.grey.withOpacity(0.4)))
        ],
      );
}
