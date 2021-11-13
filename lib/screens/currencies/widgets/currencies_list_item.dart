import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/currency.dart';
import 'package:fad_shee/screens/currencies/currencies_provider.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrenciesListItem extends StatelessWidget {
  final Currency currency;

  CurrenciesListItem(this.currency);

  @override
  Widget build(BuildContext context) {
    bool isCurrentCurrency = currency.symbol == appCurrencySymbol;
    return GestureDetector(
      onTap: () => Provider.of<CurrenciesProvider>(context, listen: false).updateAppCurrency(currency.id),
      child: Container(
        padding: EdgeInsets.all(AppDimens.spacingLarge),
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(AppDimens.spacingXSmall),
                alignment: Alignment.center,
                decoration:
                    AppShapes.roundedRectDecoration(radius: AppDimens.spacingXSmall, borderColor: AppColors.midGrey),
                child: Text(currency.symbol, style: Theme.of(context).textTheme.button.copyWith(color: AppColors.grey)),
              ),
            ),
            SizedBox(width: AppDimens.spacingXXLarge),
            Expanded(
              flex: 6,
              child: Text(currency.name, style: Theme.of(context).textTheme.button.copyWith(color: Colors.black)),
            ),
            if (isCurrentCurrency)
              Container(width: 10, height: 10, decoration: AppShapes.circleDecoration(color: Colors.green))
          ],
        ),
      ),
    );
  }
}
