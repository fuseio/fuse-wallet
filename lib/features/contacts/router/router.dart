import 'package:auto_route/auto_route.dart';
import 'package:fusecash/features/contacts/screens/contacts_list.dart';

const contactsTab = AutoRoute(
  path: 'contacts',
  name: 'contactsTab',
  page: EmptyRouterPage,
  children: [
    AutoRoute(
      initial: true,
      page: ContactsList,
      name: 'contactsList',
    ),
  ],
);
