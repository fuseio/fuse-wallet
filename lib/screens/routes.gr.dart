// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:digitalrand/screens/misc/lock_screen.dart';
import 'package:redux/redux.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/screens/backup/show_mnemonic.dart';
import 'package:digitalrand/screens/misc/security.dart';
import 'package:digitalrand/screens/misc/pincode_colored.dart';
import 'package:digitalrand/screens/splash/splash.dart';
import 'package:digitalrand/screens/signup/signup.dart';
import 'package:digitalrand/screens/signup/verify.dart';
import 'package:digitalrand/screens/signup/username.dart';
import 'package:digitalrand/screens/cash_home/cash_mode.dart';
import 'package:digitalrand/models/tokens/token.dart';
import 'package:digitalrand/screens/cash_home/transaction_details.dart';
import 'package:digitalrand/screens/buy/business.dart';
import 'package:digitalrand/screens/signup/recovery.dart';

class Router {
  static const lockScreen = '/';
  static const backupScreen = '/backup-screen';
  static const securityScreen = '/security-screen';
  static const pincode = '/pincode';
  static const splashScreen = '/splash-screen';
  static const signupScreen = '/signup-screen';
  static const verifyScreen = '/verify-screen';
  static const userNameScreen = '/user-name-screen';
  static const cashHomeScreen = '/cash-home-screen';
  static const transactionDetailsScreen = '/transaction-details-screen';
  static const businessPage = '/business-page';
  static const recoveryPage = '/recovery-page';
  static final navigator = ExtendedNavigator();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.lockScreen:
        if (hasInvalidArgs<Store<AppState>>(args)) {
          return misTypedArgsRoute<Store<AppState>>(args);
        }
        final typedArgs = args as Store<AppState>;
        return MaterialPageRoute<dynamic>(
          builder: (_) => LockScreen(store: typedArgs),
          settings: settings,
        );
      case Router.backupScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ShowMnemonic(),
          settings: settings,
        );
      case Router.securityScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SecurityScreen(),
          settings: settings,
        );
      case Router.pincode:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ColorsPincodeScreen(),
          settings: settings,
        );
      case Router.splashScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SplashScreen(),
          settings: settings,
        );
      case Router.signupScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignupScreen(),
          settings: settings,
        );
      case Router.verifyScreen:
        if (hasInvalidArgs<VerifyScreenArguments>(args)) {
          return misTypedArgsRoute<VerifyScreenArguments>(args);
        }
        final typedArgs = args as VerifyScreenArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => VerifyScreen(pageArgs: typedArgs),
          settings: settings,
        );
      case Router.userNameScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => UserNameScreen(),
          settings: settings,
        );
      case Router.cashHomeScreen:
        if (hasInvalidArgs<CashModeScaffoldArguments>(args)) {
          return misTypedArgsRoute<CashModeScaffoldArguments>(args);
        }
        final typedArgs =
            args as CashModeScaffoldArguments ?? CashModeScaffoldArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => CashModeScaffold(
              key: typedArgs.key,
              tabIndex: typedArgs.tabIndex,
              primaryToken: typedArgs.primaryToken),
          settings: settings,
        );
      case Router.transactionDetailsScreen:
        if (hasInvalidArgs<TransactionDetailArguments>(args)) {
          return misTypedArgsRoute<TransactionDetailArguments>(args);
        }
        final typedArgs = args as TransactionDetailArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => TransactionDetailsScreen(pageArgs: typedArgs),
          settings: settings,
        );
      case Router.businessPage:
        if (hasInvalidArgs<BusinessPageArguments>(args)) {
          return misTypedArgsRoute<BusinessPageArguments>(args);
        }
        final typedArgs = args as BusinessPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => BusinessPage(pageArgs: typedArgs),
          settings: settings,
        );
      case Router.recoveryPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => RecoveryPage(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//CashModeScaffold arguments holder class
class CashModeScaffoldArguments {
  final Key key;
  final int tabIndex;
  final Token primaryToken;
  CashModeScaffoldArguments({this.key, this.tabIndex = 0, this.primaryToken});
}
