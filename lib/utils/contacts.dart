import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class Contacts {
  static Future<bool> getContactsPermission() async {
    bool isPermitted = await checkPermissions();

    if (!isPermitted) {
      bool gotPermission = await askForPermission();
      return gotPermission;
    } else {
      return isPermitted;
    }
  }

  static Future<bool> checkPermissions() async {
    final bool isGranted = await Permission.contacts.isGranted;
    return isGranted;
  }

  static Future<bool> askForPermission() async {
    PermissionStatus permission = await Permission.contacts.request();
    return permission == PermissionStatus.granted;
  }

  static Future<List<Contact>> getContacts() async {
    Iterable<Contact> contacts =
        (await ContactsService.getContacts(withThumbnails: false))
            .where((contact) =>
                ![null, ''].contains(contact.displayName) &&
                contact.phones.isNotEmpty)
            .toList();
    return contacts;
  }
}

class ContactController {
  static Future<bool> getPermissions() async {
    bool contactsPermission = await Contacts.getContactsPermission();

    return contactsPermission;
  }

  static Future<List<Contact>> getContacts() async {
    List<Contact> contacts = await Contacts.getContacts();

    return contacts;
  }
}
