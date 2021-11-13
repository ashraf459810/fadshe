import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/extensions/datetime_extensions.dart';
import 'package:fad_shee/extensions/double_extensions.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/order.dart';
import 'package:fad_shee/screens/invoice_details/invoice_details_screen.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:flutter/material.dart';

class OrdersListItem extends StatelessWidget {
  final Order order;

  OrdersListItem({@required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.spacingXSmall),
      child: Container(
        padding: EdgeInsets.fromLTRB(
            AppDimens.spacingXXLarge,
            AppDimens.spacingLarge,
            AppDimens.spacingLarge,
            AppDimens.spacingLarge),
        decoration: AppShapes.roundedRectDecoration(
            color: Colors.grey[50], borderColor: Colors.grey[200]),
        child: Row(
          children: [
            if (order.itemImageUrl != null) itemImage(),
            Expanded(child: itemInfo(context)),
            SizedBox(width: AppDimens.spacingLarge),
            //Icon(Icons.arrow_forward_ios, size: AppDimens.iconSizeSmall, color: AppColors.midGrey)
          ],
        ),
      ),
    );
  }

  Widget itemImage() => Padding(
        padding: const EdgeInsetsDirectional.only(end: AppDimens.spacingXLarge),
        child: ClipRRect(
          borderRadius:
              BorderRadius.all(Radius.circular(AppDimens.borderRadiusMedium)),
          child: CachedNetworkImage(
            imageUrl: order.itemImageUrl.split(",").first,
            width: 110,
            height: 110,
          ),
        ),
      );

  Widget itemInfo(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order #${order.id}'.toUpperCase(),
              style: Theme.of(context).textTheme.headline6),
          SizedBox(height: AppDimens.spacingXSmall),
          Text(order.date.toDateFormat(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.grey)),
          SizedBox(height: AppDimens.spacingLarge),
          Wrap(
            children: [
              Text(order.quantity.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black)),
              Text(' x ',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black)),
              Text(order.itemName,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black)),
            ],
          ),
          SizedBox(height: AppDimens.spacingMedium),
          Text(order.total.currencyFormat(),
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.grey)),
          SizedBox(height: AppDimens.spacingMedium),
          showInvoiceButton(context),
        ],
      );

  showInvoiceButton(BuildContext context) => FlatButton(
        onPressed: () => navService.pushNamed(InvoiceDetailsScreen.routeName,
            arguments: order.invoiceId),
        shape: AppShapes.roundedRectShape(
            radius: AppDimens.spacingXSmall, borderColor: AppColors.blueGrey),
        child: Text('show_invoice'.tr().toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: AppColors.blueGrey)),
      );
}
