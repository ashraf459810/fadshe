import 'package:fad_shee/main.dart';
import 'package:fad_shee/network/result.dart';
import 'package:fad_shee/repositories/cart_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class PromoCodeProvider with ChangeNotifier {
  CartRepository cartRepo = getIt<CartRepository>();
  TextEditingController codeController;
  bool loading = false;
  String message;

  PromoCodeProvider(String code) {
    codeController = TextEditingController(text: code);
  }

  Future checkPromoCode() async {
    if (codeController.text.isEmpty) return;
    loading = true;
    message = null;
    notifyListeners();
    Result result = await cartRepo.getPromoCodeDiscount(codeController.text);
    if (result.isSuccessful) {
      navService.pop(argument: {'code': codeController.text, 'discount': result.result as double});
    } else {
      message = result.message;
      loading = false;
      notifyListeners();
    }
  }
}
