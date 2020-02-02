import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
// import 'package:fusecash/screens/send/enable_contacts.dart';
import 'package:fusecash/themes/app_theme.dart';
import 'package:fusecash/themes/custom_theme.dart';
// import 'package:fusecash/utils/contacts.dart';
import 'package:fusecash/utils/forks.dart';
import 'package:fusecash/widgets/main_scaffold2.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'cash_header.dart';
import 'cash_transactions.dart';
import 'package:fusecash/models/views/cash_wallet.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_segment/flutter_segment.dart';

class CashHomeScreen extends StatefulWidget {
  @override
  _CashHomeScreenState createState() => _CashHomeScreenState();
}

void updateTheme(CashWalletViewModel viewModel, Function _changeTheme,
    BuildContext context) {
  String communityAddress = viewModel.communityAddress;
  if (isPaywise(communityAddress)) {
    _changeTheme(context, MyThemeKeys.PAYWISE);
  } else if (isGoodDollar(communityAddress)) {
    _changeTheme(context, MyThemeKeys.GOOD_DOLLAR);
  } else if (isOpenMoney(communityAddress)) {
    _changeTheme(context, MyThemeKeys.OPEN_MONEY);
  } else if (isWepy(communityAddress)) {
    _changeTheme(context, MyThemeKeys.WEPY);
  } else {
    _changeTheme(context, MyThemeKeys.DEFAULT);
  }
}

void enablePushNotifications() async {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  void iosPermission() {
    var firebaseMessaging2 = firebaseMessaging;
    firebaseMessaging2.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  if (Platform.isIOS) iosPermission();
  var token = await firebaseMessaging.getToken();
  logger.wtf("token $token");
  await FlutterSegment.putDeviceToken(token);
  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      logger.wtf('onMessage called: $message');
    },
    onResume: (Map<String, dynamic> message) async {
      logger.wtf('onResume called: $message');
    },
    onLaunch: (Map<String, dynamic> message) async {
      logger.wtf('onLaunch called: $message');
    },
  );
}

void onChange(CashWalletViewModel viewModel, BuildContext context,
    {bool initial = false}) async {
  if (initial) {
    enablePushNotifications();
    viewModel.syncContacts([]);
  }
  if (!viewModel.isJobProcessingStarted) {
    viewModel.startProcessingJobs();
  }
  if (!viewModel.isListeningToBranch) {
    viewModel.listenToBranch();
  }
  if (!viewModel.isCommunityLoading &&
      viewModel.branchAddress != null &&
      viewModel.branchAddress != "" &&
      viewModel.walletAddress != '') {
    viewModel.branchCommunityUpdate();
  }
  if (viewModel.walletStatus == null && viewModel.accountAddress != '') {
    viewModel.createWallet(viewModel.accountAddress);
  }
  if (!viewModel.isCommunityLoading &&
      !viewModel.isCommunityFetched &&
      viewModel.isBranchDataReceived &&
      viewModel.walletAddress != '') {
    viewModel.switchCommunity(viewModel.communityAddress);
  }
  if (viewModel.token != null) {
    // if (!viewModel.isBalanceFetchingStarted) {
    //   viewModel.startBalanceFetching();
    // }
    if (!viewModel.isTransfersFetchingStarted) {
      viewModel.startTransfersFetching();
    }
  }
}

class _CashHomeScreenState extends State<CashHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, CashWalletViewModel>(
        distinct: true,
        converter: CashWalletViewModel.fromStore,
        onInitialBuild: (viewModel) async {
          onChange(viewModel, context, initial: true);
        },
        onWillChange: (viewModel) async {
          updateTheme(viewModel, _changeTheme, context);
          onChange(viewModel, context);
        },
        builder: (_, viewModel) {
          return MainScaffold(
            header: CashHeader(),
            children: <Widget>[CashTransactios(viewModel: viewModel)],
          );
        });
  }
}
