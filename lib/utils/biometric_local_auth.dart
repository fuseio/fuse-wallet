import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:local_auth/local_auth.dart';

import 'package:fusecash/constants/enums.dart';

class BiometricUtils {
  static Future<BiometricAuth> getAvailableBiometrics({
    BiometricType type = BiometricType.fingerprint,
  }) async {
    final List<BiometricType> availableBiometrics =
        await LocalAuthentication().getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.face)) {
      return BiometricAuth.faceID;
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      return BiometricAuth.touchID;
    }
    return BiometricAuth.none;
  }

  static Future<void> showDefaultPopupCheckBiometricAuth({
    String message = '',
    required Function(bool) callback,
    bool stickyAuth = true,
  }) async {
    final localAuth = LocalAuthentication();
    final bool result = await localAuth.authenticate(
      localizedReason: message,
      options: AuthenticationOptions(
        stickyAuth: stickyAuth,
      ),
    );
    callback.call(result);
  }

  static String getBiometricString(
    BuildContext context,
    BiometricAuth type,
  ) {
    switch (type) {
      case BiometricAuth.faceID:
        return I10n.of(context).face_id;
      case BiometricAuth.touchID:
        return I10n.of(context).touch_id;
      default:
        return I10n.of(context).touch_id;
    }
  }
}
