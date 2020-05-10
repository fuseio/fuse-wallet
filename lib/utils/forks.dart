import 'package:flutter_dotenv/flutter_dotenv.dart';

final String paywiseCommuntiyAddress = '0xd5384b41a0ee6e0b4dbcbe5db448e5acf0fe218b';

bool isFork() {
  return DotEnv().env['FORK'] != null && DotEnv().env['FORK'] == 'true';
}

bool isPaywise(String communityAddress) {
  return communityAddress != null &&
      communityAddress == paywiseCommuntiyAddress;
}
