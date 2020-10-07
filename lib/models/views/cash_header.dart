import 'package:equatable/equatable.dart';
import 'package:bit2c/models/community.dart';
import 'package:bit2c/models/plugins/plugins.dart';
import 'package:redux/redux.dart';
import 'package:bit2c/models/app_state.dart';

class CashHeaderViewModel extends Equatable {
  final Community community;
  final Function() firstName;
  final Plugins plugins;
  final String walletStatus;

  final Function() phoneNumber;
  final Function() address;
  final Function() token;

  CashHeaderViewModel({this.community, this.firstName, this.plugins, this.walletStatus, this.address, this.phoneNumber, this.token});

  static CashHeaderViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres] ??
            new Community.initial();
    return CashHeaderViewModel(
      community: community,
      plugins: community?.plugins,
      walletStatus: store.state.cashWalletState.walletStatus,
        firstName: () {
          String fullName = store.state.userState.displayName ?? '';
          return fullName.split(' ')[0];
        },
        phoneNumber: () {
          String phoneNumber = store.state.userState.phoneNumber ?? '';
          return phoneNumber;
        },
        address: () {
          String address = store.state.userState.accountAddress ?? '';
          return address;
        },
        token: () {
          String token = store.state.userState.jwtToken ?? '';
          return token;
        }
      );

  }

  @override
  List<Object> get props => [community, plugins, walletStatus];
}
