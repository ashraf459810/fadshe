import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/extensions/double_extensions.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/providers/cart_provider.dart';
import 'package:fad_shee/screens/checkout/checkout_screen.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSummary extends StatefulWidget {
  @override
  _CartSummaryState createState() => _CartSummaryState();
}

class _CartSummaryState extends State<CartSummary> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of(context);
    return Card(
      elevation: 20,
      shadowColor: Colors.grey.withAlpha(50),
      shape: AppShapes.roundedRectShape(radius: AppDimens.borderRadiusSmall),
      color: AppColors.grey,
      child: InkWell(
        onTap: () => navService.pushNamed(CheckoutScreen.routeName),
        borderRadius: BorderRadius.all(Radius.circular(AppDimens.spacingSmall)),
        splashColor: AppColors.grey,
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.spacingLarge),
          child: Container(
            height: 70,
            child: Column(
              children: [
                Row(
                  children: [
                    Text('checkout'.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: Colors.white)),
                    Text('  (${cartProvider.totalItemsCount} ${'item'.tr()})',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white)),
                    SizedBox(width: AppDimens.spacingMedium),
                    Spacer(),
                    Text('${cartProvider.checkoutAmount.currencyFormat()}',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w900)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('delivery fees'.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: Colors.white)),
                    SizedBox(width: AppDimens.spacingMedium),
                    Spacer(),
                    Text(("${cartProvider.cartFees.currencyFormat()}"),
                        style: Theme.of(context).textTheme.headline2.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w900)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
