import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';

import 'package:fusecash/models/app_state.dart';

class TopUpViewModel extends Equatable {
  final String walletAddress;

  const TopUpViewModel({
    required this.walletAddress,
  });

  static TopUpViewModel fromStore(Store<AppState> store) {
    return TopUpViewModel(
      walletAddress: store.state.userState.walletAddress,
    );
  }

  @override
  List<Object?> get props => [
        walletAddress,
      ];
}
