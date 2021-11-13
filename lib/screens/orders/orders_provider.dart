import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/order.dart';
import 'package:fad_shee/repositories/order_repository.dart';
import 'package:flutter/foundation.dart';

class OrdersProvider with ChangeNotifier {
  OrderRepository orderRepo = getIt<OrderRepository>();
  List<Order> orders = [];
  bool initialLoading = true;

  OrdersProvider() {
    orderRepo.fetchOrders().then((result) {
      if (result.isSuccessful) {
        orders.addAll(result.result as List<Order>);
        initialLoading = false;
      }
      notifyListeners();
    });
  }
}
