import 'package:esol/screens/home/widgets/cash_header.dart';
import 'package:esol/screens/home/widgets/detect_face.dart';
import 'package:esol/screens/home/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:esol/models/app_state.dart';
import 'package:esol/models/views/home.dart';
import 'package:esol/redux/actions/cash_wallet_actions.dart';
import 'package:esol/screens/home/widgets/assets_list.dart';
import 'package:esol/screens/home/widgets/feed.dart';
import 'package:esol/utils/addresses.dart';
import 'package:esol/widgets/my_app_bar.dart';

final List<String> tabsTitles = ['Feed', 'Wallet'];

class MainHomeScreen extends StatefulWidget {
  MainHomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, HomeViewModel>(
        converter: HomeViewModel.fromStore,
        onInitialBuild: (viewModel) {
          viewModel.onReceiveBranchData(true);
        },
        onWillChange: (previousViewModel, newViewModel) {
          newViewModel.onReceiveBranchData(false);
        },
        onInit: (store) {
          final communities = store.state.cashWalletState.communities;
          String walletStatus = store.state.userState.walletStatus;
          if (walletStatus == 'created' &&
              !communities.containsKey(defaultCommunityAddress.toLowerCase())) {
            store.dispatch(switchCommunityCall(defaultCommunityAddress));
          }
        },
        builder: (_, viewModel) {
          final Widget body = viewModel.tokens
                      .any((element) => element.originNetwork == null) ||
                  viewModel.communities.length > 1
              ? Tabs()
              : !viewModel.isFaceVerified
                  ? Feed()
                  : DetectFace();

          return Scaffold(
            appBar: MyAppBar(
              height: MediaQuery.of(context).size.height * 0.2,
              child: CashHeader(),
            ),
            body: body,
          );
        });
  }
}
