import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/orders/orders_provider.dart';
import 'package:fad_shee/screens/orders/widgets/orders_list.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends BaseScreenState<OrdersScreen> {
  OrdersProvider provider;

  @override
  onBuildStart() {
    provider = Provider.of(context);
  }

  @override
  Widget appBar(BuildContext ctx) => CustomAppBar(context: ctx, titleText: 'my_orders'.tr());

  @override
  Widget buildState(BuildContext context) {
    return provider.initialLoading
        ? initialLoading()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: OrdersList(
              orders: provider.orders,
            ),
          );
  }

  Widget initialLoading() => Center(
        child: SpinKitCircle(color: AppColors.midGrey),
      );
}
