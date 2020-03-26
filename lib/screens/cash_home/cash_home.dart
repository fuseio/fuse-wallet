import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:roost/redux/actions/cash_wallet_actions.dart';
import 'package:roost/redux/actions/user_actions.dart';
import 'package:roost/themes/app_theme.dart';
import 'package:roost/utils/contacts.dart';
import 'package:roost/utils/forks.dart';
import 'package:roost/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'cash_transactions.dart';
import 'package:roost/models/views/cash_wallet.dart';

void updateTheme(
    String communityAddress, Function _changeTheme, BuildContext context) {
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

void onChange(CashWalletViewModel viewModel, BuildContext context) async {
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
  if (!viewModel.isCommunityLoading &&
      !viewModel.isCommunityFetched &&
      viewModel.isBranchDataReceived &&
      viewModel.walletAddress != '') {
    viewModel.switchCommunity(viewModel.communityAddress);
  }
  if (viewModel.token != null) {
    if (!viewModel.isTransfersFetchingStarted) {
      viewModel.startTransfersFetching();
    }
  }
  if (viewModel.identifier == null) {
    viewModel.setIdentifier();
  }
}

class CashHomeScreen extends StatelessWidget {
  onInit(store) async {
    Segment.screen(screenName: '/cash-home-screen');
    String walletStatus = store.state.cashWalletState.walletStatus;
    String accountAddress = store.state.userState.accountAddress;
    if (walletStatus != 'deploying' &&
        walletStatus != 'created' &&
        accountAddress != '') {
      store.dispatch(createAccountWalletCall(accountAddress));
    }
    bool isPermitted = await Contacts.checkPermissions();
    if (isPermitted) {
      List<Contact> contacts = await ContactController.getContacts();
      store.dispatch(syncContactsCall(contacts));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, CashWalletViewModel>(
        distinct: true,
        converter: CashWalletViewModel.fromStore,
        onInit: onInit,
        onInitialBuild: (viewModel) async {
          onChange(viewModel, context);
        },
        onWillChange: (prevVm, nextVm) async {
          onChange(nextVm, context);
        },
        builder: (_, viewModel) {
          return Scaffold(
              key: key,
              body: Column(children: <Widget>[
                Expanded(
                    child: ListView(children: <Widget>[
                  CashTransactios(viewModel: viewModel)
                ])),
              ]));
        });
  }
}
