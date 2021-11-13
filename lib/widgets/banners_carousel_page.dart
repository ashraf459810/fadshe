import 'package:cached_network_image/cached_network_image.dart';
import 'package:fad_shee/models/data/banner.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:flutter/material.dart' hide Banner;

class BannersCarouselPage extends StatelessWidget {
  final Banner banner;

  BannersCarouselPage(this.banner);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: AppDimens.spacingSmall),
      child: ClipRRect(
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
                imageUrl: banner.imageUrl.split(",").first, fit: BoxFit.cover),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(12),
                color: Colors.white.withOpacity(0.6),
                child: Text(banner.text,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
