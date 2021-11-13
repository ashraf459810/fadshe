import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/models/data/invoice_item.dart';

class Invoice {
  final int id;
  final String date;
  final List<InvoiceItem> items;
  final double total;
  final bool isPaid;
  final bool isPaymentOnline;

  Invoice({this.id, this.date, this.items, this.total, this.isPaid, this.isPaymentOnline});

  factory Invoice.fromJson(Map<String, dynamic> jsonData) {
    return Invoice(
      id: jsonData['id'],
      date: DateFormat('yyyy-MM-dd HH:mm')
          .format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(jsonData['created_at'], true).toLocal()),
      items: (jsonData['order_items'] as List).map((e) => InvoiceItem.fromJson(e)).toList(),
      total: jsonData['total'],
      isPaid: (jsonData['status'] as Map)['name'] == 'Paid',
      isPaymentOnline: jsonData['order']['payment_method']['name'] != 'Cash On Delivery',
    );
  }
}
