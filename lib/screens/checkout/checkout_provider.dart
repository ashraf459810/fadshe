import 'dart:async';

import 'package:fad_shee/main.dart';
import 'package:fad_shee/network/result.dart';
import 'package:fad_shee/repositories/cart_repository.dart';
import 'package:fad_shee/repositories/order_repository.dart';
import 'package:fad_shee/screens/invoice_details/invoice_details_screen.dart';
import 'package:flutter/foundation.dart';

class CheckoutProvider with ChangeNotifier {
  CartRepository cartRepo = getIt<CartRepository>();
  OrderRepository orderRepo = getIt<OrderRepository>();
  StreamController<bool> loading = StreamController();
  StreamController<String> message = StreamController();
  Map<String, dynamic> promoCode = {'code': null, 'discount': null};
  int selectedPaymentMethodId = 1;

  setSSelectedPaymentMethodId(int id) {
    selectedPaymentMethodId = id;
    notifyListeners();
  }

  double get checkoutAmount => cartRepo.cartTotal;

  placeAnOrder() async {
    loading.sink.add(true);
    bool isOnlinePayment = selectedPaymentMethodId != 1;
    Result result = await orderRepo.placeAnOrder(selectedPaymentMethodId, promoCode: promoCode['code'] ?? '');
    message.sink.add(result.message);
    if (result.isSuccessful) {
      if (isOnlinePayment)
        navService.pushNamed(InvoiceDetailsScreen.routeName, arguments: result.result as int);
      else
        navService.pop();
    }
    loading.sink.add(false);
  }

  setPromoCode(Map<String, dynamic> promoCode) {
    this.promoCode = promoCode;
    notifyListeners();
  }

  cancelPromoCode() {
    promoCode['code'] = null;
    promoCode['discount'] = null;
    notifyListeners();
  }

  @override
  void dispose() {
    loading.close();
    message.close();
    super.dispose();
  }
}
