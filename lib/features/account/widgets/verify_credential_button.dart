import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/features/account/providers.dart';
import 'package:fusecash/models/verifiable_credential/verification_result.dart';
import 'package:fusecash/utils/alerts/alerts.dart';
import 'package:fusecash/utils/alerts/alerts_model.dart';
import 'package:fusecash/utils/did/did_service.dart';

class VerifyCredentialButton extends ConsumerWidget {
  const VerifyCredentialButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verifyCredentialPageModel =
        ref.watch(verifyCredentialPageModelProvider);
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: verifyCredentialPageModel.credentialTextController,
      builder: (_, value, __) {
        final credential = value.text;
        final primaryColor = Theme.of(context).colorScheme.primary;
        final buttonColor =
            credential.isEmpty ? primaryColor.withOpacity(0.5) : primaryColor;
        return ElevatedButton(
          onPressed: () {
            _onPressed(
              context: context,
              credential: credential,
              privateKeyForDID: verifyCredentialPageModel.privateKeyForDID,
            );
          },
          style: _getStyle(buttonColor),
          child: const Text(
            "Verify Credential",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        );
      },
    );
  }

  void _onPressed({
    required BuildContext context,
    required String credential,
    required String privateKeyForDID,
  }) {
    final alerts = getIt<Alerts>();

    try {
      final didService = DIDService(privateKey: privateKeyForDID);
      final result = didService.verifyCredential(credential);

      final resultAsMap = jsonDecode(result);
      final verificationResult = VerificationResult.fromJson(resultAsMap);

      _showAlertAccordingToTheResult(context, verificationResult);
    } on Exception catch (exception) {
      final alertMessage =
          "Failed to verify credential. ${exception.toString()}";
      alerts.setAlert(context, alertMessage, type: AlertsTypeEnum.ERROR);
    }
  }

  void _showAlertAccordingToTheResult(
    BuildContext context,
    VerificationResult result,
  ) {
    final warnings = result.warnings;
    final errors = result.errors;

    final alerts = getIt<Alerts>();

    if (errors.isEmpty) {
      String alertMessage = "Credential has been verified successfully.";
      if (warnings.isNotEmpty) {
        alertMessage += " $warnings";
      }
      alerts.setAlert(context, alertMessage, type: AlertsTypeEnum.SUCCESS);
    } else {
      final alertMessage = "Failed to verify credential. $errors";
      alerts.setAlert(context, alertMessage, type: AlertsTypeEnum.ERROR);
    }
  }

  ButtonStyle _getStyle(Color buttonColor) {
    return ElevatedButton.styleFrom(
      primary: buttonColor,
      elevation: 0.0,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    );
  }
}
