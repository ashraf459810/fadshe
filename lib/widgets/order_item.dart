import 'package:cached_network_image/cached_network_image.dart';
import 'package:fad_shee/models/data/cart_item.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/widgets/price_widget.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final CartItem item;

  OrderItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMedium),
      child: Row(
        children: [
          itemImage(),
          SizedBox(width: AppDimens.spacingXLarge),
          Expanded(child: itemInfoColumn(context)),
        ],
      ),
    );
  }

  Widget itemImage() => ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(AppDimens.borderRadiusMedium)),
        child: CachedNetworkImage(
          imageUrl: item.product.images.split(",").first,
          width: 110,
          height: 110,
        ),
      );

  Widget itemInfoColumn(BuildContext ctx) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.product.title,
              style: Theme.of(ctx)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.black)),
          SizedBox(height: AppDimens.spacingXSmall),
          if (item.attributes != null && item.attributes.isNotEmpty)
            attributes(ctx),
          SizedBox(height: AppDimens.spacingXSmall),
          Row(
            children: [
              Text('${item.quantity} X ',
                  style: Theme.of(ctx)
                      .textTheme
                      .subtitle1
                      .copyWith(color: AppColors.grey)),
              PriceWidget(
                  price: item.product.price, discount: item.product.discount)
            ],
          )
        ],
      );

  Widget attributes(BuildContext ctx) => Text(
        item.attributes,
        style: Theme.of(ctx)
            .textTheme
            .subtitle1
            .copyWith(color: AppColors.lightGrey),
      );
}
