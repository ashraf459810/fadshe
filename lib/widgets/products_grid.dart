import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/widgets/products_grid_item.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  final List<Product> products;
  final int itemInRow;
  final bool showCellBorder;

  ProductsGrid(this.products, {this.itemInRow = 4, this.showCellBorder = false});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: itemInRow,
      childAspectRatio: itemInRow == 4 ? 0.6 : 1.3,
      crossAxisSpacing: itemInRow == 4 ? AppDimens.spacingXSmall : AppDimens.spacingMedium,
      mainAxisSpacing: itemInRow == 4 ? AppDimens.spacingXSmall : AppDimens.spacingMedium,
      children: [...products.map((product) => ProductsGridItem(product, showBorder: showCellBorder)).toList()],
    );
  }
}
