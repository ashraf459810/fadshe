import 'package:fad_shee/extensions/double_extensions.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  final dynamic price;
  final double discount;
  final TextStyle priceStyle;

  PriceWidget({this.price, this.discount, this.priceStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            style: priceStyle != null
                ? priceStyle
                : Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: AppColors.grey),
            children: [
              TextSpan(
                  text:
                      '${(double.parse(price) - discount * double.parse(price) /100).currencyFormat(withSymbol: false)}'),
              TextSpan(
                  text: appCurrencySymbol,
                  style: priceStyle != null
                      ? priceStyle
                      : Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: AppColors.grey)),
            ],
          ),
        ),
        SizedBox(width: AppDimens.spacingXSmall),
        if (discount != 0)
          RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.grey[400],
                    decoration: TextDecoration.lineThrough),
                children: [
                  TextSpan(text: '${price.toString()}'),
                ]),
          ),
      ],
    );
  }
}
