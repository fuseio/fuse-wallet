import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/features/home/widgets/deposit_banner.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/viewsmodels/home.dart';
import 'package:fusecash/features/home/widgets/assets_list.dart';
import 'package:fusecash/features/home/widgets/cash_header.dart';
import 'package:fusecash/features/home/widgets/feed.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/widgets/my_app_bar.dart';

final List<String> tabsTitles = ['Feed', 'Wallet'];

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  RefreshIndicator refreshIndicator(viewModel) {
    return RefreshIndicator(
      onRefresh: () async {
        viewModel.refreshFeed();
        await Future.delayed(Duration(milliseconds: 1000));
        return 'success';
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * .65,
          child: DefaultTabController(
            length: tabsTitles.length,
            initialIndex: 0,
            child: Container(
              child: Builder(
                builder: (BuildContext context) => Scaffold(
                  appBar: MyAppBar(
                    backgroundColor: Theme.of(context).splashColor,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                        color: Theme.of(context).splashColor,
                        child: TabBar(
                          indicator: BoxDecoration(color: Colors.white),
                          onTap: (int index) {
                            setState(() {});
                          },
                          unselectedLabelStyle: TextStyle(
                              backgroundColor: Theme.of(context).splashColor),
                          tabs: tabsTitles.asMap().entries.map(
                            (title) {
                              final int index =
                                  DefaultTabController.of(context).index ?? 0;
                              final bool isSeleceted = title.key == index;
                              return Chip(
                                labelPadding: EdgeInsets.only(
                                  top: 2,
                                  bottom: 2,
                                  right: 50,
                                  left: 50,
                                ),
                                label: Text(title.value),
                                shadowColor: Theme.of(context).splashColor,
                                backgroundColor: isSeleceted
                                    ? Color(0xFFF2F2F2)
                                    : Theme.of(context).splashColor,
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      Feed(
                        withTitle: false,
                      ),
                      AssetsList()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
        return Scaffold(
          appBar: MyAppBar(
            height: 210.0,
            backgroundColor: Colors.white,
            child: CashHeader(),
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              viewModel.showTabs ? refreshIndicator(viewModel) : Feed(),
              viewModel.showDepositBanner
                  ? Positioned(
                      bottom: 15,
                      width: MediaQuery.of(context).size.width * .95,
                      child: DepositBanner(),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
