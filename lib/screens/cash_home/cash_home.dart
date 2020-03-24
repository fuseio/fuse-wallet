import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:localdollarmx/redux/actions/cash_wallet_actions.dart';
import 'package:localdollarmx/redux/actions/user_actions.dart';
import 'package:localdollarmx/themes/app_theme.dart';
import 'package:localdollarmx/themes/custom_theme.dart';
import 'package:localdollarmx/utils/contacts.dart';
import 'package:localdollarmx/utils/forks.dart';
import 'package:localdollarmx/widgets/main_scaffold2.dart';
import 'package:localdollarmx/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'cash_header.dart';
import 'cash_transactions.dart';
import 'package:localdollarmx/models/views/cash_wallet.dart';

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
  void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  onInit(store) async {
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
          updateTheme(viewModel.communityAddress, _changeTheme, context);
        },
        onWillChange: (prevViewModel, nextViewModel) async {
          onChange(nextViewModel, context);
        },
        builder: (_, viewModel) {
          return MainScaffold(
              showFooter: true,
              header: CashHeader(),
              children: <Widget>[CashTransactios(viewModel: viewModel)]);
        });
  }
}
