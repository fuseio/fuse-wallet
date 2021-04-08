import 'package:flutter_dotenv/flutter_dotenv.dart';

final String foreignNetwork =
    DotEnv().env['MODE'] == 'production' ? 'mainnet' : 'ropsten';

final String zeroAddress = "0x0000000000000000000000000000000000000000";

final String rewardAddress = "0x29249e06e8D3e4933cc403AB73136e698a08c38b";

final String defaultCommunityAddress =
    DotEnv().env['DEFAULT_COMMUNITY_CONTRACT_ADDRESS'];

final Map<String, String> funderAddresses = {
  'ropsten': '0xa6c61e75e6008eed7f75b73c84755558764081d1',
  'mainnet': '0x373c383b05c121e541f239afe5fd73c013fed20f'
};

String feeReceiverAddress = '0x77D886e98133D99130179bdb41CE052a43d32c2F';

bool isDefaultCommunity(String communityAddress) {
  return (communityAddress != null && defaultCommunityAddress != null) &&
      defaultCommunityAddress.toLowerCase() == communityAddress.toLowerCase();
}
