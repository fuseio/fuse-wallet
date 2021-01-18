import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/urls.dart';
import 'package:fusecash/services/apis/explorer.dart';
import 'package:fusecash/utils/onboard/Istrategy.dart';
import 'package:phone_number/phone_number.dart';
import 'package:wallet_core/wallet_core.dart';

final Explorer fuseExplorerApi = Explorer(base: UrlConstants.FUSE_EXPLORER_URL);

final Explorer ethereumExplorerApi = Explorer(
  base: UrlConstants.ETHERSCAN_BASE_URL,
  apiKey: DotEnv().env['ETHERSCAN_API_KEY'],
);

// final Explorer fuseExplorerApi = getIt.get(instanceName: 'FuseExplorer');
// final Explorer ethereumExplorerApi =
//     getIt.get(instanceName: 'EthereumExplorer');

final API api = getIt<API>();

final Graph graph = getIt<Graph>();

final FirebaseAuth firebaseAuth = getIt<FirebaseAuth>();

final PhoneNumberUtil phoneNumberUtil = getIt<PhoneNumberUtil>();

final IOnBoardStrategy onBoardStrategy = getIt<IOnBoardStrategy>();
