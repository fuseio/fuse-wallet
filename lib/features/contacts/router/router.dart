import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/features/contacts/screens/contacts_list.dart';

@MaterialAutoRouter(
  routesClassName: "ContactsRoutes",
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    MaterialRoute(
      page: ContactsList,
      initial: true,
      name: 'contactsList',
    ),
  ],
)
class $ContactsRouter {}
