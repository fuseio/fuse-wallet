import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:digitalrand/models/community/business.dart';
import 'package:digitalrand/models/community/community.dart';
import 'package:digitalrand/models/tokens/token.dart';
import 'package:digitalrand/models/transactions/transfer.dart';
import 'package:digitalrand/utils/format.dart';
import 'package:digitalrand/utils/phone.dart';

String getIPFSImageUrl(String image) {
  return DotEnv().env['IPFS_BASE_URL'] + '/image/' + image;
}

Widget deduceTransferIcon(Transfer transfer) {
  if (transfer.isFailed()) {
    return SvgPicture.asset(
      'assets/images/failed_icon.svg',
      width: 14,
      height: 14,
    );
  }
  if (transfer.type == 'SEND') {
    return SvgPicture.asset(
      'assets/images/send_icon.svg',
      width: 14,
      height: 14,
    );
  } else if (transfer.type == 'RECEIVE') {
    return SvgPicture.asset(
      'assets/images/receive_icon.svg',
      width: 14,
      height: 14,
    );
  } else {
    return SvgPicture.asset(
      'assets/images/receive_icon.svg',
      width: 14,
      height: 14,
    );
  }
}

Token getToken(String tokenAddress, Map<String, Community> communities,
    Map<String, Token> erc20Tokens) {
  if (erc20Tokens.containsKey(tokenAddress)) {
    return erc20Tokens[tokenAddress];
  } else {
    return communities.values
        .toList()
        .firstWhere(
            (community) => community.token.address.contains(tokenAddress))
        .token;
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

String deducePhoneNumber(Transfer transfer, Map<String, String> reverseContacts,
    {bool format = true,
    List<Business> businesses,
    bool getReverseContact = true}) {
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
    Transfer transfer, Contact contact, Community community) {
  if (transfer.isJoinCommunity() &&
      community.metadata.image != null &&
      community.metadata.image != '') {
    return new NetworkImage(getIPFSImageUrl(community.metadata.image));
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
  } else if (community != null &&
      community.homeBridgeAddress != null &&
      transfer.to != null &&
      transfer.to?.toLowerCase() ==
          community.homeBridgeAddress?.toLowerCase()) {
    return new AssetImage(
      'assets/images/ethereume_icon.png',
    );
  }

  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  Business business = community.businesses.firstWhere(
      (business) => business.account == accountAddress,
      orElse: () => null);
  if (business != null) {
    return NetworkImage(getImageUrl(business, community.address));
  }
  return new AssetImage('assets/images/anom.png');
}

String getCoverPhotoUrl(business, communityAddress) {
  if (business.metadata.coverPhoto == null ||
      business.metadata.coverPhoto == '') {
    return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
  } else {
    return getIPFSImageUrl(business.metadata.coverPhoto);
  }
}

String getImageUrl(business, communityAddress) {
  if (business.metadata.image == null || business.metadata.image == '') {
    return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
  } else {
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
