import 'dart:io';

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
      url: '$url&finalUrl=https://fuse.io',
      title: title ??
          I18n.of(ExtendedNavigator.root.context).deposit_your_first_dollars,
    );
  } else {
    ExtendedNavigator.root.pushInAppWebview(
      withBack: withBack,
      url: '$url&finalUrl=https://fuse.io',
      title: title ??
          I18n.of(ExtendedNavigator.root.context).deposit_your_first_dollars,
    );
  }
}
