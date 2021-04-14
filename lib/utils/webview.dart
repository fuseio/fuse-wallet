import 'dart:io';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/generated/i18n.dart';

void openDepositWebview({
  String url,
  bool withBack,
  String title,
}) {
  if (Platform.isIOS) {
    ExtendedNavigator.root.pushWebview(
      withBack: withBack,
      url: '$url&finalUrl=https://fuse.cash',
      title: title ??
          I18n.of(ExtendedNavigator.root.context).deposit_your_first_dollars,
    );
  } else {
    FlutterWebBrowser.openWebPage(
      url: '$url&finalUrl=https://fuse.cash',
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
