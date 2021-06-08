import 'dart:core';
import 'package:equatable/equatable.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';

class SecurityViewModel extends Equatable {
  final Function(BiometricAuth) setSecurityType;
  final bool isBackup;
  final BiometricAuth authType;
  SecurityViewModel({
    required this.setSecurityType,
    required this.authType,
    required this.isBackup,
  });

  static SecurityViewModel fromStore(Store<AppState> store) {
    return SecurityViewModel(
      isBackup: store.state.userState.backup,
      authType: store.state.userState.authType,
      setSecurityType: (biometricAuth) {
        store.dispatch(SetSecurityType(biometricAuth: biometricAuth));
      },
    );
  }

  @override
  List get props => [isBackup];
}
