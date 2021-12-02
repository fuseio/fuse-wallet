import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supervecina/features/home/widgets/action_tile.dart';
import 'package:supervecina/generated/l10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:supervecina/models/actions/wallet_action.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/redux/viewsmodels/assets.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class TokenActivities extends StatelessWidget {
  final String tokenAddress;

  TokenActivities({
    required this.tokenAddress,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TokensListViewModel>(
      distinct: true,
      converter: TokensListViewModel.fromStore,
      builder: (_, viewModel) {
        final token = viewModel.tokens
            .firstWhere((element) => element.address == tokenAddress);
        final bool hasActivity = token.walletActions!.list.isNotEmpty;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: !hasActivity
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          mainAxisAlignment:
              !hasActivity ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: <Widget>[
            !hasActivity
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          I10n.of(context).no_activity,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SvgPicture.asset(
                          'assets/images/no-activity.svg',
                          fit: BoxFit.cover,
                          height: 100,
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(top: 40, bottom: 30),
                    child: Text(
                      I10n.of(context).activity,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            GroupedListView<WalletAction, DateTime>(
              shrinkWrap: true,
              elements: token.walletActions?.list ?? [],
              groupBy: (element) {
                final DateTime dateTime =
                    DateTime.fromMillisecondsSinceEpoch(element.timestamp);
                return DateTime(dateTime.year, dateTime.month, dateTime.day);
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
