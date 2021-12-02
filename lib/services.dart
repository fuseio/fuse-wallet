import 'package:firebase_auth/firebase_auth.dart';
import 'package:supervecina/common/di/di.dart';
import 'package:supervecina/common/router/routes.gr.dart';
import 'package:supervecina/constants/urls.dart';
import 'package:supervecina/services/apis/explorer.dart';
import 'package:supervecina/services/apis/fuseswap.dart';
import 'package:supervecina/utils/onboard/Istrategy.dart';
import 'package:phone_number/phone_number.dart';
import 'package:wallet_core/wallet_core.dart';

final RootRouter rootRouter = getIt<RootRouter>();

final API api = getIt<API>();

final Explorer fuseExplorerApi = getIt<Explorer>(
  param1: UrlConstants.fuseExplorerApi,
);

final WalletApi walletApi = getIt<WalletApi>();

final Graph graph = getIt<Graph>();

final FirebaseAuth firebaseAuth = getIt<FirebaseAuth>();

final FuseSwapService fuseSwapService = getIt<FuseSwapService>();

final PhoneNumberUtil phoneNumberUtil = getIt<PhoneNumberUtil>();

final IOnBoardStrategy onBoardStrategy = getIt<IOnBoardStrategy>();
