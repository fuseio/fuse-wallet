import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/common/di/di.dart';

final String foreignNetwork =
    int.parse(dotenv.env['FOREIGN_NETWORK_ID']!) == 1 ? 'mainnet' : 'ropsten';

bool isCuraDAI(String communityAddress) {
  return defaultCommunityAddress.toLowerCase() ==
      communityAddress.toLowerCase();
}

final String defaultCommunityAddress =
    getIt<String>(instanceName: 'defaultCommunityAddress');
