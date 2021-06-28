import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/generated/l10n.dart';

void openDepositWebview({
  required BuildContext context,
  required String url,
}) {
  final String link = url.contains('ramp')
      ? '$url&finalUrl=https://fuse.io'
      : url.contains('transak')
          ? '$url&redirectURL=https://fuse.io'
          : url;
  if (Platform.isIOS) {
    context.router.push(
      Webview(
        url: '$url&finalUrl=https://fuse.io',
        title: I10n.of(context).top_up,
        onPageStarted: (String url) {
          if (url.contains('https://fuse.io/')) {
            context.router.popUntilRoot();
          }
        },
      ),
    );
  } else {
    FlutterWebBrowser.openWebPage(
      url: link,
      customTabsOptions: CustomTabsOptions(
        colorScheme: CustomTabsColorScheme.light,
        addDefaultShareMenuItem: true,
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: true,
      ),
      safariVCOptions: SafariViewControllerOptions(
        barCollapsingEnabled: true,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
  }
}
