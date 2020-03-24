// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:localdollarmx/screens/splash/splash.dart';
import 'package:localdollarmx/screens/signup/signup.dart';
import 'package:localdollarmx/screens/signup/verify.dart';
import 'package:localdollarmx/screens/signup/username.dart';
import 'package:localdollarmx/screens/send/receive.dart';
import 'package:localdollarmx/screens/misc/pincode.dart';
import 'package:localdollarmx/screens/signup/level_selector.dart';
import 'package:localdollarmx/screens/cash_home/cash_home.dart';
import 'package:localdollarmx/screens/cash_home/transaction_details.dart';
import 'package:localdollarmx/screens/send/send_contact.dart';
import 'package:localdollarmx/screens/send/send_amount.dart';
import 'package:localdollarmx/screens/send/send_amount_arguments.dart';
import 'package:localdollarmx/screens/send/send_review.dart';
import 'package:localdollarmx/screens/send/send_success.dart';
import 'package:localdollarmx/screens/misc/switch_commmunity.dart';
import 'package:localdollarmx/screens/buy/buy.dart';
import 'package:localdollarmx/screens/buy/business.dart';
import 'package:localdollarmx/screens/signup/recovery.dart';
import 'package:localdollarmx/screens/backup/show_mnemonic.dart';
import 'package:localdollarmx/screens/backup/verify_mnemonic.dart';
import 'package:localdollarmx/screens/backup/done_backup.dart';
import 'package:localdollarmx/screens/misc/about.dart';
import 'package:localdollarmx/screens/misc/settings.dart';
import 'package:localdollarmx/screens/buy/map.dart';
import 'package:localdollarmx/screens/cash_home/prize.dart';
import 'package:localdollarmx/screens/cash_home/dai_explained.dart';
import 'package:localdollarmx/screens/cash_home/webview_page.dart';

class Router {
  static const splashScreen = '/';
  static const signupScreen = '/signup-screen';
  static const verifyScreen = '/verify-screen';
  static const userNameScreen = '/user-name-screen';
  static const receiveScreen = '/receive-screen';
  static const pincodeScreen = '/pincode-screen';
  static const levelSelectorScreen = '/level-selector-screen';
  static const cashHomeScreen = '/cash-home-screen';
  static const transactionDetailsScreen = '/transaction-details-screen';
  static const sendToContactScreen = '/send-to-contact-screen';
  static const sendAmountScreen = '/send-amount-screen';
  static const sendReviewScreen = '/send-review-screen';
  static const sendSuccessScreen = '/send-success-screen';
  static const switchCommunityScreen = '/switch-community-screen';
  static const buyScreen = '/buy-screen';
  static const businessPage = '/business-page';
  static const recoveryPage = '/recovery-page';
  static const showMnemonic = '/show-mnemonic';
  static const verifyMnemonic = '/verify-mnemonic';
  static const doneBackup = '/done-backup';
  static const aboutScreen = '/about-screen';
  static const settingsScreen = '/settings-screen';
  static const mapScreen = '/map-screen';
  static const prizeScreen = '/prize-screen';
  static const daiExplainedScreen = '/dai-explained-screen';
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
      case Router.receiveScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ReceiveScreen(),
          settings: settings,
        );
      case Router.pincodeScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => PincodeScreen(),
          settings: settings,
        );
      case Router.levelSelectorScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => LevelSelectorScreen(),
          settings: settings,
        );
      case Router.cashHomeScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => CashHomeScreen(),
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
      case Router.sendToContactScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SendToContactScreen(),
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
      case Router.switchCommunityScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SwitchCommunityScreen(),
          settings: settings,
        );
      case Router.buyScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => BuyScreen(),
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
      case Router.showMnemonic:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ShowMnemonic(),
          settings: settings,
        );
      case Router.verifyMnemonic:
        return MaterialPageRoute<dynamic>(
          builder: (_) => VerifyMnemonic(),
          settings: settings,
        );
      case Router.doneBackup:
        return MaterialPageRoute<dynamic>(
          builder: (_) => DoneBackup(),
          settings: settings,
        );
      case Router.aboutScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => AboutScreen(),
          settings: settings,
        );
      case Router.settingsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SettingsScreen(),
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
      case Router.daiExplainedScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => DaiExplainedScreen(),
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
