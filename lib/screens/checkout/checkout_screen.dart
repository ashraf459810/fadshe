import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/extensions/double_extensions.dart';
import 'package:fad_shee/providers/user_provider.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/cart/widgets/cart_list.dart';
import 'package:fad_shee/screens/checkout/checkout_provider.dart';
import 'package:fad_shee/screens/checkout/widgets/payment_methods_grid.dart';
import 'package:fad_shee/screens/checkout/widgets/promo_code_dialog.dart';
import 'package:fad_shee/screens/checkout/widgets/promo_code_provider.dart';
import 'package:fad_shee/screens/profile/edit_profile_screen.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:fad_shee/widgets/price_widget.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = '/checkout';

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends BaseScreenState<CheckoutScreen> {
  CheckoutProvider checkoutProvider;
  StreamSubscription messageSubscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      messageSubscription =
          Provider.of<CheckoutProvider>(context, listen: false)
              .message
              .stream
              .listen((event) {
        Flushbar(message: event, duration: Duration(seconds: 3))..show(context);
      });
    });
    super.initState();
  }

  @override
  onBuildStart() {
    checkoutProvider = Provider.of<CheckoutProvider>(context);
  }

  @override
  Widget appBar(BuildContext context) =>
      CustomAppBar(context: context, titleText: 'checkout'.tr());

  @override
  Widget buildState(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior()
        ..buildViewportChrome(context, null, AxisDirection.down),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title(Icons.my_location, 'deliver_to'.tr()),
            SizedBox(height: AppDimens.spacingSmall),
            userAddress(),
            title(Icons.playlist_add_check, 'review_order'.tr()),
            CartList(shrinkWrap: true, popIfCartEmpty: true),
            title(Icons.payment, 'Payment Method'),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.spacingXXLarge,
                  vertical: AppDimens.spacingMedium),
              child: PaymentMethodsGrid(
                selectedPaymentMethodId:
                    checkoutProvider.selectedPaymentMethodId,
                onPaymentMethodSelected:
                    checkoutProvider.setSSelectedPaymentMethodId,
              ),
            ),
            SizedBox(height: AppDimens.spacingXXLarge),
            totalRow(),
            SizedBox(height: AppDimens.spacingMedium),
            checkoutProvider.promoCode['code'] == null
                ? addPromoCodeButton(context)
                : selectedPromoCode(),
            SizedBox(height: AppDimens.spacingXSmall),
            confirmButton(),
            SizedBox(height: AppDimens.spacingXLarge),
          ],
        ),
      ),
    );
  }

  userAddress() => Container(
        margin: EdgeInsets.only(
            left: AppDimens.pagePadding, right: AppDimens.pagePadding),
        padding: EdgeInsets.symmetric(
            horizontal: AppDimens.spacingLarge,
            vertical: AppDimens.spacingSmall),
        decoration: AppShapes.roundedRectDecoration(color: Colors.grey[100]),
        child: Row(
          children: [
            Expanded(
              child: Text(
                Provider.of<UserProvider>(context).user.address ??
                    'no_address_found'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.black),
              ),
            ),
            IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(EditProfileScreen.routeName),
              icon: Icon(Icons.edit_location_outlined,
                  color: AppColors.red, size: 20),
            )
          ],
        ),
      );

  title(iconData, text) => Padding(
        padding: const EdgeInsetsDirectional.only(
            top: AppDimens.spacingXXXLarge, start: AppDimens.spacingXLarge),
        child: Row(
          children: [
            Icon(iconData, size: 20, color: AppColors.grey),
            SizedBox(width: AppDimens.spacingSmall),
            Text(text.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black)),
          ],
        ),
      );

  totalRow() => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimens.spacingXXXLarge),
        child: Row(
          children: [
            Text('total'.tr().toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black)),
            Spacer(),
            PriceWidget(
                price: checkoutProvider.checkoutAmount.toString(),
                discount: 0,
                priceStyle: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black))
          ],
        ),
      );

  addPromoCodeButton(context) => Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXLarge),
        child: MaterialButton(
          onPressed: () => showDialog(
            context: context,
            builder: (ctx) => ChangeNotifierProvider(
              create: (ctx) =>
                  PromoCodeProvider(checkoutProvider.promoCode['code']),
              child: PromoCodeDialog(),
            ),
          ).then((value) {
            if (value != null) checkoutProvider.setPromoCode(value);
          }),
          padding: EdgeInsets.all(AppDimens.spacingMedium),
          shape: AppShapes.roundedRectShape(borderColor: AppColors.grey),
          child: Text(
              checkoutProvider.promoCode['code'] ?? 'add_promo_code'.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: AppColors.grey)),
        ),
      );

  selectedPromoCode() {
    double discount = checkoutProvider.promoCode['discount'].toDouble();
    return Container(
      padding: EdgeInsetsDirectional.only(start: AppDimens.spacingLarge),
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXLarge),
      decoration: AppShapes.roundedRectDecoration(
          borderColor: AppColors.grey, color: Colors.transparent),
      child: Row(
        children: [
          Text('Promo Code: ',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: AppColors.grey)),
          Expanded(
            child: Text(
              '${checkoutProvider.promoCode['code']} (-${discount.currencyFormat()})',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: AppColors.grey),
            ),
          ),
          IconButton(
            onPressed: () => checkoutProvider.cancelPromoCode(),
            icon: Icon(Icons.close, color: AppColors.grey),
          )
        ],
      ),
    );
  }

  confirmButton() => Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXLarge),
        child: MaterialButton(
          onPressed: () => checkoutProvider.placeAnOrder(),
          padding: EdgeInsets.all(AppDimens.spacingMedium),
          shape: AppShapes.roundedRectShape(),
          color: AppColors.grey,
          child: Text('confirm_order'.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.white)),
        ),
      );

  @override
  void dispose() {
    messageSubscription.cancel();
    super.dispose();
  }
}
