import 'package:flutter/material.dart';

import 'package:wallet_connect/wallet_connect.dart';

import 'package:fusecash/common/di/di.dart';

class WalletConnectLogos extends StatelessWidget {
  const WalletConnectLogos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getIt<WCClient>().isConnected &&
            getIt<WCClient>().remotePeerMeta != null &&
            getIt<WCClient>().remotePeerMeta!.icons.isNotEmpty
        ? Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  radius: 38.5,
                  backgroundImage: NetworkImage(
                    getIt<WCClient>().sessionStore.remotePeerMeta.icons.last,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 15,
                ),
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  radius: 38.5,
                  backgroundImage:
                      const AssetImage('assets/images/icon_app.png'),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
