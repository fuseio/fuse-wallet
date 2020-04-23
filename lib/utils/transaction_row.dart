import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:local_champions/models/business.dart';
import 'package:local_champions/models/transactions/transfer.dart';
import 'package:local_champions/models/views/cash_wallet.dart';
// import 'package:local_champions/utils/forks.dart';
import 'package:local_champions/utils/format.dart';
import 'package:local_champions/utils/phone.dart';

String getIPFSImageUrl(String image) {
  return DotEnv().env['IPFS_BASE_URL'] + '/image/' + image;
}

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
    return Color(0xFFBEBEBE);
  } else {
    if (transfer.type == 'SEND') {
      return Color(0xFFFF0000);
    } else {
      return Color(0xFF00BE66);
    }
  }
}

String deducePhoneNumber(Transfer transfer, Map<String, String> reverseContacts,
    {bool format = true, List<Business> businesses, bool getReverseContact = true}) {
  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  if (businesses != null && businesses.isNotEmpty) {
    Business business = businesses.firstWhere(
        (business) => business.account == accountAddress,
        orElse: () => null);
    if (business != null) {
      return business.name;
    }
  }
  if (reverseContacts.containsKey(accountAddress) && getReverseContact) {
    return reverseContacts[accountAddress];
  }
  if (format) {
    return formatAddress(accountAddress);
  } else {
    return accountAddress;
  }
}

dynamic getTransferImage(
    Transfer transfer, Contact contact, CashWalletViewModel vm) {
  if (transfer.isJoinCommunity() &&
      vm.community.metadata.image != null &&
      vm.community.metadata.image != '') {
    return new NetworkImage(getIPFSImageUrl(vm.community.metadata.image));
  } else if (transfer.isGenerateWallet()) {
    return new AssetImage(
      'assets/images/generate_wallet.png',
    );
  } else if (transfer.isJoinBonus()) {
    return new AssetImage(
      'assets/images/join.png',
    );
  } else if (contact?.avatar != null && contact.avatar.isNotEmpty) {
    return new MemoryImage(contact.avatar);
  } else if (vm.community != null && vm.community.homeBridgeAddress != null && transfer.to != null && transfer.to?.toLowerCase() == vm.community.homeBridgeAddress?.toLowerCase()) {
    return new AssetImage(
      'assets/images/ethereume_icon.png',
    );
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
  }
  //  else if (isPaywise(communityAddress) || isPeso(communityAddress)) {
  //   return business.metadata.coverPhoto;
  // }
  else {
    return getIPFSImageUrl(business.metadata.coverPhoto);
  }
}

String getImageUrl(business, communityAddress) {
  if (business.metadata.image == null || business.metadata.image == '') {
    return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
  }
  // else if (isPaywise(communityAddress) || isPeso(communityAddress)) {
  //   return business.metadata.image;
  // }
  else {
    return getIPFSImageUrl(business.metadata.image);
  }
}

dynamic getContactImage(Transfer transfer, Contact contact, businesses) {
  if (contact?.avatar != null && contact.avatar.isNotEmpty) {
    return new MemoryImage(contact.avatar);
  } else {
    String accountAddress =
        transfer.type == 'SEND' ? transfer.to : transfer.from;
    Business business = businesses.firstWhere(
        (business) => business.account == accountAddress,
        orElse: () => null);
    if (business != null) {
      return NetworkImage(getImageUrl(business, ''));
    }
  }
  return new AssetImage('assets/images/anom.png');
}
