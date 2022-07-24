import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import 'package:fusecash/features/home/widgets/action_tile.dart';
import 'package:fusecash/models/actions/actions.dart';
import 'package:fusecash/models/actions/wallet_action.dart';

class TokenActivities extends StatelessWidget {
  final WalletActions? walletActions;

  const TokenActivities({this.walletActions, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool hasActivity = walletActions!.list.isNotEmpty;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          !hasActivity ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment:
          !hasActivity ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        !hasActivity
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      I10n.of(context).no_activity,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
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
                padding: const EdgeInsets.only(top: 40, bottom: 0),
                child: Text(
                  I10n.of(context).activity,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
        GroupedListView<WalletAction, DateTime>(
          shrinkWrap: true,
          elements: walletActions?.list ?? [],
          padding: const EdgeInsets.only(
            top: 30,
          ),
          groupBy: (element) {
            final DateTime dateTime =
                DateTime.fromMillisecondsSinceEpoch(element.timestamp);
            return DateTime(dateTime.year, dateTime.month, dateTime.day);
          },
          groupSeparatorBuilder: (DateTime date) =>
              Text(DateFormat.yMMMd().format(date)),
          itemBuilder: (context, WalletAction element) => ActionTile(
            action: element,
            contentPadding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
          ),
          order: GroupedListOrder.DESC,
        ),
      ],
    );
  }
}
