import 'package:cached_network_image/cached_network_image.dart';
import 'package:fad_shee/models/data/brand.dart';
import 'package:flutter/material.dart' hide Banner;

class BrandsCarouselPage extends StatelessWidget {
  final Brand brand;

  BrandsCarouselPage(this.brand);

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 10,
        child: CachedNetworkImage(
      imageUrl: brand.imageUrl.split(",").first,
      width: 120,
    ));
  }
}
