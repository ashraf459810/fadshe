import 'package:fad_shee/extensions/list_extensions.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/widgets/products_list_item.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatelessWidget {
  final List<Product> products;

  ProductsList(this.products);

  @override
  Widget build(BuildContext context) {
    print("here from library");
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (ctx, index) =>
          ProductsListItem(products[index], products.getItemLocation(index)),
    );
  }
}
