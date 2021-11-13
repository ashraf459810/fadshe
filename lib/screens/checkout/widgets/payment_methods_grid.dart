import 'package:fad_shee/models/data/payment_method.dart';
import 'package:fad_shee/screens/checkout/widgets/payments_grid_item.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PaymentMethodsGrid extends StatelessWidget {
  final int selectedPaymentMethodId;
  final Function(int) onPaymentMethodSelected;

  PaymentMethodsGrid({this.selectedPaymentMethodId, this.onPaymentMethodSelected});

  List<PaymentMethod> paymentMethods = [
    PaymentMethod(1, 'Cash on Delivery (COD)'),
    PaymentMethod(3, 'Zain Cash'),
    PaymentMethod(2, 'Credit Card', isEnabled: false),
    PaymentMethod(4, 'PayPal', isEnabled: false),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3.5,
      crossAxisSpacing: AppDimens.spacingSmall,
      mainAxisSpacing: AppDimens.spacingSmall,
      children: [
        ...paymentMethods
            .map((paymentMethod) => PaymentsGridItem(
                  paymentMethod: paymentMethod,
                  isSelected: selectedPaymentMethodId == paymentMethod.id,
                  onPaymentMethodSelected: onPaymentMethodSelected,
                ))
            .toList(),
      ],
    );
  }
}
