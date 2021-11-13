import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/invoice_details/invoice_details_screen.dart';
import 'package:fad_shee/screens/main/main_screen.dart';
import 'package:fad_shee/screens/payment/payment_provider.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/payment';

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends BaseScreenState<PaymentScreen> {
  PaymentProvider provider;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  onBuildStart() {
    provider = Provider.of<PaymentProvider>(context);
  }

  @override
  Widget buildState(BuildContext context) {
    return provider.loading
        ? Container()
        : Stack(
            children: [
              WebView(
                initialUrl: provider.paymentUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.contains(provider.successfulPaymentIndicator)) {
                    navService.popUntil(MainScreen.routeName);
                    Flushbar(
                        backgroundColor: Colors.teal, message: 'payment_succeed'.tr(), duration: Duration(seconds: 3))
                      ..show(context);
                    return null;
                  } else if (request.url.contains(provider.failedPaymentIndicator) ||
                      request.url.contains(provider.errorPaymentIndicator)) {
                    navService.popUntil(InvoiceDetailsScreen.routeName);
                    Flushbar(
                        backgroundColor: Colors.redAccent,
                        message: 'payment_failed'.tr(),
                        duration: Duration(seconds: 3))
                      ..show(context);
                    return null;
                  }
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  provider.showPageLoader();
                },
                onPageFinished: (String url) {
                  provider.hidePageLoader();
                },
                gestureNavigationEnabled: true,
              ),
              if (provider.pageLoading) SpinKitCircle(color: AppColors.grey.withOpacity(0.3))
            ],
          );
  }
}
