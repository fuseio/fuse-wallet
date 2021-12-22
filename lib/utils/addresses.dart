import 'package:flutter_dotenv/flutter_dotenv.dart';

bool isFuseDollarCommunity(String communityAddress) {
  return defaultCommunityAddress.toLowerCase() ==
      communityAddress.toLowerCase();
}

bool isDefaultCommunity(String communityAddress) =>
    defaultCommunityAddress.toLowerCase() == communityAddress.toLowerCase();

final String defaultCommunityAddress =
    dotenv.env['DEFAULT_COMMUNITY_CONTRACT_ADDRESS']!;
