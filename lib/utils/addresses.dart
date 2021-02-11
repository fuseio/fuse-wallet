import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/common/di/di.dart';

final String foreignNetwork =
    int.parse(DotEnv().env['FOREIGN_NETWORK_ID']) == 1
        ? 'mainnet'
        : 'ropsten';

bool isDefaultCommunity(String communityAddress) {
  return (communityAddress != null &&
          getIt<String>(instanceName: 'defaultCommunityAddress') != null) &&
      getIt<String>(instanceName: 'defaultCommunityAddress').toLowerCase() ==
          communityAddress.toLowerCase();
}
