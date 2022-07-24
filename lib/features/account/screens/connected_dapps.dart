import 'dart:core';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_connect/wallet_connect.dart';

import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/features/shared/dialogs/scan_qr.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/connected_dapps.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/wallet_connect.dart';
import 'package:fusecash/widget_extends/sf_widget.dart';

class ConnectedDAppsPage extends StatefulWidget {
  const ConnectedDAppsPage({Key? key}) : super(key: key);

  @override
  State<ConnectedDAppsPage> createState() => _ConnectedDAppsPageState();
}

class _ConnectedDAppsPageState extends SfWidget<ConnectedDAppsPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ConnectedDAppsViewModel>(
      distinct: true,
      converter: ConnectedDAppsViewModel.fromStore,
      builder: (_, viewModel) {
        return InnerScaffold(
          hasScrollBody: false,
          title: I10n.of(context).connected_DApps,
          body: SizedBox(
            height: 1,
            child: ListView(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  I10n.of(context).link_dapps_description,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: 50,
                ),
                GradientButton(
                  height: 40,
                  width: MediaQuery.of(context).size.width * .9,
                  textColor: Theme.of(context).canvasColor,
                  text: I10n.of(context).connect,
                  icon: SvgPicture.asset(
                    'assets/images/qr_code.svg',
                    width: 25,
                    height: 25,
                    color: Theme.of(context).canvasColor,
                  ),
                  onPressed: () async {
                    Analytics.track(
                      eventName: AnalyticsEvents.scanQRcode,
                    );
                    String? result = await showGeneralDialog<String>(
                      context: context,
                      pageBuilder: (context, _, __) => const ScanQRDialog(),
                    );
                    if (result != null && result.startsWith('wc:')) {
                      Analytics.track(
                        eventName: AnalyticsEvents.scanQRcodeSuccess,
                      );
                      connectToWC(result);
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  I10n.of(context).active_connections,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child: Divider(height: 3),
                  ),
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  itemCount: viewModel.wcSessionStores.length,
                  itemBuilder: (context, index) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: viewModel.wcSessionStores[index].remotePeerMeta
                            .icons.isNotEmpty
                        ? CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              viewModel.wcSessionStores[index].remotePeerMeta
                                  .icons.last,
                            ),
                          )
                        : null,
                    title: Text(
                      viewModel.wcSessionStores[index].remotePeerMeta.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    trailing: GradientButton(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                      height: 50,
                      text: I10n.of(context).disconnect,
                      width: 111,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      onPressed: () {
                        if (getIt<WCClient>().isConnected &&
                            getIt<WCClient>().session != null &&
                            (getIt<WCClient>().session.hashCode ==
                                viewModel
                                    .wcSessionStores[index].session.hashCode)) {
                          getIt<WCClient>().connectFromSessionStore(
                            viewModel.wcSessionStores[index],
                          );
                          getIt<WCClient>().killSession();
                        }
                        viewModel.removeSession(
                          viewModel.wcSessionStores[index],
                        );
                        context.router.pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
