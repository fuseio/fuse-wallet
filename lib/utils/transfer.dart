import 'package:contacts_service/contacts_service.dart';
import 'package:supervecina/models/community/business.dart';
import 'package:supervecina/utils/constants.dart';
import 'package:supervecina/utils/format.dart';
import 'package:supervecina/utils/phone.dart';

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
  Map<String, String> reverseContacts, {
  List<Business?>? businesses,
}) {
  if (accountAddress == null) {
    return null;
  }
  if (donors.containsKey(accountAddress.toLowerCase())) {
    Map<String, String> donor = donors[accountAddress.toLowerCase()]!;
    return donor['name'];
  }
  if (businesses != null && businesses.isNotEmpty) {
    Business? business = businesses.firstWhere(
      (business) => business?.account == accountAddress,
    );
    if (business != null) {
      return business.name;
    }
  }
  if (reverseContacts.containsKey(accountAddress.toLowerCase())) {
    return reverseContacts[accountAddress.toLowerCase()];
  } else {
    return formatAddress(accountAddress);
  }
}
