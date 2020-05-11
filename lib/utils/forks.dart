import 'package:flutter_dotenv/flutter_dotenv.dart';

bool isFork() {
  return DotEnv().env['FORK'] != null && DotEnv().env['FORK'] == 'true';
}

final String digitalRandCommuntiyAddress =
    '0xd5384b41a0ee6e0b4dbcbe5db448e5acf0fe218b';

bool isDigitalRand(String communityAddress) {
  return communityAddress != null &&
      communityAddress == digitalRandCommuntiyAddress;
}
