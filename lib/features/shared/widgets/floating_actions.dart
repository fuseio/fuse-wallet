import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/features/shared/bottom_sheets/recieve.dart';
import 'package:fusecash/features/shared/widgets/button.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/wallet/send_amount_arguments.dart';
import 'package:fusecash/utils/analytics/analytics.dart';

class FloatingActions extends StatelessWidget {
  const FloatingActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: Button(
              width: MediaQuery.of(context).size.width * .425,
              backgroundColor: const Color(0xFFE2F8ED),
              text: I10n.of(context).send,
              onPressed: () {
                Analytics.track(
                    eventName: AnalyticsEvents.send1MainButton,
                    properties: {"fromScreen": "Wallet"});
                context.router.push(
                  ContactsRoute(
                    pageArgs: SendFlowArguments(),
                  ),
                );
              },
            ),
          ),
          Flexible(
            child: GradientButton(
              icon: SvgPicture.asset(
                'assets/images/qr_code.svg',
                width: 17,
                color: Theme.of(context).canvasColor,
              ),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).canvasColor,
                  ),
              width: MediaQuery.of(context).size.width * .425,
              textColor: Theme.of(context).canvasColor,
              text: I10n.of(context).receive,
              onPressed: () {
                const ReceiveBottomSheet().showSheet(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
