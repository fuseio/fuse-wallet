import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';

class SettingsViewModel extends Equatable {
  final String countryCode;
  final String? contractVersion;
  final bool hasUpgrade;

  @override
  List<Object?> get props => [
        countryCode,
        hasUpgrade,
        contractVersion,
      ];

  const SettingsViewModel({
    required this.countryCode,
    required this.contractVersion,
    required this.hasUpgrade,
  });

  static SettingsViewModel fromStore(Store<AppState> store) {
    return SettingsViewModel(
      contractVersion: store.state.userState.contractVersion,
      countryCode: store.state.userState.countryCode,
      hasUpgrade: store.state.userState.hasUpgrade,
    );
  }
}
