import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/features/contacts/screens/contacts_list.dart';

@MaterialAutoRouter(
  routesClassName: "ContactsRoutes",
  routes: <AutoRoute>[
    MaterialRoute(
      page: ContactsList,
      initial: true,
    ),
  ],
)
class $ContactsRouter {}
