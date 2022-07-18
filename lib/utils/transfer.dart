import 'package:contacts_service/contacts_service.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/phone.dart';

Contact? getContact(
  String? accountAddress,
  Map<String, String> reverseContacts,
  List<Contact>? contacts,
  String countryCode,
) {
  if (accountAddress == null) {
    return null;
  }
  if (reverseContacts.containsKey(accountAddress.toLowerCase())) {
    String? phoneNumber = reverseContacts[accountAddress.toLowerCase()];
    if (contacts == null) return null;
    for (Contact? contact in contacts) {
      for (Item contactPhoneNumber in (contact!.phones!.toList())) {
        if (clearNotNumbersAndPlusSymbol(contactPhoneNumber.value ?? '') ==
            phoneNumber) {
          return contact;
        }
        if (formatPhoneNumber(contactPhoneNumber.value ?? '', countryCode) ==
            phoneNumber) {
          return contact;
        }
      }
    }
  }
  return null;
}

String? deducePhoneNumber(
  String? accountAddress,
  Map<String, String> reverseContacts,
) {
  if (accountAddress == null) {
    return null;
  }
  if (reverseContacts.containsKey(accountAddress.toLowerCase())) {
    return reverseContacts[accountAddress.toLowerCase()];
  } else {
    return Formatter.formatEthAddress(accountAddress);
  }
}
