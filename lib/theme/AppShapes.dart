import 'package:cached_network_image/cached_network_image.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:flutter/material.dart';

class AppShapes {
  static BoxDecoration roundedRectDecoration(
      {double radius = 5, Color color = Colors.white, Color borderColor = Colors.transparent, String backgroundImage}) {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: borderColor),
        color: color,
        image: backgroundImage != null
            ? DecorationImage(
                image: CachedNetworkImageProvider(backgroundImage),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(AppColors.grey.withOpacity(0.8), BlendMode.multiply))
            : null);
  }

  static BoxDecoration fullyRoundedRectDecoration(
      {Color color = Colors.white, Color borderColor = Colors.transparent}) {
    return roundedRectDecoration(radius: 50, borderColor: borderColor, color: color);
  }

  static RoundedRectangleBorder roundedRectShape(
      {double radius = AppDimens.borderRadiusMedium, Color borderColor = Colors.transparent}) {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)), side: BorderSide(color: borderColor));
  }

  static RoundedRectangleBorder fullyRoundedRectShape({Color borderColor = Colors.transparent}) {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)), side: BorderSide(color: borderColor));
  }

  static BoxDecoration circleDecoration({Color color = Colors.white, Color borderColor = Colors.transparent}) {
    return BoxDecoration(
      color: color,
      border: Border.all(color: borderColor),
      shape: BoxShape.circle,
    );
  }
}
