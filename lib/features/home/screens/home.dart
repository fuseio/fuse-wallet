import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/redux/actions/cash_wallet_actions.dart';
import 'package:supervecina/redux/viewsmodels/home.dart';
import 'package:supervecina/features/home/widgets/tabs.dart';
import 'package:supervecina/features/home/widgets/header.dart';
import 'package:supervecina/utils/addresses.dart';
import 'package:supervecina/features/shared/widgets/my_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: HomeViewModel.fromStore,
      onInitialBuild: (viewModel) {
        viewModel.onStart();
      },
      onInit: (store) {
        final communities = store.state.cashWalletState.communities;
        if (!communities.containsKey(defaultCommunityAddress.toLowerCase())) {
          store.dispatch(switchCommunityCall(defaultCommunityAddress));
        }
      },
      builder: (_, viewModel) {
        return Scaffold(
          appBar: MyAppBar(
            height: 156,
            backgroundColor: Colors.black,
            child: Header(),
          ),
          body: Tabs(),
        );
      },
    );
  }
}
