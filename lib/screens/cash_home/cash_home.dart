import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:local_champions/redux/actions/cash_wallet_actions.dart';
import 'package:local_champions/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'cash_transactions.dart';
import 'package:local_champions/models/views/cash_wallet.dart';

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
  onInit(Store<AppState> store) async {
    Segment.screen(screenName: '/cash-home-screen');
    String walletStatus = store.state.cashWalletState.walletStatus;
    String accountAddress = store.state.userState.accountAddress;
    if (walletStatus != 'deploying' &&
        walletStatus != 'created' &&
        accountAddress != '') {
      store.dispatch(createAccountWalletCall(accountAddress));
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
        onWillChange: (prevViewModel, nextViewModel) async {
          onChange(nextViewModel, context);
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
