import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/currencies/widgets/currencies_list.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CurrenciesScreen extends StatefulWidget {
  static const routeName = '/currencies';

  @override
  _CurrenciesScreenState createState() => _CurrenciesScreenState();
}

class _CurrenciesScreenState extends BaseScreenState<CurrenciesScreen> {
  @override
  Widget appBar(BuildContext ctx) => CustomAppBar(context: ctx, titleText: 'currencies'.tr().toUpperCase());

  @override
  Widget buildState(BuildContext context) {
    return CurrenciesList();
  }
}
