import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';

class ReceiveViewModel extends Equatable {
  final String walletAddress;
  const ReceiveViewModel({
    required this.walletAddress,
  });

  static ReceiveViewModel fromStore(Store<AppState> store) {
    return ReceiveViewModel(
      walletAddress: store.state.userState.walletAddress,
    );
  }

  @override
  List<Object?> get props => [
        walletAddress,
      ];
}
