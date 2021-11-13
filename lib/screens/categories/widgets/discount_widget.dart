import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DiscountWidget extends StatelessWidget {
  final int discount;

  DiscountWidget({@required this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1)),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white),
          children: [
            TextSpan(text: '${'sale'.tr()}\n'),
            TextSpan(text: '$discount', style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.white)),
            TextSpan(text: '%')
          ],
        ),
      ),
    );
  }
}
