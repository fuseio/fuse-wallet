import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wallet_connect/models/wc_peer_meta.dart';
import 'package:wallet_connect/wc_client.dart';

import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/constants/analytics_props.dart';
import 'package:fusecash/constants/variables.dart';
import 'package:fusecash/features/shared/widgets/wallet_connect_actions.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/utils/analytics/analytics.dart';

class OnSessionRequestBottomSheet extends StatelessWidget {
  final WCPeerMeta wcPeerMeta;
  const OnSessionRequestBottomSheet({
    Key? key,
    required this.wcPeerMeta,
  }) : super(key: key);

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
            if (wcPeerMeta.icons.isNotEmpty)
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      radius: 38.5,
                      backgroundImage: NetworkImage(wcPeerMeta.icons.last),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 50,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      radius: 38.5,
                      backgroundImage:
                          const AssetImage('assets/images/icon_app.png'),
                    ),
                  ],
                ),
              ),
            if (wcPeerMeta.icons.isNotEmpty) const SizedBox(height: 20),
            Text(
              "${wcPeerMeta.name} ${I10n.of(context).wc_connect_to_wallet}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              wcPeerMeta.url,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFBEBEBE),
                  ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  I10n.of(context).wc_desc_one,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  I10n.of(context).wc_desc_two,
                ),
              ],
            ),
            const SizedBox(height: 20),
            YesOrNoActions(
              approveBtnText: I10n.of(context).connect,
              rejectBtnText: I10n.of(context).cancel,
              onApprove: () async {
                getIt<WCClient>().approveSession(
                  accounts: [
                    StoreProvider.of<AppState>(context)
                        .state
                        .userState
                        .walletAddress,
                  ],
                  chainId: Variables.fuseChainId,
                );
                StoreProvider.of<AppState>(context).dispatch(
                  AddSession(
                    getIt<WCClient>().sessionStore,
                  ),
                );
                Analytics.track(
                    eventName: AnalyticsEvents.wcConnection,
                    properties: {
                      AnalyticsProps.status: AnalyticsProps.approved,
                      AnalyticsProps.dappURL: wcPeerMeta.url,
                      AnalyticsProps.dappName: wcPeerMeta.name,
                    });
                Analytics.identify({
                  AnalyticsProps.wcConnected: true,
                });
                AutoRouter.of(context).pop();
              },
              onReject: () async {
                Analytics.track(
                  eventName: AnalyticsEvents.wcConnection,
                  properties: {
                    AnalyticsProps.status: AnalyticsProps.rejected,
                    AnalyticsProps.dappURL: wcPeerMeta.url,
                    AnalyticsProps.dappName: wcPeerMeta.name,
                  },
                );
                getIt<WCClient>().rejectSession();
                AutoRouter.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension OnSessionRequestBottomSheetExtension on OnSessionRequestBottomSheet {
  Future<T?> showSheet<T>(BuildContext context) => showBarModalBottomSheet(
        context: context,
        useRootNavigator: true,
        enableDrag: true,
        builder: (context) => this,
      );
}
