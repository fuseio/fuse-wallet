import 'dart:io';

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;
  final void Function(String)? onPageStarted;

  const WebViewPage(
    this.url,
    this.title, {
    this.onPageStarted,
    Key? key,
  }) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: !Platform.isIOS,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).canvasColor,
        title: AutoSizeText(
          widget.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Builder(
        builder: (BuildContext context) => WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.url,
          onPageStarted: widget.onPageStarted,
        ),
      ),
    );
  }
}
