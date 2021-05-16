import 'dart:typed_data';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/constants/addresses.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/community/community.dart';

class ImageUrl {
  static bool _isIpfsHash(String hash) => hash != null && hash.length == 46;
  static bool _isS3Hash(String hash) => hash != null && hash.length == 64;

  static String getLink(hash) {
    if (_isIpfsHash(hash)) {
      return getIPFSImageUrl(hash);
    } else if (_isS3Hash(hash)) {
      return getS3ImageUrl(hash);
    }
    return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
  }

  static ImageProvider getContactImage(
    Contact? contact,
  ) {
    if (contact?.avatar != null) {
      return new MemoryImage(contact?.avatar as Uint8List);
    }
    return new AssetImage('assets/images/anom.png');
  }

  static String getIPFSImageUrl(String? image) {
    if (image == null) {
      return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
    }
    return (env['IPFS_BASE_URL'] ?? '') + '/image/' + image;
  }

  static String getS3ImageUrl(String image) {
    if (image == null) {
      return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
    }
    return '${env['FUSE_S3_BUCKET']}/$image';
  }

  static String getTokenUrl(tokenAddress) {
    return tokenAddress == Addresses.ZERO_ADDRESS
        ? 'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/info/logo.png'
        : "https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/assets/$tokenAddress/logo.png";
  }

  // static ImageProvider getContactImage(
  //   // Transaction transfer,
  //   Contact contact, {
  //   List<Business> businesses = const [],
  // }) {
  //   if (contact?.avatar != null && contact.avatar.isNotEmpty) {
  //     return new MemoryImage(contact.avatar);
  //   } else if (businesses.isNotEmpty) {
  //     String accountAddress =
  //         transfer.type == 'SEND' ? transfer.to : transfer.from;
  //     Business business = businesses.firstWhere(
  //         (business) => business.account == accountAddress,
  //         );
  //     if (business != null) {
  //       return NetworkImage(ImageUrl.getLink(business.metadata.image));
  //     }
  //   }
  //   return new AssetImage('assets/images/anom.png');
  // }

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
    Map<String, String> tokensImages,
  ) {
    final bool hasAvatar =
        contact?.avatar != null && contact!.avatar!.isNotEmpty;
    if (hasAvatar) {
      return new MemoryImage(contact.avatar as Uint8List);
    }
    return action.map(
      createWallet: (value) => AssetImage(
        'assets/images/generate_wallet.png',
      ),
      joinCommunity: (value) =>
          NetworkImage(ImageUrl.getLink(community?.metadata?.image)),
      fiatDeposit: (value) =>
          getTokenByAddress(value.tokenAddress!, tokensImages) != null
              ? NetworkImage(
                  getTokenByAddress(value.tokenAddress, tokensImages) ?? '')
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
