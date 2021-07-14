import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/features/shared/dialogs/scan_qr.dart';
import 'package:fusecash/features/shared/dialogs/warn_send.dart';
import 'package:fusecash/redux/viewsmodels/warn_send.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/utils/send.dart';

class BarcodeScanner extends StatelessWidget {
  const BarcodeScanner({
    Key? key,
    this.child,
  }) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, WarnSendDialogViewModel>(
      distinct: true,
      converter: WarnSendDialogViewModel.fromStore,
      builder: (_, viewModel) => Container(
        width: 45,
        height: 45,
        child: GestureDetector(
          child: child ??
              SvgPicture.asset(
                'assets/images/scan_black.svg',
                width: 25.0,
              ),
          onTap: () async {
            String? result = await showDialog<String>(
              context: context,
              builder: (context) => ScanQRDialog(),
            );
            if (result != null) {
              if (viewModel.warnSendDialogShowed) {
                barcodeScannerHandler(context, result);
              } else {
                final bool? isAccepted = await showDialog<bool>(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => WarnSendDialog(),
                );
                if (isAccepted != null && isAccepted) {
                  barcodeScannerHandler(context, result);
                }
              }
            }
          },
        ),
      ),
    );
  }
}
