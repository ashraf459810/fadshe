import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/extensions/double_extensions.dart';
import 'package:fad_shee/models/data/invoice_item.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:flutter/material.dart';

class InvoiceItemsTable extends StatelessWidget {
  final List<InvoiceItem> items;
  final double invoiceTotal;

  InvoiceItemsTable(this.items, this.invoiceTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(context),
        SizedBox(height: AppDimens.spacingMedium),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (ctx, index) => Divider(color: AppColors.lightGrey),
          itemCount: items.length,
          itemBuilder: (ctx, index) => itemRow(items[index]),
        ),
        SizedBox(height: AppDimens.spacingXLarge),
        total(context),
      ],
    );
  }

  header(context) => Row(
        children: [
          Icon(Icons.list, size: AppDimens.iconSizeMedium, color: AppColors.grey),
          SizedBox(width: AppDimens.spacingSmall),
          Expanded(
            child: Text('${'items'.tr()}'.toUpperCase(), style: Theme.of(context).textTheme.headline4),
          )
        ],
      );

  itemRow(InvoiceItem item) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMedium),
        child: Row(
          children: [
            Expanded(child: Text(item.title)),
            SizedBox(width: AppDimens.spacingXLarge),
            Text(item.price.currencyFormat()),
          ],
        ),
      );

  total(context) => Container(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.spacingMedium, vertical: AppDimens.spacingSmall),
        decoration: BoxDecoration(border: Border(top: BorderSide(color: AppColors.midGrey, width: 1))),
        child: Row(
          children: [
            Expanded(
              child: Text('total'.tr(), style: Theme.of(context).textTheme.headline3),
            ),
            Text(invoiceTotal.currencyFormat(), style: Theme.of(context).textTheme.headline3)
          ],
        ),
      );
}
