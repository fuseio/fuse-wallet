import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/features/home/widgets/deposit_banner.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/viewsmodels/home.dart';
import 'package:fusecash/features/home/widgets/assets_list.dart';
import 'package:fusecash/features/home/widgets/cash_header.dart';
import 'package:fusecash/features/home/widgets/feed.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/widgets/my_app_bar.dart';

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

  Widget body() {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Theme.of(context).canvasColor,
          bottom: PreferredSize(
            preferredSize: Size(
              MediaQuery.of(context).size.width * .8,
              70,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: TabBar(
                indicatorColor: Theme.of(context).canvasColor,
                unselectedLabelStyle: TextStyle(
                  fontFamily: 'Europa',
                  fontSize: 17,
                ),
                unselectedLabelColor: Color(0xFFA2A2A2),
                labelStyle: TextStyle(
                  fontFamily: 'Europa',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: Color(0xFFF4F4F4),
                ),
                tabs: [
                  Tab(
                    text: I18n.of(context).feed,
                  ),
                  Tab(
                    text: I18n.of(context).wallet,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Feed(),
            AssetsList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: HomeViewModel.fromStore,
      onInitialBuild: (viewModel) {
        viewModel.onReceiveBranchData(true);
      },
      onWillChange: (previousViewModel, newViewModel) {
        newViewModel.onReceiveBranchData(false);
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
            height: 182,
            child: CashHeader(),
          ),
          body: viewModel.showDepositBanner
              ? Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Positioned.fill(
                      top: viewModel.showDepositBanner ? 90 : 0,
                      child: body(),
                    ),
                    Positioned(
                      top: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: DepositBanner(),
                      ),
                    ),
                  ],
                )
              : body(),
        );
      },
    );
  }
}
