import 'package:flutter_dotenv/flutter_dotenv.dart';

final String foreignNetwork = DotEnv().env['MODE'] == 'production' ? 'mainnet' : 'ropsten';

final String zeroAddress = "0x0000000000000000000000000000000000000000";

final String defaultCommunityAddress = DotEnv().env['DEFAULT_COMMUNITY_CONTRACT_ADDRESS'];

final Map<String, String> funderAddresses = {
  'ropsten': '0xa6c61e75e6008eed7f75b73c84755558764081d1',
  'mainnet': '0x373c383b05c121e541f239afe5fd73c013fed20f'
};

bool isDefaultCommunity(String communityAddress) {
  return (communityAddress != null && defaultCommunityAddress != null) && defaultCommunityAddress.toLowerCase() == communityAddress.toLowerCase();
}
