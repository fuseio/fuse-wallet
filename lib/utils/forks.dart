import 'package:flutter_dotenv/flutter_dotenv.dart';

final String supervecinaCommunityAddress =
    '0xbbb854a02766aab8b1716afff26a20fb5b51bfa0';

bool isFork() {
  return DotEnv().env['FORK'] != null && DotEnv().env['FORK'] == 'true';
}

bool isSupervecina(String communityAddress) {
  return communityAddress != null &&
      communityAddress == supervecinaCommunityAddress;
}
