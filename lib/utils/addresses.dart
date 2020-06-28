import 'package:flutter_dotenv/flutter_dotenv.dart';

String foreignNetwork = DotEnv().env['MODE'] == 'production' ? 'mainnet' : 'ropsten';

String zeroAddress = "0x0000000000000000000000000000000000000000";

String defaultCommunityAddress = DotEnv().env['DEFAULT_COMMUNITY_CONTRACT_ADDRESS'].toLowerCase();

final String daiTokenAddress = DotEnv().env['DAI_TOKEN'].toLowerCase();

Map<String, String> funderAddresses = {
  'ropsten': '0xa6c61e75e6008eed7f75b73c84755558764081d1',
  'mainnet': '0x373c383b05c121e541f239afe5fd73c013fed20f'
};

