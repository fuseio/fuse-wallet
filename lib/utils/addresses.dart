import 'package:flutter_dotenv/flutter_dotenv.dart';

final String foreignNetwork =
    int.parse(DotEnv().env['FOREIGN_PROVIDER_URL']) == 1
        ? 'mainnet'
        : 'ropsten';

bool isDefaultCommunity(String communityAddress) {
  return (communityAddress != null &&
          DotEnv().env['DEFAULT_COMMUNITY_CONTRACT_ADDRESS'] != null) &&
      DotEnv().env['DEFAULT_COMMUNITY_CONTRACT_ADDRESS'].toLowerCase() ==
          communityAddress.toLowerCase();
}
