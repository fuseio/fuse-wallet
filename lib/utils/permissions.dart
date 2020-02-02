import 'package:contacts_service/contacts_service.dart';
import 'package:paywise/redux/actions/cash_wallet_actions.dart';
import 'package:permission_handler/permission_handler.dart';

Future<List<Contact>> loadContacts(
    Function syncContactsRejected, Function syncContacts) async {
  PermissionStatus permission = (await PermissionHandler().requestPermissions(
      [PermissionGroup.contacts]))[PermissionGroup.contacts];
  if (permission != PermissionStatus.granted) {
    logger.w('Permission to get the contracts denied');
    syncContactsRejected();
    return null;
  }

  // contacts = contacts
  //     .where((i) =>
  //         i.displayName != null && i.displayName != "" && i.phones.length > 0)
  List<Contact> contacts = (await ContactsService.getContacts(
          withThumbnails: true))
      .where((i) =>
          i.displayName != null && i.displayName != "" && i.phones.length > 0)
      .toList();
  syncContacts(contacts);
  return contacts;
}
