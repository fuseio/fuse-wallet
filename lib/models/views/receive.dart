import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:roost/models/app_state.dart';

class ReceiveModel extends Equatable {
  final String walletAddress;
  ReceiveModel({this.walletAddress});

  static ReceiveModel fromStore(Store<AppState> store) {
    return ReceiveModel(
      walletAddress: store.state.cashWalletState.walletAddress,
    );
  }

  @override
  List<Object> get props => [walletAddress];
}
