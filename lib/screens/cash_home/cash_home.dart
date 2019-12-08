import 'package:flutter/material.dart';
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

class _CashHomeScreenState extends State<CashHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, CashWalletViewModel>(
        converter: (Store<AppState> store) {
      return CashWalletViewModel.fromStore(store);
    }, onInitialBuild: (viewModel) {
      // if (viewModel.communityAddress == '') {
        viewModel.switchCommunity();
      // }
      // viewModel.startBalanceFetching();
      // viewModel.startTransfersFetching();
    },
    builder: (_, viewModel) {
      return MainScaffold(
        header: CashHeader(),
        children: <Widget>[CashTransactios(viewModel: viewModel)],
      );
    });
  }
}
