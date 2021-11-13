import 'package:cached_network_image/cached_network_image.dart';
import 'package:fad_shee/models/ui/carousel_page_data.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:flutter/material.dart';

class HomeCarouselPage extends StatelessWidget {
  final CarouselPageData pageData;

  HomeCarouselPage(this.pageData);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimens.spacingSmall),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(AppDimens.spacingSmall)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
                imageUrl: pageData.imageUrl.split(",").first,
                fit: BoxFit.cover),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(12),
                color: Colors.white.withOpacity(0.8),
                child: Text(pageData.text ?? "",
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
