import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;
  final bool withBack;

  WebViewScreen({this.url, this.title, this.withBack = false});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    Segment.screen(screenName: '/web-view-screen');
    return MyScaffold(
      title: widget.title,
      resizeToAvoidBottomInset: !Platform.isIOS,
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.url,
        onPageStarted: (String url) {
          if (url.contains('https://fuse.io/')) {
            ExtendedNavigator.root.popUntilRoot();
          }
        },
      ),
    );
  }
}
