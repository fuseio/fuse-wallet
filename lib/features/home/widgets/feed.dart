import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/features/home/widgets/action_tile.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/redux/viewsmodels/feed.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, FeedViewModel>(
      converter: FeedViewModel.fromStore,
      distinct: true,
      builder: (_, viewModel) {
        return RefreshIndicator(
          onRefresh: () async {
            viewModel.refreshFeed();
            await Future.delayed(Duration(milliseconds: 1000));
            return 'success';
          },
          child: GroupedListView<WalletAction, DateTime>(
            elements: viewModel.walletActions,
            order: GroupedListOrder.DESC,
            stickyHeaderBackgroundColor:
                Theme.of(context).colorScheme.secondary,
            groupBy: (element) {
              final DateTime dateTime =
                  DateTime.fromMillisecondsSinceEpoch(element.timestamp);
              return DateTime(
                dateTime.year,
                dateTime.month,
                dateTime.day,
              );
            },
            itemComparator: (item1, item2) =>
                DateTime.fromMillisecondsSinceEpoch(
              item1.timestamp,
            ).compareTo(
              DateTime.fromMillisecondsSinceEpoch(
                item2.timestamp,
              ),
            ),
            groupSeparatorBuilder: (DateTime date) => Container(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 20,
                bottom: 10,
              ),
              child: Text(
                DateFormat.yMMMd().format(date),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            itemBuilder: (context, WalletAction element) => ActionTile(
              action: element,
            ),
          ),
        );
      },
    );
  }
}
