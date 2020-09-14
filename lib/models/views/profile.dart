import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux/redux.dart';

class ProfileViewModel extends Equatable {
  final String phone;
  final String walletAddress;
  final String Function() firstName;

  ProfileViewModel({this.phone, this.walletAddress, this.firstName});


  static ProfileViewModel fromStore(Store<AppState> store) {
    return ProfileViewModel(
        phone: store.state.userState.phoneNumber,
        walletAddress: formatAddress(store.state.userState.walletAddress),
        firstName: () {
          String fullName = store.state.userState.displayName ?? '';
          return fullName.split(' ')[0];
        });
  }

  @override
  List get props => [walletAddress, phone, firstName];
}
