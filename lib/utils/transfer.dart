import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/models/community/business.dart';
import 'package:fusecash/models/transactions/transaction.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/phone.dart';

Widget deduceTransferIcon(Transaction transfer) {
  if (transfer.isFailed()) {
    return SvgPicture.asset(
      'assets/images/failed_icon.svg',
      width: 10,
      height: 10,
    );
  }
  if (transfer.isSwap != null && transfer.isSwap) {
    return SvgPicture.asset(
      'assets/images/trade_icon.svg',
      width: 10,
      height: 10,
    );
  }
  if (transfer.type == 'SEND') {
    return SvgPicture.asset(
      'assets/images/send_icon.svg',
      width: 10,
      height: 10,
    );
  } else if (transfer.type == 'RECEIVE') {
    return SvgPicture.asset(
      'assets/images/receive_icon.svg',
      width: 10,
      height: 10,
    );
  } else {
    return SvgPicture.asset(
      'assets/images/receive_icon.svg',
      width: 10,
      height: 10,
    );
  }
}

Contact getContact(
  Transaction transfer,
  Map<String, String> reverseContacts,
  List<Contact> contacts,
  String countryCode,
) {
  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  if (accountAddress == null) {
    return null;
  }
  if (reverseContacts.containsKey(accountAddress.toLowerCase())) {
    String phoneNumber = reverseContacts[accountAddress.toLowerCase()];
    if (contacts == null) return null;
    for (Contact contact in contacts) {
      for (Item contactPhoneNumber in contact.phones.toList()) {
        if (clearNotNumbersAndPlusSymbol(contactPhoneNumber.value) ==
            phoneNumber) {
          return contact;
        }
        if (formatPhoneNumber(contactPhoneNumber.value, countryCode) ==
            phoneNumber) {
          return contact;
        }
      }
    }
  }
  return null;
}

String deducePhoneNumber(
  Transaction transfer,
  Map<String, String> reverseContacts, {
  List<Business> businesses,
}) {
  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  if (businesses != null && businesses.isNotEmpty) {
    Business business = businesses.firstWhere(
      (business) => business.account == accountAddress,
      orElse: () => null,
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
