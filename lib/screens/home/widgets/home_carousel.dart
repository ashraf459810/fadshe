import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fad_shee/models/ui/carousel_page_data.dart';
import 'package:fad_shee/screens/categories/categories_screen.dart';
import 'package:fad_shee/screens/category_details/category_details_screen.dart';
import 'package:fad_shee/screens/home/widgets/home_carousel_page.dart';
import 'package:flutter/material.dart';

class HomeCarousel extends StatelessWidget {
  final List<CarouselPageData> pagesData;

  HomeCarousel(this.pagesData);

  @override
  Widget build(BuildContext context) {
    print(pagesData[0].link);
    CarouselController carouselController = CarouselController();
    List<Widget> list = pagesData
        .map((e) => GestureDetector(
            onTap: () {
              log("here from gesture ");
              if (e.link == "#") {
              } else {
                var id = int.parse(e.link.split("/").last);
                var title = e.text ?? "";
                log(id.toString());
                log(title);

                Navigator.of(context).pushNamed(CategoryDetailsScreen.routeName,
                    arguments: {'category_id': id, 'category_title': title});
              }
            },
            child: HomeCarouselPage(e)))
        .toList();
    print(list.length);
    return CarouselSlider(
        carouselController: carouselController,
        items: list,
        options: CarouselOptions(
          viewportFraction: pagesData.length > 1 ? 0.85 : 1,
          initialPage: 0,
          enableInfiniteScroll: pagesData.length > 1,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 6),
          autoPlayCurve: Curves.decelerate,
          scrollDirection: Axis.horizontal,
        ));
  }
}
