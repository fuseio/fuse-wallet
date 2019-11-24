import 'package:fusecash/redux/actions/error_actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallet_core/wallet_core.dart';

class InitWeb3Success {
  final Web3 web3;
  InitWeb3Success(this.web3);
}

class GetPublicKeySuccess {
  final String publicKey;
  GetPublicKeySuccess(this.publicKey);
}

class GetWalletAddressSuccess {
  final String walletAddress;
  GetWalletAddressSuccess(this.walletAddress);
}

class GetTokenBalancesSuccess {
   // TODO
   GetTokenBalancesSuccess();
}

class SendTokenSuccess {
  // TODO
  SendTokenSuccess();
}

class ReceiveTokenSuccess {
  // TODO
  ReceiveTokenSuccess();
}

class JoinCommunitySuccess {
  // TODO
  JoinCommunitySuccess();
}

class SwitchCommunitySuccess {
  // TODO
  SwitchCommunitySuccess();
}

class GetJoinBonusSuccess {
  // TODO
  GetJoinBonusSuccess();
}

class GetBusinessListSuccess {
  // TODO
  GetBusinessListSuccess();
}

Future<bool> approvalCallback() async {
  return true;
}

final API api = new API();

ThunkAction initWeb3Call(String privateKey) {
  return (Store store) async {
    try {
      Web3 web3 = new Web3(approvalCallback);
      web3.setCredentials(privateKey);
      store.dispatch(new InitWeb3Success(web3));
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not init web3'));
    }
  };
}

ThunkAction getPublicKeyCall() {
  return (Store store) async {
    try {
      Web3 web3 = store.state.cashWalletState.web3;
      String publicKey = await web3.getAddress();
      store.dispatch(new GetPublicKeySuccess(publicKey));
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not get public key'));
    }
  };
}

ThunkAction getWalletAddressCall() {
  return (Store store) async {
    try {
      dynamic wallet = await api.getWallet();
      String walletAddress = wallet["walletAddress"];
      store.dispatch(new GetWalletAddressSuccess(walletAddress));
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not get wallet address'));
    }
  };
}

ThunkAction sendTokenCall() {
  return (Store store) async {
    try {
      // TODO
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not send token'));
    }
  };
}

ThunkAction receiveTokenCall() {
  return (Store store) async {
    try {
      // TODO
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not receive token'));
    }
  };
}

ThunkAction joinCommunityCall() {
  return (Store store) async {
    try {
      // TODO
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not join community'));
    }
  };
}

ThunkAction switchCommunityCall() {
  return (Store store) async {
    try {
      // TODO
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not switch community'));
    }
  };
}

ThunkAction getJoinBonusCall() {
  return (Store store) async {
    try {
      // TODO
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not get join bonus'));
    }
  };
}

ThunkAction getBusinessListCall() {
  return (Store store) async {
    try {
      // TODO
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not get business list'));
    }
  };
}