import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/models/data/attribute.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/models/data/value.dart';
import 'package:fad_shee/providers/cart_provider.dart';
import 'package:fad_shee/screens/cart/cart_screen.dart';
import 'package:fad_shee/screens/product_details/widgets/quantity_picker.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductActions extends StatelessWidget {
  final Product product;
  final Map<Attribute, Value> attributesWithSelectedValues;

  ProductActions({@required this.product, @required this.attributesWithSelectedValues});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 20,
      color: Colors.white.withOpacity(0.95),
      child: Container(
        padding: EdgeInsets.all(AppDimens.spacingLarge),
        height: 80,
        child: cartActions(context),
      ),
    );
  }

  Widget cartActions(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    if (isAllAttributesSelected()) {
      if (cartProvider.getProductWithAttributesQuantity(product.id, formattedAttributes) == 0)
        return addToCartButton(context);
      else
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            QuantityPicker(product, formattedAttributes),
            removeFromCartButton(context),
          ],
        );
    } else {
      return cartProvider.getProductQuantity(product.id) == 0
          ? addToCartButton(context, isEnabled: false)
          : productTotalQuantityInCart(context, cartProvider.getProductQuantity(product.id));
    }
  }

  Widget addToCartButton(BuildContext context, {bool isEnabled = true}) => FlatButton.icon(
        onPressed: isEnabled
            ? () => Provider.of<CartProvider>(context, listen: false).addToCart(product, formattedAttributes)
            : null,
        shape: AppShapes.roundedRectShape(),
        padding: EdgeInsets.symmetric(vertical: AppDimens.spacingMedium),
        color: AppColors.grey,
        label: Text('add_to_cart'.tr().toUpperCase(),
            style: Theme.of(context).textTheme.button.copyWith(color: isEnabled ? Colors.white : Colors.grey[400])),
        icon: Icon(Icons.add_shopping_cart, color: isEnabled ? Colors.white : Colors.grey[400]),
      );

  Widget removeFromCartButton(BuildContext context) => Container(
        width: 150,
        child: FlatButton(
          onPressed: () => Provider.of<CartProvider>(context, listen: false).removeItem(product, formattedAttributes),
          shape: AppShapes.fullyRoundedRectShape(borderColor: AppColors.grey),
          child: Text('remove'.tr(), style: Theme.of(context).textTheme.button.copyWith(color: AppColors.grey)),
        ),
      );

  bool isAllAttributesSelected() {
    return !attributesWithSelectedValues.containsValue(null);
  }

  Widget productTotalQuantityInCart(BuildContext context, int quantity) => FlatButton.icon(
        onPressed: () => Navigator.of(context).pushNamed(CartScreen.routeName),
        icon: Icon(Icons.shopping_cart, size: 20, color: Colors.white),
        shape: AppShapes.roundedRectShape(),
        color: AppColors.grey,
        label: Text('$quantity ${'in_cart'.tr()}',
            style: Theme.of(context).textTheme.button.copyWith(color: Colors.white)),
      );

  String get formattedAttributes {
    String formattedAttributes;
    attributesWithSelectedValues.forEach((attribute, selectedValue) {
      if (selectedValue != null) {
        if (formattedAttributes != null)
          formattedAttributes += ', ';
        else
          formattedAttributes = '';
        formattedAttributes += selectedValue.name;
      }
    });
    return formattedAttributes;
  }
}
