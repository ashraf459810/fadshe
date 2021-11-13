import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/invoice.dart';
import 'package:fad_shee/repositories/invoice_repository.dart';
import 'package:flutter/foundation.dart';

class InvoiceDetailsProvider with ChangeNotifier {
  InvoiceRepository invoiceRepo = getIt<InvoiceRepository>();
  bool initialLoading = true;
  final int invoiceId;
  Invoice invoice;

  InvoiceDetailsProvider(this.invoiceId) {
    invoiceRepo.fetchInvoiceDetails(invoiceId).then((result) {
      if (result.isSuccessful) {
        invoice = result.result as Invoice;
        initialLoading = false;
      }
      notifyListeners();
    });
    /*invoice = Invoice(id: 120, date: '2021-01-03 10:05', total: 10, isPaid: false, items: [
      InvoiceItem(title: 'Product name', quantity: 2, price: 10),
      InvoiceItem(title: 'Product name', quantity: 2, price: 10),
    ]);*/
  }
}
