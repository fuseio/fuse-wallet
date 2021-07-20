import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';

class ProfileViewModel extends Equatable {
  final String phone;
  final String walletAddress;
  final String avatarUrl;
  final String displayName;
  final void Function(String displayName) updateDisplayName;
  final void Function(ImageSource source) editAvatar;

  ProfileViewModel({
    required this.phone,
    required this.walletAddress,
    required this.displayName,
    required this.editAvatar,
    required this.avatarUrl,
    required this.updateDisplayName,
  });

  static ProfileViewModel fromStore(Store<AppState> store) {
    return ProfileViewModel(
      displayName: store.state.userState.displayName,
      phone: store.state.userState.phoneNumber,
      avatarUrl: store.state.userState.avatarUrl,
      walletAddress: store.state.userState.walletAddress,
      editAvatar: (source) {
        store.dispatch(updateUserAvatarCall(source));
      },
      updateDisplayName: (displayName) {
        store.dispatch(updateDisplayNameCall(displayName));
      },
    );
  }

  @override
  List get props => [
        walletAddress,
        phone,
        displayName,
        avatarUrl,
      ];
}
