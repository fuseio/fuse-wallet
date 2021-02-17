import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/features/home/widgets/action_tile.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/redux/viewsmodels/feed.dart';

class Feed extends StatelessWidget {
  Feed({this.withTitle = true});
  final bool withTitle;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, FeedViewModel>(
        converter: FeedViewModel.fromStore,
        distinct: true,
        onInitialBuild: (viewModel) {
          viewModel.startFetching();
        },
        onWillChange: (prevViewModel, nextViewModel) {
          nextViewModel.startFetching();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    withTitle
                        ? Container(
                            padding: EdgeInsets.only(left: 15, top: 20),
                            child: Text(
                              I18n.of(context).transactions,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF979797),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.normal),
                            ),
                          )
                        : SizedBox.shrink(),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: viewModel.walletActions?.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            Padding(
                          padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          child: Divider(
                            color: Color(0xFFE8E8E8),
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
                height: MediaQuery.of(context).size.height *
                    (withTitle ? .66 : .576),
              ),
            ),
          );
        });
  }
}
