import 'package:fad_shee/network/dio_http_client.dart';

class Payment {
  String get successfulPaymentIndicator => '/Payments/PaymentSuccess';
  String get failedPaymentIndicator => '/Payments/PaymentFailed';
  String get errorPaymentIndicator => '/Payments/PaymentError';

  String getPaymentLink(int invoiceId) {
    return '${DioHttpClient.baseUrl}/Payments/PayInvoice/$invoiceId';
  }
}
