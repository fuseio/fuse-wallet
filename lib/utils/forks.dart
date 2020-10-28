import 'package:flutter_dotenv/flutter_dotenv.dart';

final String curaDaiCommunityAddress =
    '0x13a800b0735c377eef9ea3a72d29c87498fb75ab';

bool isFork() {
  return DotEnv().env['FORK'] != null && DotEnv().env['FORK'] == 'true';
}

bool isCuraDAI(String communityAddress) {
  return communityAddress != null &&
      communityAddress == curaDaiCommunityAddress;
}
