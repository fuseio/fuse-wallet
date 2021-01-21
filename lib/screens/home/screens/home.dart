import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/models/views/home.dart';
import 'package:supervecina/redux/actions/cash_wallet_actions.dart';
import 'package:supervecina/screens/home/widgets/assets_list.dart';
import 'package:supervecina/screens/home/widgets/cash_header.dart';
import 'package:supervecina/screens/home/widgets/feed.dart';
import 'package:supervecina/utils/addresses.dart';
import 'package:supervecina/widgets/my_app_bar.dart';

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
          final body = viewModel.tokens
                      .any((element) => element.originNetwork == null) ||
                  viewModel.communities.length > 1
              ? RefreshIndicator(
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
                                      builder: (BuildContext context) =>
                                          Scaffold(
                                            appBar: MyAppBar(
                                              backgroundColor:
                                                  Theme.of(context).splashColor,
                                              child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 20),
                                                  child: Container(
                                                    color: Theme.of(context)
                                                        .splashColor,
                                                    child: TabBar(
                                                      indicator: BoxDecoration(
                                                          color: Colors.white),
                                                      onTap: (int index) {
                                                        setState(() {});
                                                      },
                                                      unselectedLabelStyle: TextStyle(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .splashColor),
                                                      tabs: tabsTitles
                                                          .asMap()
                                                          .entries
                                                          .map((title) {
                                                        final int index =
                                                            DefaultTabController
                                                                    .of(context)
                                                                .index;
                                                        final bool isSeleceted =
                                                            index != null
                                                                ? title.key ==
                                                                    index
                                                                : false;
                                                        return Chip(
                                                          labelPadding:
                                                              EdgeInsets.only(
                                                                  top: 2,
                                                                  bottom: 2,
                                                                  right: 50,
                                                                  left: 50),
                                                          label:
                                                              Text(title.value),
                                                          shadowColor:
                                                              Theme.of(context)
                                                                  .splashColor,
                                                          backgroundColor: isSeleceted
                                                              ? Color(
                                                                  0xFFF2F2F2)
                                                              : Theme.of(
                                                                      context)
                                                                  .splashColor,
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
                                          )))))))
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
