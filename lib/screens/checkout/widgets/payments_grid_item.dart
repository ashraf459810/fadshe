import 'package:fad_shee/models/data/payment_method.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:flutter/material.dart';

class PaymentsGridItem extends StatelessWidget {
  final PaymentMethod paymentMethod;
  final bool isSelected;
  final Function(int) onPaymentMethodSelected;

  PaymentsGridItem({this.paymentMethod, this.isSelected, this.onPaymentMethodSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (paymentMethod.isEnabled) onPaymentMethodSelected(paymentMethod.id);
      },
      child: Container(
        decoration: AppShapes.roundedRectDecoration(
            borderColor: isSelected
                ? AppColors.red
                : paymentMethod.isEnabled
                    ? Colors.grey[400]
                    : Colors.grey[300]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              paymentMethod.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.normal,
                  color: isSelected
                      ? Colors.black
                      : paymentMethod.isEnabled
                          ? Colors.grey[600]
                          : Colors.grey[400]),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
