import 'dart:typed_data';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/constants/addresses.dart';
import 'package:fusecash/models/actions/wallet_action.dart';

class ImageUrl {
  static bool _isS3Hash(String hash) => hash.length == 64;

  static String getLink(String? hash) {
    if (hash == null) {
      return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
    }

    if (_isS3Hash(hash)) {
      return getS3ImageUrl(hash);
    }
    return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
  }

  static ImageProvider getContactImage(
    Contact? contact,
  ) {
    if (contact?.avatar != null) {
      return MemoryImage(contact?.avatar as Uint8List);
    }
    return const AssetImage('assets/images/anom.png');
  }

  static String getS3ImageUrl(String? image) {
    if (image == null) {
      return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
    }
    return '${dotenv.env['FUSE_S3_BUCKET']}/$image';
  }

  static String getTokenUrl(tokenAddress) {
    return tokenAddress == Addresses.zeroAddress ||
            tokenAddress == Addresses.nativeTokenAddress
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
    String? accountAddress,
    Map<String, String> tokensImages,
  ) {
    final bool hasAvatar =
        contact?.avatar != null && contact!.avatar!.isNotEmpty;
    if (hasAvatar) {
      return MemoryImage(contact.avatar as Uint8List);
    }
    return action.map(
      receiveNFT: (value) => const AssetImage(
        'assets/images/recieve.png',
      ),
      createWallet: (value) => const AssetImage(
        'assets/images/generate_wallet.png',
      ),
      fiatDeposit: (value) => const AssetImage(
        'assets/images/deposit.png',
      ),
      bonus: (value) => const AssetImage(
        'assets/images/referral_bonus.png',
      ),
      send: (value) => const AssetImage('assets/images/send.png'),
      receive: (value) => const AssetImage('assets/images/recieve.png'),
      swap: (value) => const AssetImage('assets/images/swap_logo.png'),
    );
  }
}
