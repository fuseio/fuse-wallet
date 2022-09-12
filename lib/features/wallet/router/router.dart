import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';

import 'package:fusecash/features/home/screens/action_details.dart';
import 'package:fusecash/features/wallet/screens/collectible.dart';
import 'package:fusecash/features/wallet/screens/contacts_list.dart';
import 'package:fusecash/features/wallet/screens/send_amount.dart';
import 'package:fusecash/features/wallet/screens/send_review.dart';
import 'package:fusecash/features/wallet/screens/send_success.dart';
import 'package:fusecash/features/wallet/screens/token.dart';
import 'package:fusecash/features/wallet/screens/wallet.dart';

const walletTab = AutoRoute(
  path: 'wallet',
  name: 'walletTab',
  page: EmptyRouterPage,
  children: [
    AutoRoute(
      initial: true,
      page: WalletPage,
    ),
    AutoRoute(
      page: ActionDetailsPage,
      path: 'action-details',
    ),
    AutoRoute(
      page: TokenPage,
    ),
    AutoRoute(
      page: CollectiblePage,
    ),
    AutoRoute(
      page: ContactsPage,
    ),
    AutoRoute(
      path: 'send-amount',
      page: SendAmountPage,
    ),
    AutoRoute(
      path: 'send-review',
      page: SendReviewPage,
    ),
    AutoRoute(
      path: 'send-success',
      page: SendSuccessPage,
    ),
  ],
);
