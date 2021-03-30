import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/urls.dart';
import 'package:fusecash/services/apis/explorer.dart';
import 'package:fusecash/services/apis/swap.dart';
import 'package:fusecash/utils/onboard/Istrategy.dart';
import 'package:phone_number/phone_number.dart';
import 'package:wallet_core/wallet_core.dart';

Web3 fuseWeb3;
Web3 ethereumWeb3;

final Explorer fuseExplorerApi = getIt<Explorer>(
  param1: UrlConstants.FUSE_EXPLORER_URL,
);

final Explorer ethereumExplorerApi = getIt<Explorer>(
  param1: UrlConstants.FUSE_EXPLORER_URL,
  param2: env['ETHERSCAN_API_KEY'],
);

final API api = getIt<API>();

final SwapService swapService = getIt<SwapService>();

final Graph graph = getIt<Graph>();

final FirebaseAuth firebaseAuth = getIt<FirebaseAuth>();

final PhoneNumberUtil phoneNumberUtil = getIt<PhoneNumberUtil>();

final IOnBoardStrategy onBoardStrategy = getIt<IOnBoardStrategy>();
