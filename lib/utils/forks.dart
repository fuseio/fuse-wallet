import 'package:flutter_dotenv/flutter_dotenv.dart';

final String wikBankCommunityAddress =
    '0x60235b86f5acea7146a311eb77873be6d0189b7c';

bool isFork() {
  return DotEnv().env['FORK'] != null && DotEnv().env['FORK'] == 'true';
}

bool isWikiBank(String communityAddress) {
  return communityAddress != null &&
      communityAddress == wikBankCommunityAddress;
}
