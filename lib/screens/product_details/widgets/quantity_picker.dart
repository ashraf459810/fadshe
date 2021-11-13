import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/providers/cart_provider.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuantityPicker extends StatelessWidget {
  final Product product;
  final String attributes;

  QuantityPicker(this.product, this.attributes);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Row(
      children: [
        GestureDetector(
          onTap: () => cartProvider.decreaseItemQuantity(product, attributes),
          child: Container(
            width: 40,
            height: 40,
            decoration: AppShapes.circleDecoration(color: AppColors.grey.withOpacity(0.5)),
            child: Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingLarge),
          child: Text(cartProvider.getProductWithAttributesQuantity(product.id, attributes).toString(),
              style: Theme.of(context).textTheme.button.copyWith(color: Colors.black)),
        ),
        GestureDetector(
          onTap: () => cartProvider.increaseItemQuantity(product, attributes),
          child: Container(
            width: 40,
            height: 40,
            decoration: AppShapes.circleDecoration(color: AppColors.grey.withOpacity(0.5)),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
