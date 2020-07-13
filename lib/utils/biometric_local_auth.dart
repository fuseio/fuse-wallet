import 'package:local_auth/local_auth.dart';

//local auth
enum BiometricAuth { faceID, touchID, pincode, none }

class BiometricUtils {
  //local authentication
  static Future<BiometricAuth> getAvailableBiometrics(
      {BiometricType type = BiometricType.fingerprint}) async {
    final List<BiometricType> availableBiometrics =
        await LocalAuthentication().getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.face)) {
      return BiometricAuth.faceID;
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      return BiometricAuth.touchID;
    }
    return BiometricAuth.none;
  }

  static Future<void> showDefaultPopupCheckBiometricAuth(
      {String message = '',
      Function(bool) callback,
      bool stickyAuth = false}) async {
    final localAuth = LocalAuthentication();
    final bool result = await localAuth.authenticateWithBiometrics(
        localizedReason: message, stickyAuth: stickyAuth);
    callback?.call(result);
  }

  static String getBiometricString(BiometricAuth type) {
    switch (type) {
      case BiometricAuth.faceID:
        return 'Face ID';
      case BiometricAuth.touchID:
        return 'Touch ID';
      default:
        return 'Touch ID';
    }
  }
}
