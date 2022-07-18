import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/features/shared/widgets/wallet_connect_actions.dart';
import 'package:fusecash/utils/analytics/analytics.dart';

class WrongPhoneNumberBottomSheet extends StatelessWidget {
  const WrongPhoneNumberBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              I10n.of(context).wrong_phone_number,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 30),
            Text(
              I10n.of(context).wrong_phone_number_explained,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 30),
            YesOrNoActions(
              approveBtnText: I10n.of(context).support,
              rejectBtnText: I10n.of(context).cancel,
              onApprove: () async {
                String? encodeQueryParameters(Map<String, String> params) {
                  return params.entries
                      .map((e) =>
                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                      .join('&');
                }

                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'support@fuse.io',
                  query: encodeQueryParameters(<String, String>{
                    'subject': 'Request to change the phone number',
                    'body':
                        '''I would like to change the phone number to which my Fuse Cash account is connected.
Old phone number: 
New phone number:'''
                  }),
                );
                launchUrl(emailLaunchUri);
                Analytics.track(
                  eventName: AnalyticsEvents.getHelp,
                  properties: Map.from(
                    {"fromScreen": 'SignUpScreen'},
                  ),
                );
              },
              onReject: AutoRouter.of(context).pop,
            ),
          ],
        ),
      ),
    );
  }
}

extension WrongPhoneNumberBottomSheetExtension on WrongPhoneNumberBottomSheet {
  Future<T?> showSheet<T>(BuildContext context) => showBarModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (context) => this,
      );
}
