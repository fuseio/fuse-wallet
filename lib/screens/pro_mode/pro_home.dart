import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:localpay/models/pro/views/pro_wallet.dart';
import 'package:localpay/redux/actions/pro_mode_wallet_actions.dart';
import 'package:localpay/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localpay/screens/pro_mode/assets_list.dart';
import 'package:redux/redux.dart';

class ProModeHomeScreen extends StatelessWidget {
  onInit(Store<AppState> store) async {
    Segment.screen(screenName: '/pro-home-screen');
    store.dispatch(getAddressBalances());
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ProWalletViewModel>(
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
