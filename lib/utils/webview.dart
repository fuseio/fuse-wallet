import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/generated/l10n.dart';

void openDepositWebview({
  required BuildContext context,
  required String url,
  required bool withBack,
}) {
  final String link = url.contains('ramp')
      ? '$url&finalUrl=https://fuse.cash'
      : url.contains('transak')
          ? '$url&redirectURL=https://fuse.cash'
          : url;
  if (Platform.isIOS) {
    context.router.push(
      Webview(
        url: '$url&finalUrl=https://fuse.cash',
        title: I10n.of(context).top_up,
        withBack: true,
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
