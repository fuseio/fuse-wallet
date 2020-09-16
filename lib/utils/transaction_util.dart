import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:esol/models/community/business.dart';
import 'package:esol/models/community/community.dart';
import 'package:esol/models/tokens/token.dart';
import 'package:esol/models/transactions/transfer.dart';
import 'package:esol/utils/format.dart';
import 'package:esol/utils/phone.dart';

String getIPFSImageUrl(String image) {
  if (image == null) {
    return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
  }
  return DotEnv().env['IPFS_BASE_URL'] + '/image/' + image;
}

String getS3ImageUrl(String image) {
  if (image == null) {
    return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
  }
  return '${DotEnv().env['FUSE_S3_BUCKET']}/$image';
}

Widget deduceTransferIcon(Transfer transfer) {
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

Token getToken(String tokenAddress, List<Community> communities,
    Map<String, Token> erc20Tokens) {
  if (erc20Tokens.containsKey(tokenAddress)) {
    return erc20Tokens[tokenAddress];
  } else {
    return communities
        .firstWhere(
            (community) =>
                community?.token?.address?.toLowerCase() ==
                tokenAddress?.toLowerCase(),
            orElse: () => communities.first)
        .token;
  }
}

Community getCommunity(String tokenAddress, List<Community> communities) {
  return communities.firstWhere(
      (community) =>
          community?.token?.address?.toLowerCase() ==
          tokenAddress?.toLowerCase(),
      orElse: () => communities.first);
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
  if (reverseContacts.containsKey(accountAddress.toLowerCase()) &&
      getReverseContact) {
    return reverseContacts[accountAddress.toLowerCase()];
  }
  if (format) {
    return formatAddress(accountAddress);
  } else {
    return accountAddress;
  }
}

dynamic getTransferImage(
    Transfer transfer, Contact contact, Community community,
    {bool isZeroAddress}) {
  if (isZeroAddress != null && isZeroAddress) {
    AssetImage(
      'assets/images/ethereume_icon.png',
    );
  }
  if (transfer.isJoinCommunity() &&
      ![null, ''].contains(community.metadata.image)) {
    return new NetworkImage(community.metadata.getImageUri());
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
      community?.homeBridgeAddress != null &&
      transfer?.to != null &&
      transfer?.to?.toLowerCase() ==
          community?.homeBridgeAddress?.toLowerCase()) {
    return new AssetImage(
      'assets/images/ethereume_icon.png',
    );
  }

  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  Business business = community?.businesses?.firstWhere(
      (business) => business.account == accountAddress,
      orElse: () => null);
  if (business != null) {
    return NetworkImage(business.metadata.getImageUri());
  }
  return new AssetImage('assets/images/anom.png');
}

dynamic getContactImage(Transfer transfer, Contact contact,
    {List<Business> businesses = const []}) {
  if (contact?.avatar != null && contact.avatar.isNotEmpty) {
    return new MemoryImage(contact.avatar);
  } else if (businesses.isNotEmpty) {
    String accountAddress =
        transfer.type == 'SEND' ? transfer.to : transfer.from;
    Business business = businesses.firstWhere(
        (business) => business.account == accountAddress,
        orElse: () => null);
    if (business != null) {
      return NetworkImage(business.metadata.getImageUri());
    }
  }
  return new AssetImage('assets/images/anom.png');
}
