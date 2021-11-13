import 'package:cached_network_image/cached_network_image.dart';
import 'package:fad_shee/models/data/offer.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:flutter/material.dart';

class OfferPage extends StatelessWidget {
  final Offer offer;

  OfferPage(this.offer);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimens.spacingXSmall),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(AppDimens.spacingLarge)),
        child: CachedNetworkImage(imageUrl: offer.imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}
