import 'package:fad_shee/main.dart';
import 'package:fad_shee/network/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PaymentProvider with ChangeNotifier {
  String paymentUrl;
  bool loading = true;
  bool pageLoading = true;

  String get successfulPaymentIndicator => getIt<ApiService>().payment.successfulPaymentIndicator;
  String get failedPaymentIndicator => getIt<ApiService>().payment.failedPaymentIndicator;
  String get errorPaymentIndicator => getIt<ApiService>().payment.errorPaymentIndicator;

  PaymentProvider(int invoiceId) {
    getIt<FlutterSecureStorage>().read(key: 'token').then((token) {
      paymentUrl = '${getIt<ApiService>().payment.getPaymentLink(invoiceId)}?api_token=$token';
      loading = false;
      notifyListeners();
    });
  }

  showPageLoader() {
    pageLoading = true;
    notifyListeners();
  }

  hidePageLoader() {
    pageLoading = false;
    notifyListeners();
  }
}
