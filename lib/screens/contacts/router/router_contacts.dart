import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/screens/contacts/contacts_list.dart';
import 'package:fusecash/screens/contacts/send_contact.dart';

@MaterialAutoRouter(routesClassName: "ContactsRoutes", routes: <AutoRoute>[
  MaterialRoute(
    // initial: true,
    page: ContactsList,
  ),
  MaterialRoute(
    page: EmptyContacts,
    name: 'emptyContacts',
    initial: true,
  ),
])
class $ContactsRouter {}
