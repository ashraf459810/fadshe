import 'package:cached_network_image/cached_network_image.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/models/enum/list_item_location.dart';
import 'package:fad_shee/screens/product_details/product_details_screen.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:fad_shee/widgets/price_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsListItem extends StatelessWidget {
  final Product product;
  final ListItemLocation location;

  ProductsListItem(this.product, this.location);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ProductDetailsScreen.routeName,
          arguments: {
            'product_id': product.id,
            'product_name': product.title,
            'category_id': product.categoryId,
          }),
      child: Container(
        decoration: location == ListItemLocation.last
            ? null
            : BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.lightGrey))),
        padding: EdgeInsets.only(
            bottom: AppDimens.spacingMedium, top: AppDimens.spacingMedium),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: product.images.split(",").first,
              width: 110,
              height: 110,
            ),
            SizedBox(width: AppDimens.spacingXLarge),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title,
                      style: Theme.of(context).textTheme.headline4),
                  if (product.description != null)
                    Text(product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: AppColors.grey)),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: AppDimens.spacingSmall),
                    padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.spacingLarge, vertical: 2),
                    decoration: AppShapes.roundedRectDecoration(
                        radius: AppDimens.spacingXSmall,
                        borderColor: AppColors.red),
                    child: Text(product.categoryName.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: AppColors.red)),
                  ),
                  PriceWidget(price: product.price, discount: product.discount),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
