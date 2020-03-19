import 'package:flutter/material.dart';
import 'package:fusecash/models/pro/views/pro_wallet.dart';
import 'package:fusecash/redux/actions/pro_mode_wallet_actions.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/screens/pro_mode/assets_list.dart';
import 'package:redux/redux.dart';

class ProModeHomeScreen extends StatelessWidget {
  onInit(Store<AppState> store) {
    store.dispatch(initWeb3ProMode());
    if (store.state.proWalletState.isListenToTransferEvents == null ||
        store.state.proWalletState.isListenToTransferEvents == false) {
      store.dispatch(startListenToTransferEvents());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ProWalletViewModel>(
        distinct: true,
        converter: ProWalletViewModel.fromStore,
        onInit: onInit,
        builder: (_, viewModel) {
          return Scaffold(
              key: key,
              body: Column(children: <Widget>[
                Expanded(child: ListView(children: [AssetsList()])),
              ]));
        });
  }
}
