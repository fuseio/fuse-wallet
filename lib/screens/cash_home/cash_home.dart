import 'package:flutter/material.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/screens/send/enable_contacts.dart';
import 'package:fusecash/widgets/main_scaffold2.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'cash_header.dart';
import 'cash_transactions.dart';
import 'package:fusecash/models/views/cash_wallet.dart';

class CashHomeScreen extends StatefulWidget {
  @override
  _CashHomeScreenState createState() => _CashHomeScreenState();
}

void showAlert(BuildContext context) {
  showDialog(child: new ContactsConfirmationScreen(), context: context);
}

void onChange(CashWalletViewModel viewModel, BuildContext context) {
  if (!viewModel.isListeningToBranch && !viewModel.isCommunityLoading) {
    viewModel.listenToBranch();
  }
  if (!viewModel.isCommunityLoading &&
      viewModel.branchAddress != null &&
      viewModel.branchAddress != "") {
    viewModel.branchCommunityUpdate();
  }
  if (viewModel.walletStatus == null && viewModel.accountAddress != '') {
    viewModel.createWallet(viewModel.accountAddress);
  }
  if (!viewModel.isCommunityLoading &&
      !viewModel.isCommunityFetched &&
      viewModel.isListeningToBranch &&
      viewModel.walletAddress != '') {
    viewModel.switchCommunity(viewModel.communityAddress);
    if (!viewModel.isContactsSynced) {
      Future.delayed(Duration.zero, () => showAlert(context));
    }
  }
  if (viewModel.token != null) {
    if (!viewModel.isBalanceFetchingStarted) {
      viewModel.startBalanceFetching();
    }
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

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, CashWalletViewModel>(
        distinct: true,
        converter: (Store<AppState> store) {
          return CashWalletViewModel.fromStore(store);
        },
        onInitialBuild: (viewModel) {
          onChange(viewModel, context);
        },
        onWillChange: (viewModel) {
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
