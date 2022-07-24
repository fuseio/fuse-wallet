import 'package:charge_wallet_sdk/charge_wallet_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_number/phone_number.dart';

import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/utils/onboard/base_strategy.dart';

final RootRouter rootRouter = getIt<RootRouter>();

final ChargeApi chargeApi = getIt<ChargeApi>();

final Graph graph = getIt<Graph>();

final FirebaseAuth firebaseAuth = getIt<FirebaseAuth>();

final PhoneNumberUtil phoneNumberUtil = getIt<PhoneNumberUtil>();

final IOnBoardStrategy onBoardStrategy = getIt<IOnBoardStrategy>();
