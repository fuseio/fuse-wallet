import 'package:flutter/material.dart';

import 'package:charge_wallet_sdk/models/models.dart';

import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/features/wallet/send_amount_arguments.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/format.dart';

void sendToPastedAddress(
  accountAddress, {
  Token? token,
  Collectible? collectible,
}) {
  final args = SendFlowArguments(
    accountAddress: accountAddress,
    avatar: const AssetImage('assets/images/anom.png'),
    name: Formatter.formatEthAddress(accountAddress),
    tokenToSend: token,
    collectible: collectible,
  );
  Analytics.track(
    eventName: AnalyticsEvents.send2ChooseRecipient,
    properties: {
      'type': 'external',
    },
  );
  if (args.collectible != null) {
    getIt<RootRouter>().navigate(
      WalletTab(
        children: [
          const WalletRoute(),
          ContactsRoute(
            pageArgs: args,
          ),
          SendReviewRoute(
            pageArgs: args,
          ),
        ],
      ),
    );
  } else {
    getIt<RootRouter>().navigate(
      WalletTab(
        children: [
          const WalletRoute(),
          ContactsRoute(
            pageArgs: args,
          ),
          SendAmountRoute(
            pageArgs: args,
          ),
        ],
      ),
    );
  }
}
