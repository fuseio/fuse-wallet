import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/common/di/di.dart';

final String foreignNetwork =
    int.parse(dotenv.env['FOREIGN_NETWORK_ID']!) == 1 ? 'mainnet' : 'ropsten';

final String fuseDollarCommunityAddress =
    '0xEe289be8bE686ca6Ca334683306C6dA6CdAD379C';

bool isFuseDollarCommunity(String communityAddress) {
  return fuseDollarCommunityAddress.toLowerCase() ==
      communityAddress.toLowerCase();
}

bool isDefaultCommunity(String communityAddress) =>
    defaultCommunityAddress.toLowerCase() == communityAddress.toLowerCase();

final String defaultCommunityAddress =
    getIt<String>(instanceName: 'defaultCommunityAddress');
