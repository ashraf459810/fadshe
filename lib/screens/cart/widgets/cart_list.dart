import 'package:fad_shee/extensions/list_extensions.dart';
import 'package:fad_shee/providers/cart_provider.dart';
import 'package:fad_shee/screens/cart/widgets/cart_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartList extends StatelessWidget {
  final bool shrinkWrap;
  final bool popIfCartEmpty;

  CartList({this.shrinkWrap = false, this.popIfCartEmpty = false});

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return ScrollConfiguration(
      behavior: ScrollBehavior()..buildViewportChrome(context, null, AxisDirection.down),
      child: ListView.builder(
        shrinkWrap: shrinkWrap,
        physics: shrinkWrap ? NeverScrollableScrollPhysics() : null,
        itemCount: cartProvider.itemsCount,
        itemBuilder: (ctx, index) =>
            CartListItem(cartProvider.items[index], popIfCartEmpty, cartProvider.items.getItemLocation(index)),
      ),
    );
  }
}
