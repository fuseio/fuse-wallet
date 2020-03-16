import 'package:flutter/material.dart';
import 'package:fusecash/models/pro/views/pro_wallet.dart';
import 'package:fusecash/redux/actions/pro_mode_wallet_actions.dart';
import 'package:fusecash/screens/pro_mode/pro_header.dart';
import 'package:fusecash/screens/pro_mode/pro_mode_main_scaffold.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/screens/pro_mode/pro_transactios.dart';
import 'package:redux/redux.dart';

class ProModeHomeScreen extends StatelessWidget {
  onInit(Store<AppState> store) {
    store.dispatch(initWeb3ProMode());
    if (store.state.proWalletState.isListenToTransferEvents == null || store.state.proWalletState.isListenToTransferEvents == false) {
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
          return MainScaffold(
              isProMode: true,
              showFooter: true,
              header: ProHeader(),
              children: <Widget>[ProTransactios(viewModel: viewModel,)]);
        });
  }
}
