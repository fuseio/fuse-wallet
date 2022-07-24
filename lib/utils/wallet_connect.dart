import 'dart:io';
import 'package:fusecash/redux/store.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/strings.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:wallet_connect/wallet_connect.dart';

final WCPeerMeta peerMeta = WCPeerMeta(
  name: Strings.appTitle,
  url: "https://fuse.io",
  description: "Cross platform mobile Ethereum wallet.",
  icons: [
    "https://fuse.io/images/favicons/android-chrome-36x36.png",
    "https://fuse.io/images/favicons/android-chrome-48x48.png",
    "https://fuse.io/images/favicons/android-chrome-72x72.png",
    "https://fuse.io/images/favicons/android-chrome-96x96.png",
    "https://fuse.io/images/favicons/android-chrome-144x144.png",
    "https://fuse.io/images/favicons/android-chrome-192x192.png",
    "https://fuse.io/images/favicons/android-chrome-256x256.png",
    "https://fuse.io/images/favicons/android-chrome-384x384.png",
    "https://fuse.io/images/favicons/android-chrome-512x512.png",
  ],
);

void connectToWC(String uri) async {
  if (getIt.isRegistered<WCClient>()) {
    getIt<WCClient>().connectNewSession(
      session: WCSession.from(uri),
      peerMeta: peerMeta,
    );
  } else {
    getIt<ReduxService>().store.dispatch(SetWalletConnectURI(uri));
  }
}

void wcURIParser(String? wcDeepLink) {
  if (wcDeepLink != null) {
    if (wcDeepLink.contains('key') && wcDeepLink.contains('bridge')) {
      final String wcURI =
          Platform.isIOS ? wcDeepLink.toString().split('?uri=')[1] : wcDeepLink;
      connectToWC(wcURI);
    }
  }
}
