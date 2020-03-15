import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:paywise/redux/actions/cash_wallet_actions.dart';
import 'package:paywise/redux/actions/user_actions.dart';
import 'package:paywise/utils/contacts.dart';
import 'package:paywise/widgets/main_scaffold2.dart';
import 'package:paywise/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'cash_header.dart';
import 'cash_transactions.dart';
import 'package:paywise/models/views/cash_wallet.dart';

class CashHomeScreen extends StatelessWidget {
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

  onChange(CashWalletViewModel viewModel) async {
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
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, CashWalletViewModel>(
        distinct: true,
        converter: CashWalletViewModel.fromStore,
        onInit: onInit,
        onInitialBuild: onChange,
        onWillChange: (prevViewModel, nextViewModel) async {
          onChange(nextViewModel);
        },
        builder: (_, viewModel) {
          bool isWalletCreated = 'created' == viewModel.walletStatus;
          return MainScaffold(
              showFooter: isWalletCreated,
              header: CashHeader(),
              children: <Widget>[CashTransactios(viewModel: viewModel)]);
        });
  }
}
