import 'package:cached_network_image/cached_network_image.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/screens/product_details/product_details_screen.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:flutter/material.dart';

class ProductsGridItem extends StatelessWidget {
  final Product product;
  final bool showBorder;

  ProductsGridItem(this.product, {this.showBorder = false});

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
        padding: EdgeInsets.all(4),
        decoration: showBorder
            ? AppShapes.roundedRectDecoration(borderColor: AppColors.midGrey)
            : null,
        child: Column(
          children: [
            CachedNetworkImage(
                imageUrl: product.images.split(",").first,
                height: 100,
                fit: BoxFit.fitWidth),
            SizedBox(height: AppDimens.spacingSmall),
            Text(
              product.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
