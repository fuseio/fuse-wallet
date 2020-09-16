import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/utils/format.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';

class ProfileViewModel extends Equatable {
  final String phone;
  final String walletAddress;
  final String avatarUrl;
  final String Function() displayName;
  final void Function(String displayName) updateDisplaName;
  final void Function(ImageSource source) editAvatar;

  ProfileViewModel(
      {this.phone,
      this.walletAddress,
      this.displayName,
      this.editAvatar,
      this.avatarUrl,
      this.updateDisplaName});

  static ProfileViewModel fromStore(Store<AppState> store) {
    return ProfileViewModel(
        phone: store.state.userState.phoneNumber,
        avatarUrl: store.state.userState.avatarUrl,
        walletAddress: formatAddress(store.state.userState.walletAddress),
        displayName: () {
          String fullName = store.state.userState.displayName ?? '';
          return fullName.split(' ')[0];
        },
        editAvatar: (source) {
          store.dispatch(updateUserAvatarCall(source));
        },
        updateDisplaName: (displayName) {
          store.dispatch(updateDisplayNameCall(displayName));
        });
  }

  @override
  List get props => [walletAddress, phone, displayName];
}
