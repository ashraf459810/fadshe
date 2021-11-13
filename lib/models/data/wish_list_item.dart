import 'package:fad_shee/models/data/product.dart';
import 'package:flutter/foundation.dart';

class WishListItem {
  final int id;
  final Product product;

  WishListItem({@required this.id, this.product});

  factory WishListItem.fromJson(Map<String, dynamic> jsonData) => WishListItem(
        id: jsonData['id'],
        product: Product.fromJson(jsonData['item']),
      );
}
