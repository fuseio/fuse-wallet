import 'package:auto_route/auto_route_annotations.dart';
import 'package:esol/screens/backup/show_mnemonic.dart';
import 'package:esol/screens/contacts/screens/contacts_list.dart';
import 'package:esol/screens/contacts/screens/empty_contacts.dart';
import 'package:esol/screens/profile/screen/profile.dart';

@MaterialAutoRouter(routesClassName: "ContactsRoutes", routes: <AutoRoute>[
  MaterialRoute(
    page: ContactsList,
  ),
  MaterialRoute(page: ShowMnemonic),
  MaterialRoute(page: ProfileScreen),
  MaterialRoute(
    page: EmptyContacts,
    name: 'emptyContacts',
    initial: true,
  ),
])
class $ContactsRouter {}
