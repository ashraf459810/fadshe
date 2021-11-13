import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/invoice_details/invoice_details_provider.dart';
import 'package:fad_shee/screens/invoice_details/widgets/invoice_items_table.dart';
import 'package:fad_shee/screens/payment/payment_screen.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  static const routeName = '/invoice_details';

  @override
  _InvoiceDetailsScreenState createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends BaseScreenState<InvoiceDetailsScreen> {
  InvoiceDetailsProvider provider;

  @override
  onBuildStart() {
    provider = Provider.of<InvoiceDetailsProvider>(context);
  }

  @override
  Widget appBar(BuildContext context) =>
      CustomAppBar(context: context, titleText: '${'invoice'.tr()} #${provider.invoiceId}');

  @override
  Widget buildState(BuildContext context) {
    return provider.initialLoading
        ? initialLoading()
        : Stack(
            fit: StackFit.expand,
            children: [
              content(),
              if (!provider.invoice.isPaid && provider.invoice.isPaymentOnline)
                Positioned(
                  left: AppDimens.spacingXLarge,
                  right: AppDimens.spacingXLarge,
                  bottom: AppDimens.spacingXLarge,
                  child: payButton(),
                ),
            ],
          );
  }

  Widget initialLoading() => Center(
        child: SpinKitCircle(color: AppColors.grey.withOpacity(0.3)),
      );

  content() => Padding(
        padding: const EdgeInsets.all(AppDimens.spacingXLarge),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerRow(Icons.date_range, '${'date'.tr()}: '.toUpperCase(), provider.invoice.date),
              headerRow(Icons.assistant_photo_rounded, '${'status'.tr()}: '.toUpperCase(),
                  provider.invoice.isPaid ? 'paid'.tr() : 'unpaid'.tr()),
              SizedBox(height: AppDimens.spacingXXLarge),
              InvoiceItemsTable(provider.invoice.items, provider.invoice.total),
            ],
          ),
        ),
      );

  Widget headerRow(icon, title, value) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimens.spacingSmall),
      child: Row(
        children: [
          Icon(icon, size: AppDimens.iconSizeMedium, color: AppColors.grey),
          SizedBox(width: AppDimens.spacingSmall),
          Text(title, style: Theme.of(context).textTheme.headline4),
          SizedBox(width: AppDimens.spacingSmall),
          Text(value, style: Theme.of(context).textTheme.headline5.copyWith(color: AppColors.grey)),
        ],
      ),
    );
  }

  FlatButton payButton() {
    return FlatButton(
      onPressed: () {
        navService.pushNamed(PaymentScreen.routeName, arguments: provider.invoice.id);
      },
      minWidth: double.infinity,
      highlightColor: AppColors.red.withOpacity(0.1),
      height: 50,
      shape: AppShapes.roundedRectShape(borderColor: AppColors.red),
      child: Text('pay_now'.tr().toUpperCase(),
          style: Theme.of(context).textTheme.headline4.copyWith(color: AppColors.red)),
    );
  }
}
