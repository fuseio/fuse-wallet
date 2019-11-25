
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/error_actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallet_core/wallet_core.dart';

class RestoreWalletSuccess {
  final List<String> mnemonic;
  final String privateKey;
  RestoreWalletSuccess(this.mnemonic, this.privateKey);
}

class CreateNewWalletSuccess {
  final List<String> mnemonic;
  final String privateKey;
  CreateNewWalletSuccess(this.mnemonic, this.privateKey);
}

class LoginRequestSuccess {
  final String countryCode;
  final String phoneNumber;
  LoginRequestSuccess(this.countryCode, this.phoneNumber);
}

class LoginVerifySuccess {
  final String jwtToken;
  LoginVerifySuccess(this.jwtToken);
}

final API api = new API();

ThunkAction restoreWalletCall(List<String> _mnemonic) {
  return (Store store) async {
    String mnemonic = _mnemonic.join(' ');
    try {
      String privateKey = Web3.privateKeyFromMnemonic(mnemonic);
      store.dispatch(new RestoreWalletSuccess(_mnemonic, privateKey));
      store.dispatch(initWeb3Call(privateKey));
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not restore wallet'));
    }
  };
}

ThunkAction createNewWalletCall() {
  return (Store store) async {
    try {
      String mnemonic = Web3.generateMnemonic();
      String privateKey = Web3.privateKeyFromMnemonic(mnemonic);
      store.dispatch(new CreateNewWalletSuccess(mnemonic.split(' '), privateKey));
      store.dispatch(initWeb3Call(privateKey));
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not create new wallet'));
    }
  };
}

ThunkAction loginRequestCall(String countryCode, String phoneNumber) {
  return (Store store) async {
    if (!countryCode.startsWith('+')) {
      countryCode = '+$countryCode';
    }
    String phone = countryCode + phoneNumber;
    bool result = await api.loginRequest(phone);
    if (result) {
      store.dispatch(new LoginRequestSuccess(countryCode, phoneNumber));
    } else {
      store.dispatch(new ErrorAction('Could not login'));
    }
  };
}

ThunkAction loginVerifyCall(String countryCode, String phoneNumber, String verificationCode) {
  return (Store store) async {
    try {
      if (!countryCode.startsWith('+')) {
        countryCode = '+$countryCode';
      }
      String phone = countryCode + phoneNumber;
      String jwtToken = await api.loginVerify(phone, verificationCode);
      store.dispatch(new LoginVerifySuccess(jwtToken));
      store.dispatch(joinCommunityCall());
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not verify login'));
    }
  };
}