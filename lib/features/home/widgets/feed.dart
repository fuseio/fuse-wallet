import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/features/home/widgets/action_tile.dart';
import 'package:fusecash/features/home/widgets/deposit_banner.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/redux/viewsmodels/feed.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, FeedViewModel>(
      converter: FeedViewModel.fromStore,
      distinct: true,
      onInitialBuild: (viewModel) {
        viewModel.startFetching();
      },
      builder: (_, viewModel) {
        return RefreshIndicator(
          onRefresh: () async {
            viewModel.refreshFeed();
            await Future.delayed(Duration(milliseconds: 1000));
            return 'success';
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * .61,
              child: Column(
                children: <Widget>[
                  DepositBanner(),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: viewModel.walletActions?.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: Divider(
                          thickness: 1,
                          height: 0,
                        ),
                      ),
                      itemBuilder: (context, index) => ActionTile(
                        action: viewModel.walletActions[index],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
