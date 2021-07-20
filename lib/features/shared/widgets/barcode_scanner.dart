import 'package:flutter/material.dart';
import 'package:fusecash/features/shared/dialogs/scan_qr.dart';
// import 'package:fusecash/features/shared/dialogs/warn_send.dart';
import 'package:fusecash/redux/viewsmodels/warn_send.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/utils/send.dart';

class BarcodeScanner extends StatelessWidget {
  const BarcodeScanner({
    Key? key,
    this.child,
    this.heroTag,
    this.backgroundColor,
  }) : super(key: key);
  final Widget? child;
  final String? heroTag;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, WarnSendDialogViewModel>(
      distinct: true,
      converter: WarnSendDialogViewModel.fromStore,
      builder: (_, viewModel) => Container(
        width: 45,
        height: 45,
        child: FloatingActionButton(
          heroTag: heroTag,
          child: child,
          backgroundColor: backgroundColor ?? Color(0xFF292929),
          elevation: 0,
          onPressed: () async {
            String? result = await showDialog<String>(
              context: context,
              builder: (context) => ScanQRDialog(),
            );
            if (result != null) {
              barcodeScannerHandler(context, result);
              // if (viewModel.warnSendDialogShowed) {
              // } else {
              //   final bool? isAccepted = await showDialog<bool>(
              //     barrierDismissible: false,
              //     context: context,
              //     builder: (context) => WarnSendDialog(),
              //   );
              //   if (isAccepted != null && isAccepted) {
              //     barcodeScannerHandler(context, result);
              //   }
              // }
            }
          },
        ),
      ),
    );
  }
}
