import 'package:carousel_slider/carousel_slider.dart';
import 'package:fad_shee/models/data/banner.dart';
import 'package:fad_shee/screens/banner_screen/banner_details.dart';
import 'package:fad_shee/screens/search/search_screen.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/widgets/banners_carousel_page.dart';
import 'package:flutter/material.dart' hide Banner;

class BannersCarousel extends StatelessWidget {
  final List<Banner> banners;

  BannersCarousel(this.banners);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppDimens.spacingXLarge),
      child: CarouselSlider(
          items: banners
              .map((e) => GestureDetector(
                  onTap: () {
                    print(e.link);
                    if (e.link != "#") {
                      var url = e.link;
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BannerDetails(
                          url: url,
                        ),
                      ));
                    }
                  },
                  child: BannersCarouselPage(e)))
              .toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: banners.length > 1,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 6),
            autoPlayCurve: Curves.easeIn,
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}
