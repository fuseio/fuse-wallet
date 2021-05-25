import 'dart:io';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/generated/l10n.dart';

void openDepositWebview({
  String url,
  bool withBack,
}) {
  final String link = url.contains('ramp')
      ? '$url&finalUrl=https://fuse.cash'
      : url.contains('transak')
          ? '$url&redirectURL=https://fuse.cash'
          : url;
  if (Platform.isIOS) {
    ExtendedNavigator.root.pushWebview(
      withBack: withBack,
      url: link,
      title: I10n.of(ExtendedNavigator.root.context).top_up,
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
