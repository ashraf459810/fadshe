import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/extensions/list_extensions.dart';
import 'package:fad_shee/models/ui/account_item_model.dart';
import 'package:fad_shee/network/endpoints/invite.dart';
import 'package:fad_shee/network/result.dart';
import 'package:fad_shee/providers/user_provider.dart';
import 'package:fad_shee/repositories/user_repository.dart';
import 'package:fad_shee/screens/account/widgets/account_list_item.dart';
import 'package:fad_shee/screens/currencies/currencies_screen.dart';
import 'package:fad_shee/screens/languages/languages_screen.dart';
import 'package:fad_shee/screens/login/login_screen.dart';
import 'package:fad_shee/screens/orders/orders_screen.dart';
import 'package:fad_shee/screens/wishlist/wishlist_screen.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';

// ignore: must_be_immutable
class AccountList extends StatelessWidget {
  final Function logout;

  AccountList({@required this.logout});

  List<AccountItemModel> getOptions(isLoggedIn) => [
        if (!isLoggedIn)
          AccountItemModel(
              icon: 'ic_logout.png',
              title: 'sign_in'.tr(),
              onClick: logout,
              onClickNavigateTo: LoginScreen.routeName),
        if (isLoggedIn)
          AccountItemModel(
              icon: 'ic_order.png',
              title: 'view_my_orders'.tr(),
              onClickNavigateTo: OrdersScreen.routeName),
        if (isLoggedIn)
          AccountItemModel(
              icon: 'ic_empty_wishlist.png',
              title: 'wishlist'.tr(),
              onClickNavigateTo: WishListScreen.routeName),
        AccountItemModel(
            icon: 'ic_language.png',
            title: 'change_language'.tr(),
            onClickNavigateTo: LanguagesScreen.routeName),
        AccountItemModel(
            icon: 'ic_currency.png',
            title: 'currency'.tr(),
            onClickNavigateTo: CurrenciesScreen.routeName),
        AccountItemModel(
            icon: 'invite.png',
            title: 'invite'.tr(),
            // onClickNavigateTo: CurrenciesScreen.routeName,
            onClick: () async {
              UserRepository userRepo = getIt<UserRepository>();
              var token = userRepo.token;
              print(token);
              await launch(
                  "http://fadshee.com/api/referralWebView?api_token=$token");
            }),
        if (isLoggedIn)
          AccountItemModel(
              icon: 'ic_logout.png',
              title: 'logout'.tr(),
              onClick: logout,
              showArrow: false),
      ];

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    List<AccountItemModel> options = getOptions(userProvider.isLoggedIn);
    return Container(
      decoration: AppShapes.roundedRectDecoration(color: Colors.grey[50]),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: options.length,
        itemBuilder: (ctx, index) => AccountListItem(
          item: options[index],
          location: options.getItemLocation(index),
        ),
      ),
    );
  }
}
