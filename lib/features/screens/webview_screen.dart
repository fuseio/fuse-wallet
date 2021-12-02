import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supervecina/features/shared/widgets/my_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;
  final void Function(String)? onPageStarted;

  WebViewScreen(
    this.url,
    this.title, {
    this.onPageStarted,
  });

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
    return MyScaffold(
      title: widget.title,
      resizeToAvoidBottomInset: !Platform.isIOS,
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.url,
        onPageStarted: widget.onPageStarted,
      ),
    );
  }
}
