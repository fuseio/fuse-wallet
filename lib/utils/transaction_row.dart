import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/models/business.dart';
import 'package:fusecash/models/transfer.dart';
import 'package:fusecash/models/views/cash_wallet.dart';
import 'package:fusecash/utils/forks.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/phone.dart';

String deduceSign(Transfer transfer) {
  if (transfer.type == 'SEND') {
    return '-';
  } else {
    return '+';
  }
}

Contact getContact(Transfer transfer, Map<String, String> reverseContacts,
    List<Contact> contacts, String countryCode) {
  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  if (accountAddress == null) {
    return null;
  }
  if (reverseContacts.containsKey(accountAddress.toLowerCase())) {
    String phoneNumber = reverseContacts[accountAddress.toLowerCase()];
    if (contacts == null) return null;
    for (Contact contact in contacts) {
      for (Item contactPhoneNumber in contact.phones.toList()) {
        if (formatPhoneNumber(contactPhoneNumber.value, countryCode) ==
            phoneNumber) {
          return contact;
        }
      }
    }
  }
  return null;
}

Color deduceColor(Transfer transfer) {
  if (transfer.isFailed()) {
    return Color(0xFFE0E0E0);
  } else {
    if (transfer.type == 'SEND') {
      return Color(0xFFFF0000);
    } else {
      return Color(0xFF00BE66);
    }
  }
}

String deducePhoneNumber(Transfer transfer, Map<String, String> reverseContacts,
    {bool format = true, List<Business> businesses}) {
  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  if (businesses != null && businesses.isNotEmpty) {
    Business business = businesses.firstWhere(
        (business) => business.account == accountAddress,
        orElse: () => null);
    if (business != null) {
      return business.name;
    }
  }
  if (reverseContacts.containsKey(accountAddress)) {
    return reverseContacts[accountAddress];
  }
  if (format) {
    return formatAddress(accountAddress);
  } else {
    return accountAddress;
  }
}

dynamic getImage(Transfer transfer, Contact contact, CashWalletViewModel vm) {
  if (transfer.isJoinCommunity() &&
      vm.community.metadata.image != null &&
      vm.community.metadata.image != '') {
    return new NetworkImage(DotEnv().env['IPFS_BASE_URL'] +
        '/image/' +
        vm.community.metadata.image);
  } else if (transfer.isGenerateWallet()) {
    return new AssetImage(
      'assets/images/generate_wallet.png',
    );
  } else if (transfer.isJoinBonus()) {
    return new AssetImage(
      'assets/images/join.png',
    );
  } else if (contact?.avatar != null) {
    return new MemoryImage(contact.avatar);
  }

  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  Business business = vm.businesses.firstWhere(
      (business) => business.account == accountAddress,
      orElse: () => null);
  if (business != null) {
    return NetworkImage(getImageUrl(business, vm.communityAddress));
  }
  return new AssetImage('assets/images/anom.png');
}

String getCoverPhotoUrl(business, communityAddress) {
  if (business.metadata.coverPhoto == null ||
        business.metadata.coverPhoto == '') {
         return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
  } else if (isPaywise(communityAddress)) {
    return business.metadata.coverPhoto;
  }
  else {
    return DotEnv().env['IPFS_BASE_URL'] + '/image/' + business.metadata.coverPhoto;
  }
}

String getImageUrl(business, communityAddress) {
  if (business.metadata.image == null ||
        business.metadata.image == '') {
         return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
  } else if (isPaywise(communityAddress)) {
    return business.metadata.image;
  }
  else {
    return DotEnv().env['IPFS_BASE_URL'] + '/image/' + business.metadata.image;
  }
}

