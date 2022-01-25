import 'dart:typed_data';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supervecina/constants/addresses.dart';
import 'package:supervecina/models/actions/wallet_action.dart';
import 'package:supervecina/models/community/business.dart';
import 'package:supervecina/models/community/community.dart';

import 'constants.dart';

class ImageUrl {
  static bool _isIpfsHash(String hash) => hash.length == 46;
  static bool _isS3Hash(String hash) => hash.length == 64;

  static String getLink(String? hash) {
    if (hash != null) {
      if (_isIpfsHash(hash)) {
        return getIPFSImageUrl(hash);
      } else if (_isS3Hash(hash)) {
        return getS3ImageUrl(hash);
      }
    }
    return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
  }

  static ImageProvider getContactImage(
    Contact? contact,
  ) {
    if (contact?.avatar != null) {
      return MemoryImage(contact?.avatar as Uint8List);
    }
    return AssetImage('assets/images/anom.png');
  }

  static String getIPFSImageUrl(String? image) {
    if (image == null) {
      return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
    }
    return dotenv.env['IPFS_BASE_URL']! + '/image/' + image;
  }

  static String getS3ImageUrl(String? image) {
    if (image == null) {
      return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
    }
    return '${dotenv.env['FUSE_S3_BUCKET']}/$image';
  }

  static String getTokenUrl(tokenAddress) {
    return tokenAddress == Addresses.ZERO_ADDRESS
        ? 'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/info/logo.png'
        : "https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/assets/$tokenAddress/logo.png";
  }

  static String? getTokenByAddress(
    String? address,
    Map<String, String>? tokensImages,
  ) {
    return tokensImages?[address?.toLowerCase()];
  }

  static ImageProvider getActionImage(
    WalletAction action,
    Contact? contact,
    Community? community,
    String? accountAddress,
    Map<String, String> tokensImages, {
    Map<String, Business>? businesses,
  }) {
    final bool hasAvatar =
        contact?.avatar != null && contact!.avatar!.isNotEmpty;
    if (hasAvatar) {
      return MemoryImage(contact.avatar as Uint8List);
    }
    if (accountAddress != null) {
      if (donors.containsKey(accountAddress.toLowerCase())) {
        Map<String, String> donor = donors[accountAddress.toLowerCase()]!;
        return AssetImage('assets/images/${donor['image']}');
      }
      if (businesses != null && businesses.containsKey(accountAddress)) {
        return NetworkImage(businesses[accountAddress]!.metadata.image);
      }
    }
    return action.map(
      createWallet: (value) => AssetImage(
        'assets/images/generate_wallet.png',
      ),
      joinCommunity: (value) =>
          NetworkImage(ImageUrl.getLink(community?.metadata?.image)),
      fiatDeposit: (value) => tokensImages.containsKey(value.tokenAddress)
          ? NetworkImage(getTokenByAddress(value.tokenAddress, tokensImages)!)
          : NetworkImage(ImageUrl.getLink(community?.metadata?.image)),
      bonus: (value) => AssetImage(
        'assets/images/join.png',
      ),
      send: (value) => AssetImage('assets/images/anom.png'),
      receive: (value) => AssetImage('assets/images/anom.png'),
      swap: (value) => AssetImage('assets/images/swap_logo.png'),
    );
  }
}
