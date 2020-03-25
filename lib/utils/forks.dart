import 'package:flutter_dotenv/flutter_dotenv.dart';

final String pesoCommuntiyAddress =
    '0xe1f64fb87fc521d8b3a7fc3b175d251dc201bc74';
final String goodDollarCommuntiyAddress =
    '0xea64d7a2ed46898d22cc3183590f75258e763f5d';
final String paywiseCommuntiyAddress =
    '0xd5384b41a0ee6e0b4dbcbe5db448e5acf0fe218b';
final String openMoneyCommuntiyAddress =
    '0x1ea00ed26cf65a4b0038786d1652de72265762b4';
final String wepyCommuntiyAddress =
    '0x3a84e05b3128d87fccb5c5ff3f4d34908981a8d4';
final String localPayCommuntiyAddress =
    '0xeadc097efaf4b9994ef76db86570a79a24a03ae5';

final Map<dynamic, dynamic> goodDollarToken = Map.from({
  "address": "0xf5800134da809c98dc9d2c662a259f6988673925",
  "name": "GoodDollar",
  "decimals": 18,
  "originNetwork": "ropsten",
  "symbol": "GDD"
});

bool isFork() {
  return DotEnv().env['FORK'] != null && DotEnv().env['FORK'] == 'true';
}

bool isForkedBaseCommunityAddress(String communityAddress) {
  return (DotEnv().env['FORK'] != null && DotEnv().env['FORK'] == 'true') ||
      isPaywise(communityAddress) ||
      isWepy(communityAddress) ||
      isOpenMoney(communityAddress) ||
      isGoodDollar(communityAddress);
}

bool isPaywise(String communityAddress) {
  return communityAddress != null &&
      communityAddress == paywiseCommuntiyAddress;
}

bool isPeso(String communityAddress) {
  return communityAddress != null && communityAddress == pesoCommuntiyAddress;
}

bool isLocalPay(String communityAddress) {
  return communityAddress != null && communityAddress == pesoCommuntiyAddress;
}

bool isWepy(String communityAddress) {
  return communityAddress != null && communityAddress == wepyCommuntiyAddress;
}

bool isOpenMoney(String communityAddress) {
  return communityAddress != null &&
      communityAddress == openMoneyCommuntiyAddress;
}

bool isGoodDollar(String communityAddress) {
  return communityAddress != null &&
      communityAddress == goodDollarCommuntiyAddress;
}
