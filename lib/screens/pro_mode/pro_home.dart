import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:digitalrand/models/pro/views/pro_wallet.dart';
import 'package:digitalrand/redux/actions/pro_mode_wallet_actions.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:digitalrand/screens/pro_mode/assets_list.dart';
import 'package:redux/redux.dart';

class ProModeHomeScreen extends StatelessWidget {
  onInit(Store<AppState> store) async {
    Segment.screen(screenName: '/pro-home-screen');
    store.dispatch(getEtherBalabnce());
    store.dispatch(getBalancesOnForeign());
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
