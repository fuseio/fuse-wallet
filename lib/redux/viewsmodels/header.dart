import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';

class HeaderViewModel extends Equatable {
  final String walletAddress;
  final Function() firstName;

  @override
  List<Object?> get props => [
        walletAddress,
      ];

  const HeaderViewModel({
    required this.firstName,
    required this.walletAddress,
  });

  static HeaderViewModel fromStore(Store<AppState> store) {
    return HeaderViewModel(
      walletAddress: store.state.userState.walletAddress,
      firstName: () {
        String fullName = store.state.userState.displayName;
        return fullName.split(' ')[0];
      },
    );
  }
}
