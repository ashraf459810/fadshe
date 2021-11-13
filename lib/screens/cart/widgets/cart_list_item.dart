import 'package:fad_shee/models/data/cart_item.dart';
import 'package:fad_shee/models/enum/list_item_location.dart';
import 'package:fad_shee/providers/cart_provider.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:fad_shee/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartListItem extends StatelessWidget {
  final CartItem item;
  final bool popIfCartEmpty;
  final ListItemLocation location;

  CartListItem(this.item, this.popIfCartEmpty, this.location);

  @override
  Widget build(BuildContext context) => Container(
        decoration: AppShapes.roundedRectDecoration(radius: 12, borderColor: AppColors.grey.withOpacity(0.2)),
        margin: EdgeInsets.only(
            top: AppDimens.spacingMedium,
            left: AppDimens.pagePadding,
            right: AppDimens.pagePadding,
            bottom: location == ListItemLocation.last ? AppDimens.spacingXLarge : 0),
        padding: EdgeInsets.symmetric(vertical: AppDimens.spacingMedium, horizontal: AppDimens.spacingMedium),
        child: Row(
          children: [
            Expanded(child: OrderItem(item)),
            removeButton(context),
          ],
        ),
      );

  Widget removeButton(BuildContext context) => IconButton(
        icon: Icon(Icons.cancel, color: AppColors.blueGrey.withAlpha(80)),
        onPressed: () async {
          CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
          await cartProvider.removeItem(item.product, item.attributes);
          if (cartProvider.itemsCount == 0 && popIfCartEmpty) Navigator.of(context).pop();
        },
      );
}
