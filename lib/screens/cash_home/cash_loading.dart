import 'package:flutter/material.dart';
import 'package:fusecash/widgets/main_scaffold2.dart';
import 'package:fusecash/models/views/cash_wallet.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CashLoadingScreen extends StatefulWidget {
  @override
  _CashLoadingScreenState createState() => _CashLoadingScreenState();
}

class _CashLoadingScreenState extends State<CashLoadingScreen> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      children: <Widget>[
        new StoreConnector<AppState, CashWalletViewModel>(
          distinct: true,
          converter: (Store<AppState> store) {
            return CashWalletViewModel.fromStore(store);
      }, onWillChange: (viewModel) {
        if (viewModel.walletStatus == 'created') {
        // viewModel.switchCommunity();
          Navigator.popAndPushNamed(context, '/Cash');
        }
      }, onInitialBuild: (viewModel) {
        if (viewModel.walletStatus == null) {
          viewModel.createWallet(viewModel.accountAddress);
        } else if (viewModel.walletStatus == 'created') {
          // viewModel.switchCommunity();
          Navigator.popAndPushNamed(context, '/Cash');
        }
      },builder: (_, viewModel) {
          return Container(
            child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              "Creating a wallet account for user",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              "Joining user to the community",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            )
          )
        ])
      );
      })
      ],
    );
  }
}

