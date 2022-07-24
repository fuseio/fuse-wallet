import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/features/shared/widgets/button.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/wallet/send_amount_arguments.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/swap_actions.dart';
import 'package:fusecash/utils/analytics/analytics.dart';

class TokenActions extends StatelessWidget {
  const TokenActions({
    Key? key,
    required this.isSwappable,
    required this.token,
  }) : super(key: key);
  final Token token;
  final bool isSwappable;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(
      distinct: true,
      converter: (store) => () => store.dispatch(fetchSwapBalances()),
      builder: (_, fetcher) {
        return Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isSwappable
                  ? Flexible(
                      child: Button(
                        width: MediaQuery.of(context).size.width * .425,
                        backgroundColor: const Color(0xFFE2F8ED),
                        text: I10n.of(context).swap,
                        onPressed: () {
                          fetcher();
                          context.navigateTo(
                            SwapTab(
                              children: [
                                SwapRoute(
                                  primaryToken: token,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
              Flexible(
                child: GradientButton(
                  width: isSwappable
                      ? MediaQuery.of(context).size.width * .425
                      : MediaQuery.of(context).size.width,
                  text: I10n.of(context).send,
                  textColor: Theme.of(context).canvasColor,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).canvasColor,
                      ),
                  onPressed: () {
                    Analytics.track(
                      eventName: AnalyticsEvents.send1MainButton,
                      properties: {"fromScreen": "Asset"},
                    );
                    context.router.push(
                      ContactsRoute(
                        pageArgs: SendFlowArguments(
                          tokenToSend: token,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
