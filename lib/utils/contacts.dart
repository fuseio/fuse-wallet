import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class Contacts {
  static Future<bool> getPermissions() async {
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

  static Future<Iterable<Contact>> getContacts() async {
    Iterable<Contact> contacts =
        (await ContactsService.getContacts(withThumbnails: !Platform.isAndroid))
            .where(
              (i) =>
                  i.displayName != null &&
                  i.displayName != "" &&
                  i.phones!.length > 0,
            )
            .toList();
    return contacts;
  }
}
