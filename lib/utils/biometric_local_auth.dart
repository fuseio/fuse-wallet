import 'package:auto_route/auto_route.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:local_auth/local_auth.dart';

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
    Function(bool) callback,
    bool stickyAuth = false,
  }) async {
    final localAuth = LocalAuthentication();
    final bool result = await localAuth.authenticateWithBiometrics(
      localizedReason: message,
      stickyAuth: stickyAuth,
    );
    callback?.call(result);
  }

  static String getBiometricString(BiometricAuth type) {
    switch (type) {
      case BiometricAuth.faceID:
        return I10n.of(ExtendedNavigator.root.context).face_id;
      case BiometricAuth.touchID:
        return I10n.of(ExtendedNavigator.root.context).touch_id;
      default:
        return I10n.of(ExtendedNavigator.root.context).touch_id;
    }
  }
}
