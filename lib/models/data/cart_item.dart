import 'package:fad_shee/models/data/product.dart';

class CartItem {
  final int id;
  final Product product;
  final String attributes;
  int quantity;
  final double total;

  CartItem({this.id, this.product, this.quantity, this.attributes, this.total});

  factory CartItem.fromJson(Map<String, dynamic> jsonData) {
    return CartItem(
      id: jsonData['id'],
      product: Product.fromJson(jsonData['items']),
      quantity: jsonData['quantity'],
      attributes: jsonData['attributes'],
      total: jsonData['total'].toDouble(),
    );
  }
}
