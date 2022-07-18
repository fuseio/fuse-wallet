import 'package:flutter/material.dart';

import 'package:charge_wallet_sdk/models/models.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/features/shared/dialogs/warn_send.dart';
import 'package:fusecash/features/wallet/widgets/contact_tile.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/viewsmodels/warn_send.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/send.dart';

class SendToAccount extends StatelessWidget {
  final String accountAddress;
  final Token? token;
  final Collectible? collectible;
  final VoidCallback? resetSearch;
  const SendToAccount({
    Key? key,
    required this.accountAddress,
    this.collectible,
    this.resetSearch,
    this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          StoreConnector<AppState, WarnSendDialogViewModel>(
            distinct: true,
            converter: WarnSendDialogViewModel.fromStore,
            builder: (_, viewModel) {
              void handleTap() async {
                if (viewModel.warnSendDialogShowed) {
                  resetSearch?.call();
                  sendToPastedAddress(
                    accountAddress,
                    token: token,
                    collectible: collectible,
                  );
                } else {
                  const WarnSendDialog().showSheet(context).then((isAccepted) {
                    if (isAccepted != null && isAccepted) {
                      resetSearch?.call();
                      sendToPastedAddress(
                        accountAddress,
                        token: token,
                        collectible: collectible,
                      );
                    }
                  });
                }
              }

              return ContactTile(
                displayName: Formatter.formatEthAddress(accountAddress),
                onTap: handleTap,
                trailing: InkWell(
                  focusColor: Theme.of(context).canvasColor,
                  highlightColor: Theme.of(context).canvasColor,
                  onTap: handleTap,
                  child: Text(
                    I10n.of(context).next_button,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
