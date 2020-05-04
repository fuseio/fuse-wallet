import 'package:flutter_dotenv/flutter_dotenv.dart';

final String localPayCommuntiyAddress =
    '0xeadc097efaf4b9994ef76db86570a79a24a03ae5';

bool isFork() {
  return DotEnv().env['FORK'] != null && DotEnv().env['FORK'] == 'true';
}

bool isLocalPay(String communityAddress) {
  return communityAddress != null && communityAddress == localPayCommuntiyAddress;
}

