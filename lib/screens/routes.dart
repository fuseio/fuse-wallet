import 'package:auto_route/auto_route_annotations.dart';
import 'package:BIM/screens/buy/business.dart';
import 'package:BIM/screens/buy/map.dart';
import 'package:BIM/screens/cash_home/cash_mode.dart';
import 'package:BIM/screens/cash_home/prize.dart';
import 'package:BIM/screens/cash_home/transaction_details.dart';
import 'package:BIM/screens/signup/recovery.dart';
import 'package:BIM/screens/signup/username.dart';
import 'package:BIM/screens/signup/signup.dart';
import 'package:BIM/screens/signup/verify.dart';
import 'package:BIM/screens/splash/splash.dart';
import 'package:BIM/screens/misc/pincode.dart';

@MaterialAutoRouter()
class $Router {
  SplashScreen splashScreen;
  SignupScreen signupScreen;
  VerifyScreen verifyScreen;
  UserNameScreen userNameScreen;
  PincodeScreen pincodeScreen;
  @initial
  CashModeScaffold cashHomeScreen;
  TransactionDetailsScreen transactionDetailsScreen;
  BusinessPage businessPage;
  RecoveryPage recoveryPage;
  MapScreen mapScreen;
  PrizeScreen prizeScreen;
}
