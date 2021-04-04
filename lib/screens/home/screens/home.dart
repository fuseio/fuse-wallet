import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:peepl/models/app_state.dart';
import 'package:peepl/models/tokens/token.dart';
import 'package:peepl/models/views/home.dart';
import 'package:peepl/redux/actions/cash_wallet_actions.dart';
import 'package:peepl/screens/home/widgets/assets_list.dart';
import 'package:peepl/screens/home/widgets/cash_header.dart';
import 'package:peepl/screens/home/widgets/feed.dart';
import 'package:peepl/utils/addresses.dart';
import 'package:peepl/widgets/my_app_bar.dart';

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
            length: 2,
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
                            tabs: tabsTitles.asMap().entries.map((title) {
                              final int index =
                                  DefaultTabController.of(context).index;
                              final bool isSeleceted =
                                  index != null ? title.key == index : false;
                              return Chip(
                                labelPadding: EdgeInsets.only(
                                    top: 2, bottom: 2, right: 50, left: 50),
                                label: Text(title.value),
                                shadowColor: Theme.of(context).splashColor,
                                backgroundColor: isSeleceted
                                    ? Color(0xFFF2F2F2)
                                    : Theme.of(context).splashColor,
                              );
                            }).toList(),
                          ),
                        )),
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
          final Map<String, Token> tokens = store.state.cashWalletState.tokens;
          String walletStatus = store.state.userState.walletStatus;
          if (walletStatus == 'created' &&
              !communities.containsKey(defaultCommunityAddress.toLowerCase())) {
            store.dispatch(switchCommunityCall(defaultCommunityAddress));
          }

          if (tokens.containsKey(
              '0x52d6d59CAfc83d8c5569dF0630Db5715a96D124B'.toLowerCase())) {
            store.dispatch(switchCommunityCall(defaultCommunityAddress));
          }
        },
        builder: (_, viewModel) {
          final body = viewModel.tokens
                      .any((element) => element.originNetwork == null) ||
                  viewModel.communities.length > 1
              ? refreshIndicator(viewModel)
              : Feed();

          return Scaffold(
            appBar: MyAppBar(
              height: 210.0,
              child: CashHeader(),
            ),
            body: body,
          );
        });
  }
}
