// import 'package:auto_animated/auto_animated.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/features/home/widgets/action_tile.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/redux/viewsmodels/feed.dart';
// import 'package:grouped_list/grouped_list.dart';
// import 'package:intl/intl.dart';

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
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                reverse: true,
                itemCount: viewModel.walletActions?.length,
                separatorBuilder: (BuildContext context, int index) => Padding(
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
                  action: viewModel.walletActions?.toList()[index],
                ),
              ),
            ),
            // Flexible(
            //   child: GroupedListView<WalletAction, DateTime>(
            //     shrinkWrap: true,
            //     elements: viewModel.walletActions,
            //     useStickyGroupSeparators: true,
            //     order: GroupedListOrder.DESC,
            //     stickyHeaderBackgroundColor:
            //         Theme.of(context).colorScheme.secondary,
            //     groupBy: (element) {
            //       final DateTime dateTime =
            //           DateTime.fromMillisecondsSinceEpoch(element.timestamp);
            //       return DateTime(
            //         dateTime.year,
            //         dateTime.month,
            //         dateTime.day,
            //       );
            //     },
            //     groupSeparatorBuilder: (DateTime date) => Padding(
            //       padding: EdgeInsets.only(
            //         left: 15,
            //         right: 15,
            //       ),
            //       child: Text(
            //         DateFormat.yMMMd().format(date),
            //         style: TextStyle(
            //           fontSize: 16,
            //         ),
            //       ),
            //     ),
            //     itemBuilder: (context, WalletAction element) => ActionTile(
            //       action: element,
            //     ),
            //     separator: Padding(
            //       padding: EdgeInsets.only(
            //         left: 15,
            //         right: 15,
            //       ),
            //       child: Divider(
            //         thickness: 1,
            //         height: 0,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
