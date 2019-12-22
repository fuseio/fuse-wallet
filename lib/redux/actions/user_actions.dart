import 'package:flutter/foundation.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/error_actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallet_core/wallet_core.dart';
import 'package:fusecash/services.dart';
import 'package:logger/logger.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:fusecash/utils/phone.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class RestoreWalletSuccess {
  final List<String> mnemonic;
  final String privateKey;
  RestoreWalletSuccess(this.mnemonic, this.privateKey);
}

class CreateNewWalletSuccess {
  final List<String> mnemonic;
  final String privateKey;
  final String accountAddress;
  CreateNewWalletSuccess(this.mnemonic, this.privateKey, this.accountAddress);
}

class LoginRequestSuccess {
  final String countryCode;
  final String phoneNumber;
  final String fullName;
  final String email;
  LoginRequestSuccess(
      this.countryCode, this.phoneNumber, this.fullName, this.email);
}

class LogoutRequestSuccess {
  LogoutRequestSuccess();
}

class LoginVerifySuccess {
  final String jwtToken;
  LoginVerifySuccess(this.jwtToken);
}

class SyncContactsProgress {
  List<String> contacts;
  List<Map<String, dynamic>> newContacts;
  SyncContactsProgress(this.contacts, this.newContacts);
}

class SaveContacts {
  List<Contact> contacts;
  SaveContacts(this.contacts);
}

class SetPincodeSuccess {
  String pincode;
  SetPincodeSuccess(this.pincode);
}

ThunkAction restoreWalletCall(List<String> _mnemonic) {
  return (Store store) async {
    String mnemonic = _mnemonic.join(' ');
    try {
      String privateKey = Web3.privateKeyFromMnemonic(mnemonic);
      store.dispatch(new RestoreWalletSuccess(_mnemonic, privateKey));
      store.dispatch(initWeb3Call(privateKey));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not restore wallet'));
    }
  };
}

ThunkAction createNewWalletCall() {
  return (Store store) async {
    try {
      String mnemonic = Web3.generateMnemonic();
      String privateKey = await compute(Web3.privateKeyFromMnemonic, mnemonic);

      Credentials c = EthPrivateKey.fromHex(privateKey);
      dynamic accountAddress = await c.extractAddress();
      store.dispatch(new CreateNewWalletSuccess(
          mnemonic.split(' '), privateKey, accountAddress.toString()));
      store.dispatch(initWeb3Call(privateKey));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not create new wallet'));
    }
  };
}

ThunkAction loginRequestCall(String countryCode, String phoneNumber,
    VoidCallback successCallback, VoidCallback failCallback) {
  return (Store store) async {
    if (!countryCode.startsWith('+')) {
      countryCode = '+$countryCode';
    }
    String phone = countryCode + phoneNumber;
    try {
      bool result = await api.loginRequest(phone);
      if (result) {
        store.dispatch(
            new LoginRequestSuccess(countryCode, phoneNumber, "", ""));
        successCallback();
      } else {
        store.dispatch(new ErrorAction('Could not login'));
        failCallback();
      }
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not login'));
      failCallback();
    }
  };
}

ThunkAction loginVerifyCall(
    String countryCode,
    String phoneNumber,
    String verificationCode,
    String accountAddress,
    VoidCallback successCallback,
    VoidCallback failCallback) {
  return (Store store) async {
    try {
      if (!countryCode.startsWith('+')) {
        countryCode = '+$countryCode';
      }
      String phone = countryCode + phoneNumber;
      String jwtToken =
          await api.loginVerify(phone, verificationCode, accountAddress);
      store.dispatch(new LoginVerifySuccess(jwtToken));
      successCallback();
      // store.dispatch(joinCommunityCall());
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not verify login'));
      failCallback();
    }
  };
}

ThunkAction logoutCall() {
  return (Store store) async {
    store.dispatch(new LogoutRequestSuccess());
  };
}

ThunkAction syncContactsCall(List<Contact> contacts) {
  return (Store store) async {
    store.dispatch(new SaveContacts(contacts));
    List<String> syncedContacts = store.state.userState.syncedContacts;
    List<String> newPhones = new List<String>();
    for (Contact contact in contacts) {
      for (Item phone in contact.phones) {
        String phoneNumber =
            formatPhoneNumber(phone.value, store.state.userState.countryCode);
        if (!syncedContacts.contains(phoneNumber)) {
          newPhones.add(phoneNumber);
        }
      }
    }
    if (newPhones.length == 0) {
      dynamic response = await api.syncContacts(newPhones);
      store.dispatch(new SyncContactsProgress(
            newPhones, List<Map<String, dynamic>>.from(response['newContacts'])));
        await api.ackSync(response['nonce']);
    } else {
      int limit = 100;
      List<String> partial = newPhones.take(limit).toList();
      while (partial.length > 0) {
        dynamic response = await api.syncContacts(partial);
        store.dispatch(new SyncContactsProgress(
            partial, List<Map<String, dynamic>>.from(response['newContacts'])));

        await api.ackSync(response['nonce']);
        newPhones = newPhones.sublist(partial.length);
        partial = newPhones.take(limit).toList();
      }
    }
  };
}


ThunkAction setPincodeCall(
    String pincode) {
  return (Store store) async {
    try {
      store.dispatch(SetPincodeSuccess(pincode));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not send token to contact'));
    }
  };
}