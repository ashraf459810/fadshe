import 'package:carousel_slider/carousel_slider.dart';
import 'package:fad_shee/models/data/brand.dart';
import 'package:fad_shee/widgets/brands_carousel_page.dart';
import 'package:flutter/material.dart' hide Banner;

class BrandsCarousel extends StatelessWidget {
  final List<Brand> brands;
  CarouselController carouselController = CarouselController();

  BrandsCarousel(this.brands);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        carouselController: carouselController,
        items: brands.map((e) => BrandsCarouselPage(e)).toList(),
        options: CarouselOptions(
          scrollPhysics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          initialPage: 1,
          enableInfiniteScroll: brands.length > 1,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayCurve: Curves.linear,
          scrollDirection: Axis.horizontal,
        ));
  }
}
