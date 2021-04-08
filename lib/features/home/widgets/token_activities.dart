import 'package:flutter/material.dart';
import 'package:fusecash/features/home/widgets/action_tile.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/assets.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class TokenActivities extends StatelessWidget {
  final String tokenAddress;

  TokenActivities({
    this.tokenAddress,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TokensListViewModel>(
      distinct: true,
      converter: TokensListViewModel.fromStore,
      builder: (_, viewModel) {
        final token = viewModel.tokens
            .firstWhere((element) => element.address == tokenAddress);
        final hasActivity = token.walletActions.list.isNotEmpty;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            !hasActivity
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Image.asset(
                          'assets/images/no-activity.png',
                          fit: BoxFit.cover,
                          height: 100,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(I18n.of(context).no_activity,
                            style: TextStyle(
                                color: Color(0xFF979797),
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal))
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(top: 40, bottom: 30),
                    child: Text(
                      I18n.of(context).activity,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            !hasActivity
                ? SizedBox.shrink()
                : GroupedListView<WalletAction, DateTime>(
                    shrinkWrap: true,
                    elements: token.walletActions?.list ?? [],
                    groupBy: (element) {
                      final DateTime dateTime =
                          DateTime.fromMillisecondsSinceEpoch(
                              element.timestamp);
                      return DateTime(
                          dateTime.year, dateTime.month, dateTime.day);
                    },
                    groupSeparatorBuilder: (DateTime date) =>
                        Text(DateFormat.yMMMd().format(date)),
                    itemBuilder: (context, WalletAction element) => ActionTile(
                      action: element,
                      contentPadding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                    ),
                    order: GroupedListOrder.DESC,
                  ),
          ],
        );
      },
    );
  }
}
