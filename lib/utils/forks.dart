import 'package:flutter_dotenv/flutter_dotenv.dart';

final String goodDollarCommuntiyAddress = '0x8E704A28e77af8C73EdABC87AF044801e9d1A33e';
final String paywiseCommuntiyAddress = '0xd5384b41a0ee6e0b4dbcbe5db448e5acf0fe218b';

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

bool isPaywise(String communityAddress) {
  return communityAddress != null &&
      communityAddress == paywiseCommuntiyAddress;
}

bool isGoodDollar(String communityAddress) {
  return communityAddress != null &&
      communityAddress == goodDollarCommuntiyAddress;
}