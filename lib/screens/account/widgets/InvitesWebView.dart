import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InvitesWebView extends StatefulWidget {
  static const routeName = '/webView';
  final String token;
  InvitesWebView({Key key, this.token}) : super(key: key);

  @override
  _InvitesWebViewState createState() => _InvitesWebViewState();
}

class _InvitesWebViewState extends State<InvitesWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
      initialUrl:
          'http://fadshee.com/api/referralWebView?api_token=${widget.token}',
      javascriptMode: JavascriptMode.unrestricted,
    ));
  }
}
