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
import 'package:fusecash/screens/send/receive.dart';
import 'package:fusecash/screens/misc/pincode.dart';
import 'package:fusecash/screens/signup/level_selector.dart';
import 'package:fusecash/screens/cash_home/cash_home.dart';
import 'package:fusecash/screens/cash_home/transaction_details.dart';
import 'package:fusecash/screens/send/send_contact.dart';
import 'package:fusecash/screens/send/send_amount.dart';
import 'package:fusecash/screens/send/send_review.dart';
import 'package:fusecash/screens/send/send_success.dart';
import 'package:fusecash/screens/misc/switch_commmunity.dart';
import 'package:fusecash/screens/buy/buy.dart';
import 'package:fusecash/screens/buy/business.dart';
import 'package:fusecash/screens/signup/recovery.dart';
import 'package:fusecash/screens/backup/show_mnemonic.dart';
import 'package:fusecash/screens/backup/verify_mnemonic.dart';
import 'package:fusecash/screens/backup/done_backup.dart';
import 'package:fusecash/screens/misc/about.dart';
import 'package:fusecash/screens/misc/settings.dart';
import 'package:fusecash/screens/buy/map.dart';
import 'package:fusecash/screens/cash_home/prize.dart';
import 'package:fusecash/screens/cash_home/dai_explained.dart';
import 'package:fusecash/screens/cash_home/webview_page.dart';

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
        return MaterialPageRoute<dynamic>(
          builder: (_) => VerifyScreen(),
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
        return MaterialPageRoute<dynamic>(
          builder: (_) => TransactionDetailsScreen(),
          settings: settings,
        );
      case Router.sendToContactScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SendToContactScreen(),
          settings: settings,
        );
      case Router.sendAmountScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SendAmountScreen(),
          settings: settings,
        );
      case Router.sendReviewScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SendReviewScreen(),
          settings: settings,
        );
      case Router.sendSuccessScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SendSuccessScreen(),
          settings: settings,
        );
      case Router.switchCommunityScreen:
        if (hasInvalidArgs<SwitchCommunityScreenArguments>(args)) {
          return misTypedArgsRoute<SwitchCommunityScreenArguments>(args);
        }
        final typedArgs = args as SwitchCommunityScreenArguments ??
            SwitchCommunityScreenArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) =>
              SwitchCommunityScreen(key: typedArgs.key, title: typedArgs.title),
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
        final typedArgs =
            args as BusinessPageArguments ?? BusinessPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) =>
              BusinessPage(key: typedArgs.key, title: typedArgs.title),
          settings: settings,
        );
      case Router.recoveryPage:
        if (hasInvalidArgs<RecoveryPageArguments>(args)) {
          return misTypedArgsRoute<RecoveryPageArguments>(args);
        }
        final typedArgs =
            args as RecoveryPageArguments ?? RecoveryPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) =>
              RecoveryPage(key: typedArgs.key, title: typedArgs.title),
          settings: settings,
        );
      case Router.showMnemonic:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ShowMnemonic(),
          settings: settings,
        );
      case Router.verifyMnemonic:
        if (hasInvalidArgs<VerifyMnemonicArguments>(args)) {
          return misTypedArgsRoute<VerifyMnemonicArguments>(args);
        }
        final typedArgs =
            args as VerifyMnemonicArguments ?? VerifyMnemonicArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) =>
              VerifyMnemonic(key: typedArgs.key, title: typedArgs.title),
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
        if (hasInvalidArgs<MapScreenArguments>(args)) {
          return misTypedArgsRoute<MapScreenArguments>(args);
        }
        final typedArgs = args as MapScreenArguments ?? MapScreenArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => MapScreen(key: typedArgs.key, title: typedArgs.title),
          settings: settings,
        );
      case Router.prizeScreen:
        if (hasInvalidArgs<PrizeScreenArguments>(args)) {
          return misTypedArgsRoute<PrizeScreenArguments>(args);
        }
        final typedArgs =
            args as PrizeScreenArguments ?? PrizeScreenArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) =>
              PrizeScreen(key: typedArgs.key, title: typedArgs.title),
          settings: settings,
        );
      case Router.daiExplainedScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => DaiExplainedScreen(),
          settings: settings,
        );
      case Router.webViewPage:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return MaterialPageRoute<dynamic>(
          builder: (_) => WebViewPage(key: typedArgs),
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

//SwitchCommunityScreen arguments holder class
class SwitchCommunityScreenArguments {
  final Key key;
  final String title;
  SwitchCommunityScreenArguments({this.key, this.title});
}

//BusinessPage arguments holder class
class BusinessPageArguments {
  final Key key;
  final String title;
  BusinessPageArguments({this.key, this.title});
}

//RecoveryPage arguments holder class
class RecoveryPageArguments {
  final Key key;
  final String title;
  RecoveryPageArguments({this.key, this.title});
}

//VerifyMnemonic arguments holder class
class VerifyMnemonicArguments {
  final Key key;
  final String title;
  VerifyMnemonicArguments({this.key, this.title});
}

//MapScreen arguments holder class
class MapScreenArguments {
  final Key key;
  final String title;
  MapScreenArguments({this.key, this.title});
}

//PrizeScreen arguments holder class
class PrizeScreenArguments {
  final Key key;
  final String title;
  PrizeScreenArguments({this.key, this.title});
}
