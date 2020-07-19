import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/home.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/screens/cash_home/feed.dart';
import 'package:fusecash/screens/pro_mode/assets_list.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/widgets/my_app_bar.dart';

final List<String> tabsTitles = ['Feed', 'Wallet'];

class CashHomeScreen extends StatefulWidget {
  CashHomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _CashHomeScreenState createState() => _CashHomeScreenState();
}

class _CashHomeScreenState extends State<CashHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Segment.screen(screenName: '/home-screen');
    return new StoreConnector<AppState, HomeViewModel>(
        converter: HomeViewModel.fromStore,
        onInit: (store) {
          final communities = store.state.cashWalletState.communities;
          String walletStatus = store.state.userState.walletStatus;
          if (walletStatus == 'created' &&
              !communities.containsKey(defaultCommunityAddress)) {
            store.dispatch(switchCommunityCall(defaultCommunityAddress));
          }
        },
        builder: (_, viewModel) {
          if (viewModel.tokens
              .any((element) => element.originNetwork == null)) {
            return DefaultTabController(
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
                                        indicator:
                                            BoxDecoration(color: Colors.white),
                                        onTap: (int index) {
                                          setState(() {});
                                        },
                                        unselectedLabelStyle: TextStyle(
                                            backgroundColor:
                                                Theme.of(context).splashColor),
                                        tabs: tabsTitles
                                            .asMap()
                                            .entries
                                            .map((title) {
                                          final int index =
                                              DefaultTabController.of(context)
                                                  .index;
                                          final bool isSeleceted = index != null
                                              ? title.key == index
                                              : false;
                                          return Chip(
                                            labelPadding: EdgeInsets.only(
                                                top: 2,
                                                bottom: 2,
                                                right: 50,
                                                left: 50),
                                            label: Text(title.value),
                                            shadowColor:
                                                Theme.of(context).splashColor,
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
                                  Feed(withTitle: false),
                                  AssetsList()
                                ],
                              ),
                            ))));
          } else {
            return Feed();
          }
        });
  }
}
