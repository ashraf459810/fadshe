import 'package:fad_shee/screens/currencies/currencies_provider.dart';
import 'package:fad_shee/screens/currencies/widgets/currencies_list_item.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrenciesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CurrenciesProvider currenciesProvider = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: currenciesProvider.currencies.length,
        separatorBuilder: (ctx, index) => Container(height: 1, color: AppColors.lightGrey),
        itemBuilder: (ctx, index) => CurrenciesListItem(currenciesProvider.currencies[index]),
      ),
    );
  }
}
