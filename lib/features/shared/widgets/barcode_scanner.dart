import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:charge_wallet_sdk/models/models.dart';
import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mnid_dart/mnid_dart.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/features/shared/dialogs/scan_qr.dart';
import 'package:fusecash/features/shared/dialogs/warn_send.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/viewsmodels/warn_send.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/send.dart';
import 'package:fusecash/utils/wallet_connect.dart';

class BarcodeScanner extends StatelessWidget {
  final Collectible? collectible;
  final Token? token;
  const BarcodeScanner({
    Key? key,
    this.collectible,
    this.token,
  }) : super(key: key);

  String? parseMnid(String scanData) {
    if (scanData.contains('gooddollar')) {
      final List<dynamic> splitted = scanData.split(' ');
      final Uri link = Uri.parse(splitted.last);
      final String code = link.queryParameters['code']!;
      String foo = code.split('.')[0];
      List<int> res = base64.decode(base64.normalize(foo));
      Map data = Map.from(json.decode(utf8.decode(res)));
      String mnid = data['m'];
      if (MNID.isMNID(mnid)) {
        final Map<dynamic, dynamic> mnidData = MNID.decode(mnid);
        return mnidData['address'];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, WarnSendDialogViewModel>(
      distinct: true,
      converter: WarnSendDialogViewModel.fromStore,
      builder: (_, viewModel) {
        return InkWell(
          splashColor: Theme.of(context).canvasColor,
          hoverColor: Theme.of(context).canvasColor,
          focusColor: Theme.of(context).canvasColor,
          highlightColor: Theme.of(context).canvasColor,
          child: SvgPicture.asset(
            'assets/images/qr_code.svg',
            width: 25,
            height: 25,
          ),
          onTap: () {
            Analytics.track(
              eventName: AnalyticsEvents.scanQRcode,
            );
            showGeneralDialog<String>(
              context: context,
              pageBuilder: (context, _, __) => const ScanQRDialog(),
            ).then((String? result) async {
              if (result != null) {
                Analytics.track(
                  eventName: AnalyticsEvents.scanQRcodeSuccess,
                );
                if (result.startsWith('wc:')) {
                  connectToWC(result);
                } else {
                  String scanResult = parseMnid(result) ?? result;
                  if (viewModel.warnSendDialogShowed) {
                    scanBarcode(
                      scanResult,
                      token: token,
                      collectible: collectible,
                    );
                  } else {
                    const WarnSendDialog()
                        .showSheet(context)
                        .then((isAccepted) {
                      if (isAccepted != null && isAccepted) {
                        scanBarcode(
                          scanResult,
                          token: token,
                          collectible: collectible,
                        );
                      }
                    });
                  }
                }
              }
            });
          },
        );
      },
    );
  }
}

extension BarcodeScannerExtension on BarcodeScanner {
  void scanBarcode(
    String scanResult, {
    Token? token,
    Collectible? collectible,
  }) async {
    PermissionStatus permission = await Permission.camera.request();
    if (permission == PermissionStatus.granted) {
      final bool hasColon = scanResult.contains(':');
      if (hasColon) {
        List<String> parts = scanResult.split(':');
        bool expression =
            parts.length == 2 && (parts[0] == 'fuse' || parts[0] == 'ethereum');
        if (expression) {
          String accountAddress = parts[0] == 'fuse' && parts[1] == 'f'
              ? parts[1].replaceFirst('f', 'x')
              : parts[1];
          if (isValidEthereumAddress(accountAddress)) {
            sendToPastedAddress(
              accountAddress,
              token: token,
              collectible: collectible,
            );
          } else {
            throw Exception('invalid scanned payload: $scanResult');
          }
        }
      } else if (isValidEthereumAddress(scanResult)) {
        sendToPastedAddress(
          scanResult,
          token: token,
          collectible: collectible,
        );
      }
    }
  }
}
