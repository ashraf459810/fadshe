import 'package:carousel_slider/carousel_slider.dart';
import 'package:fad_shee/models/data/offer.dart';
import 'package:fad_shee/widgets/offer_page.dart';
import 'package:flutter/material.dart';

class OffersCarousel extends StatelessWidget {
  final List<Offer> offers;

  OffersCarousel(this.offers);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: offers.map((e) => OfferPage(e)).toList(),
        options: CarouselOptions(
          viewportFraction: offers.length > 1 ? 0.85 : 1,
          initialPage: 0,
          enableInfiniteScroll: offers.length > 1,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 6),
          autoPlayCurve: Curves.decelerate,
          scrollDirection: Axis.horizontal,
        ));
  }
}
