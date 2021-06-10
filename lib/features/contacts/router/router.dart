import 'package:auto_route/auto_route.dart';
import 'package:fusecash/common/router/route_guards.dart';
import 'package:fusecash/features/contacts/screens/contacts_list.dart';
import 'package:fusecash/features/screens/send_amount.dart';
import 'package:fusecash/features/screens/send_review.dart';
import 'package:fusecash/features/screens/send_success.dart';

const contactsTab = AutoRoute(
  path: 'contacts',
  name: 'contactsTab',
  page: EmptyRouterPage,
  guards: [AuthGuard],
  children: [
    AutoRoute(
      initial: true,
      page: ContactsList,
      name: 'contactsList',
      guards: [AuthGuard],
    ),
    AutoRoute(
      page: SendAmountScreen,
      guards: [AuthGuard],
    ),
    AutoRoute(
      page: SendReviewScreen,
      guards: [AuthGuard],
    ),
    AutoRoute(
      page: SendSuccessScreen,
      guards: [AuthGuard],
    ),
  ],
);
