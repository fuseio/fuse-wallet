import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/widgets/my_scaffold.dart';

class InappWebViewScreen extends StatefulWidget {
  final String url;
  final String title;
  final bool withBack;

  InappWebViewScreen({this.url, this.title, this.withBack = false});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<InappWebViewScreen> {
  InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    Segment.screen(screenName: '/web-view-screen');
    return MyScaffold(
      title: widget.title,
      resizeToAvoidBottomInset: !Platform.isIOS,
      body: InAppWebView(
        initialUrl: widget.url,
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            mediaPlaybackRequiresUserGesture: false,
          ),
        ),
        onLoadStart: (InAppWebViewController, String url) {
          if (url.contains('https://fuse.io/')) {
            ExtendedNavigator.root.popUntilRoot();
          }
        },
        onWebViewCreated: (InAppWebViewController controller) {
          _webViewController = controller;
        },
        androidOnPermissionRequest: (
          InAppWebViewController controller,
          String origin,
          List<String> resources,
        ) async {
          log.info('origin $origin ${resources.toString()}');
          return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT,
          );
        },
      ),
    );
  }
}
