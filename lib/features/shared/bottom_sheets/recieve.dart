import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/features/shared/widgets/button.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/receive.dart';
import 'package:fusecash/utils/alerts/alerts.dart';
import 'package:fusecash/utils/alerts/alerts_model.dart';
import 'package:fusecash/utils/format.dart';

class ReceiveBottomSheet extends StatelessWidget {
  const ReceiveBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Container(
        padding: const EdgeInsets.only(
          top: 40,
          bottom: 60,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: StoreConnector<AppState, ReceiveViewModel>(
          distinct: true,
          converter: ReceiveViewModel.fromStore,
          builder: (context, viewModel) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  I10n.of(context).send_to_your_vault,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5.0),
                AutoSizeText.rich(
                  TextSpan(
                    text: I10n.of(context).which_cryptocurrencies_can_i_use,
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: 225,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFF707070).withOpacity(.5),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      child: QrImage(
                        data: 'fuse:${viewModel.walletAddress}',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Button(
                  width: MediaQuery.of(context).size.width * .425,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  textColor: Theme.of(context).colorScheme.onSurface,
                  icon: SvgPicture.asset(
                    'assets/images/copy.svg',
                    width: 16,
                  ),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        letterSpacing: 0.1,
                      ),
                  text: Formatter.formatEthAddress(viewModel.walletAddress, 4),
                  onPressed: () {
                    final alerts = getIt<Alerts>();
                    Clipboard.setData(
                      ClipboardData(text: viewModel.walletAddress),
                    );
                    alerts.setAlert(
                      context,
                      I10n.of(context).copied_to_clipboard,
                      type: AlertsTypeEnum.INFO,
                    );
                  },
                ),
                const SizedBox(height: 60.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Icon(
                          Icons.info,
                          color: Theme.of(context).errorColor,
                          size: 18,
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: AutoSizeText.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: I10n.of(context).sending_on_fuse,
                              ),
                              TextSpan(
                                text: ' ${I10n.of(context).fuse_network}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60.0),
                GradientButton(
                  width: 120,
                  text: I10n.of(context).share_button,
                  icon: Icon(
                    Icons.share_outlined,
                    size: 20,
                    color: Theme.of(context).canvasColor,
                  ),
                  textColor: Theme.of(context).canvasColor,
                  onPressed: () {
                    Share.share(
                      viewModel.walletAddress,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

extension ReceiveBottomSheetExtension on ReceiveBottomSheet {
  Future<T?> showSheet<T>(BuildContext context) => showBarModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (context) => this,
      );
}
