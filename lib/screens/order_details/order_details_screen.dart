import 'package:cached_network_image/cached_network_image.dart';
import 'package:fad_shee/extensions/datetime_extensions.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/order_details/order_details_provider.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const routeName = '/order_details';

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends BaseScreenState<OrderDetailsScreen> {
  OrderDetailsProvider provider;

  @override
  onBuildStart() {
    provider = Provider.of<OrderDetailsProvider>(context);
  }

  @override
  Widget appBar(BuildContext context) => CustomAppBar(context: context, titleText: 'Order Details');

  @override
  Widget buildState(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior()..buildViewportChrome(context, null, AxisDirection.down),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(AppDimens.spacingXLarge),
              decoration: AppShapes.roundedRectDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (provider.order.itemImageUrl != null) itemImage(),
                  _buildOrderInfo(),
                  if (provider.order.hasAttributes) itemAttributes(),
                  if (provider.order.notes != null) notes(),
                ],
              ),
            ),
            if (provider.order.cancelReason != null) reason(provider.order.cancelReason),
            if (provider.order.damageReason != null) reason(provider.order.damageReason),
          ],
        ),
      ),
    );
  }

  Widget itemImage() => Padding(
        padding: const EdgeInsets.only(bottom: AppDimens.spacingMedium),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(AppDimens.borderRadiusMedium)),
          child: Container(
            alignment: Alignment.center,
            child: CachedNetworkImage(
              imageUrl: provider.order.itemImageUrl,
              width: 150,
            ),
          ),
        ),
      );

  Widget _buildOrderInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDataRow(context, 'DATE: ', provider.order.date.toDateFormat()),
        _buildDataRow(context, 'ORDER NO.: ', provider.order.id.toString()),
      ],
    );
  }

  Widget _buildDataRow(BuildContext ctx, String title, String value) => Row(
        children: [
          Text(title, style: Theme.of(ctx).textTheme.button.copyWith(color: AppColors.grey)),
          Text('  $value', style: Theme.of(ctx).textTheme.bodyText2),
        ],
      );

  itemAttributes() => Padding(
        padding: const EdgeInsets.only(top: AppDimens.spacingLarge),
        child: Column(
          children: [
            if (provider.order.itemColor != null) _buildAttributeRow('Color: ', provider.order.itemColor),
            if (provider.order.itemSize != null) _buildAttributeRow('Size: ', provider.order.itemSize),
          ],
        ),
      );

  _buildAttributeRow(title, value) => Row(
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.grey)),
          Text('  $value', style: Theme.of(context).textTheme.bodyText2),
        ],
      );

  notes() => Padding(
        padding: const EdgeInsets.only(top: AppDimens.spacingXXLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notes:', style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.grey)),
            Text(provider.order.notes, style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
      );

  Widget _buildSummary() {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimens.spacingXXLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (provider.order.price != null)
            _buildSummaryRow(
                context, 'SUMMARY:', '${provider.order.quantity} X ${provider.order.price.toStringAsFixed(0)}\$'),
          _buildSummaryRow(context, 'SUBTOTAL:', '${provider.order.subtotal.toStringAsFixed(0)}\$'),
          _buildSummaryRow(context, 'TOTAL:', '${provider.order.total.toStringAsFixed(0)}\$'),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext ctx, String title, String value) => Padding(
        padding: const EdgeInsets.only(top: AppDimens.spacingSmall),
        child: Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black)),
            Spacer(),
            Text('  $value', style: Theme.of(ctx).textTheme.headline5.copyWith(color: AppColors.blueGrey))
          ],
        ),
      );

  reason(String message) => Container(
        margin: EdgeInsets.only(top: AppDimens.spacingLarge),
        padding: EdgeInsets.symmetric(horizontal: AppDimens.spacingXLarge, vertical: AppDimens.spacingLarge),
        decoration: AppShapes.roundedRectDecoration(color: Colors.red.withOpacity(0.1)),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: AppDimens.iconSizeMedium),
            SizedBox(width: AppDimens.spacingSmall),
            Text(
              'Reason: ',
              style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.red, fontWeight: FontWeight.w700),
            ),
            Text(
              provider.order.cancelReason,
              style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.red),
            ),
          ],
        ),
      );

  processedActions() => Padding(
        padding: const EdgeInsets.only(top: AppDimens.spacingXXXLarge),
        child: Row(
          children: [
            Expanded(
              child: FlatButton(
                onPressed: () => provider.acceptOrder(true),
                padding: EdgeInsets.symmetric(vertical: AppDimens.spacingSmall),
                color: AppColors.grey,
                shape: AppShapes.roundedRectShape(),
                child: Text('Accept', style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white)),
              ),
            ),
            SizedBox(width: AppDimens.spacingSmall),
            Expanded(
              child: FlatButton(
                onPressed: () => provider.acceptOrder(false),
                padding: EdgeInsets.symmetric(vertical: AppDimens.spacingSmall),
                shape: AppShapes.roundedRectShape(borderColor: AppColors.grey),
                child: Text(
                  'Reject',
                  style: Theme.of(context).textTheme.headline5.copyWith(color: AppColors.grey),
                ),
              ),
            )
          ],
        ),
      );
}
