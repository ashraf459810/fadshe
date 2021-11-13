import 'package:fad_shee/models/data/order.dart';
import 'package:fad_shee/screens/orders/widgets/orders_list_item.dart';
import 'package:flutter/material.dart';

class OrdersList extends StatelessWidget {
  final List<Order> orders;

  OrdersList({this.orders});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior()..buildViewportChrome(context, null, AxisDirection.down),
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (ctx, index) => OrdersListItem(order: orders[index]),
      ),
    );
  }
}
