import 'package:fad_shee/theme/AppDimes.dart';
import 'package:flutter/material.dart';

class ProductImagesPageView extends StatelessWidget {
  final String images;
  final PageController controller;

  ProductImagesPageView({@required this.controller, @required this.images});

  @override
  Widget build(BuildContext context) {
    print(" here the image {$images}");
    return PageView.builder(
      controller: controller,
      itemCount: images.length,
      itemBuilder: (ctx, index) => Container(
        margin: EdgeInsets.symmetric(horizontal: AppDimens.spacingXSmall),
        alignment: Alignment.center,
        child: Image.network(
          images,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
