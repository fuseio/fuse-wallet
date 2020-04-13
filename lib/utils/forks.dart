import 'package:flutter_dotenv/flutter_dotenv.dart';

final String bimCommunityAddress = '0x3132342dfcc632041109eb5854554acf04d352ac';

bool isFork() {
  return DotEnv().env['FORK'] != null && DotEnv().env['FORK'] == 'true';
}

bool isBIM(String communityAddress) {
  return communityAddress != null &&
      communityAddress == bimCommunityAddress;
}
