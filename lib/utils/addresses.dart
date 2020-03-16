import 'package:flutter_dotenv/flutter_dotenv.dart';

String defaultCommunityAddress = DotEnv().env['DEFAULT_COMMUNITY_CONTRACT_ADDRESS'].toLowerCase();

final String daiTokenAddress = '0x6b175474e89094c44da98b954eedeac495271d0f';

Map<String, String> funderAddresses = {
  'ropsten': '0xa6c61e75e6008eed7f75b73c84755558764081d1',
  'mainnet': '0x373c383b05c121e541f239afe5fd73c013fed20f'
};

bool isDefaultCommunity(String communityAddress) {
  return defaultCommunityAddress != null && defaultCommunityAddress == communityAddress.toLowerCase();
}
