// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fusecash/screens/splash/splash.dart';
import 'package:fusecash/screens/signup/signup.dart';
import 'package:fusecash/screens/signup/verify.dart';
import 'package:fusecash/screens/signup/username.dart';
import 'package:fusecash/screens/misc/pincode.dart';
import 'package:fusecash/screens/cash_home/cash_mode.dart';
import 'package:fusecash/screens/cash_home/transaction_details.dart';
import 'package:fusecash/screens/send/send_amount.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';
import 'package:fusecash/screens/send/send_review.dart';
import 'package:fusecash/screens/send/send_success.dart';
import 'package:fusecash/screens/buy/business.dart';
import 'package:fusecash/screens/signup/recovery.dart';
import 'package:fusecash/screens/buy/map.dart';
import 'package:fusecash/screens/cash_home/prize.dart';
import 'package:fusecash/screens/cash_home/webview_page.dart';

class Router {
  static const splashScreen = '/splash-screen';
  static const signupScreen = '/signup-screen';
  static const verifyScreen = '/verify-screen';
  static const userNameScreen = '/user-name-screen';
  static const pincodeScreen = '/pincode-screen';
  static const cashHomeScreen = '/cash-home-screen';
  static const transactionDetailsScreen = '/transaction-details-screen';
  static const sendAmountScreen = '/send-amount-screen';
  static const sendReviewScreen = '/send-review-screen';
  static const sendSuccessScreen = '/send-success-screen';
  static const businessPage = '/business-page';
  static const recoveryPage = '/recovery-page';
  static const mapScreen = '/map-screen';
  static const prizeScreen = '/prize-screen';
  static const webViewPage = '/web-view-page';
  static final navigator = ExtendedNavigator();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
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
      case Router.pincodeScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => PincodeScreen(),
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
              key: typedArgs.key, tabIndex: typedArgs.tabIndex),
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
      case Router.sendAmountScreen:
        if (hasInvalidArgs<SendAmountArguments>(args)) {
          return misTypedArgsRoute<SendAmountArguments>(args);
        }
        final typedArgs = args as SendAmountArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => SendAmountScreen(pageArgs: typedArgs),
          settings: settings,
        );
      case Router.sendReviewScreen:
        if (hasInvalidArgs<SendAmountArguments>(args)) {
          return misTypedArgsRoute<SendAmountArguments>(args);
        }
        final typedArgs = args as SendAmountArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => SendReviewScreen(pageArgs: typedArgs),
          settings: settings,
        );
      case Router.sendSuccessScreen:
        if (hasInvalidArgs<SendAmountArguments>(args)) {
          return misTypedArgsRoute<SendAmountArguments>(args);
        }
        final typedArgs = args as SendAmountArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => SendSuccessScreen(pageArgs: typedArgs),
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
      case Router.mapScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => MapScreen(),
          settings: settings,
        );
      case Router.prizeScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => PrizeScreen(),
          settings: settings,
        );
      case Router.webViewPage:
        if (hasInvalidArgs<WebViewPageArguments>(args)) {
          return misTypedArgsRoute<WebViewPageArguments>(args);
        }
        final typedArgs = args as WebViewPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => WebViewPage(pageArgs: typedArgs),
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
  CashModeScaffoldArguments({this.key, this.tabIndex = 0});
}
