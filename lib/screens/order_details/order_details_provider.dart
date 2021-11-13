import 'dart:async';

import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/order.dart';
import 'package:fad_shee/network/result.dart';
import 'package:fad_shee/repositories/order_repository.dart';
import 'package:flutter/foundation.dart';

class OrderDetailsProvider with ChangeNotifier {
  OrderRepository orderRepo = getIt<OrderRepository>();
  Order order;

  StreamController<String> message = StreamController();

  OrderDetailsProvider(this.order);

  Future acceptOrder(bool accept) async {
    Result result = await orderRepo.acceptOrder(order.id, accept);
    message.sink.add(result.message);
    if (result.isSuccessful) {
      navService.pop(argument: accept);
    }
  }

  @override
  void dispose() {
    message.close();
    super.dispose();
  }
}
