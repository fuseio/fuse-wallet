import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
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

  RefreshIndicator refreshIndicator(HomeViewModel viewModel) {
    return RefreshIndicator(
      onRefresh: () async {
        viewModel.refreshFeed();
        await Future.delayed(Duration(milliseconds: 1000));
        return 'success';
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * .7,
          child: DefaultTabController(
            length: tabsTitles.length,
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
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TabBar(
                      tabs: [
                        Tab(
                          // text: I18n.of(context).feed,
                          child: Text(
                            I18n.of(context).feed,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Tab(
                          // text: I18n.of(context).wallet,
                          child: Text(
                            I18n.of(context).wallet,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: TextStyle(fontSize: 18),
                          ),
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
          ),
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
          body: refreshIndicator(viewModel),
        );
      },
    );
  }
}
