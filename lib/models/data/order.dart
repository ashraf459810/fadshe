import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Order {
  final int id;
  final int quantity;
  final double price;
  final double subtotal;
  final double total;
  final DateTime date;
  final String itemImageUrl;
  final String itemColor;
  final String itemSize;
  final int orderType;
  final String notes;
  final String cancelReason;
  final String damageReason;
  final String itemName;
  final int invoiceId;

  Order({
    @required this.id,
    @required this.quantity,
    @required this.price,
    @required this.subtotal,
    @required this.total,
    @required this.date,
    @required this.itemImageUrl,
    @required this.itemColor,
    @required this.itemSize,
    @required this.orderType,
    @required this.invoiceId,
    this.notes,
    this.cancelReason,
    this.damageReason,
    this.itemName,
  });

  factory Order.fromJson(Map<String, dynamic> jsonData) {
    try {
      return Order(
        id: jsonData['id'],
        itemColor: jsonData['item_color'],
        itemSize: jsonData['item_size'],
        quantity: jsonData['quantity'],
        price: jsonData['price']?.toDouble(),
        subtotal: jsonData['sub_total'].toDouble(),
        total: jsonData['total'].toDouble(),
        orderType: jsonData['order_types_id'],
        notes: jsonData['user_notes'],
        cancelReason: jsonData['cancel_reason'] != null ? (jsonData['cancel_reason'] as Map)['reason'] : null,
        damageReason: jsonData['damage_reason'],
        // 1: Normal order, 2: Custom Order
        date: DateFormat('yyyy-MM-ddTHH:mm:ss').parse(jsonData['created_at'], true),
        itemImageUrl: jsonData['mainImage'] != null
            ? 'http://fadshee.bitsblend.org/storage/item_files/${jsonData['mainImage']}'
            : null,
        itemName: jsonData['item_name'],
        invoiceId: jsonData['invoice_id'],
      );
    } catch (ex) {
      print('Exception while parsing: Order, ${jsonData.toString()}');
      throw ex;
    }
  }

  bool get hasAttributes => itemColor != null || itemSize != null;
}
