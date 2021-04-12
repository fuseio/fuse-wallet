import 'package:flutter_web_browser/flutter_web_browser.dart';

void openDepositWebview({
  String url,
  bool withBack,
  String title,
}) {
  FlutterWebBrowser.openWebPage(
    url: '$url&finalUrl=https://fuse.io',
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
