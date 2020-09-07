import 'package:flutter_dotenv/flutter_dotenv.dart';

final String wikBankCommunityAddress =
    '0xff4e4b6283db9e1d4690160a0cf740736e2b3ee8';

bool isFork() {
  return DotEnv().env['FORK'] != null && DotEnv().env['FORK'] == 'true';
}

bool isWikiBank(String communityAddress) {
  return communityAddress != null &&
      communityAddress == wikBankCommunityAddress;
}
