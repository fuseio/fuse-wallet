import 'package:country_code_picker/country_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:digitalrand/models/community.dart';
import 'package:digitalrand/models/jobs/base.dart';
import 'package:digitalrand/models/transactions/transfer.dart';
import 'package:digitalrand/redux/actions/cash_wallet_actions.dart';
import 'package:digitalrand/redux/actions/error_actions.dart';
import 'package:digitalrand/redux/actions/pro_mode_wallet_actions.dart';
import 'package:digitalrand/utils/addresses.dart';
import 'package:digitalrand/utils/contacts.dart';
import 'package:digitalrand/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallet_core/wallet_core.dart';
import 'package:digitalrand/services.dart';
import 'package:digitalrand/redux/state/store.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:digitalrand/utils/phone.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_udid/flutter_udid.dart';

class ActivateProMode {
  ActivateProMode();
}

class SwitchWalletMode {
  final bool isProMode;
  SwitchWalletMode({this.isProMode});
}

class VerifyRequest {
  final String verificationId;
  final String verificationCode;
  final GlobalKey<ScaffoldState> key;

  VerifyRequest({@required this.verificationId, @required this.verificationCode, @required this.key});

  @override
  String toString() {
    return 'VerifyRequest{verificationId: $verificationId, verificationCode: $verificationCode}';
  }
}

class RestoreWalletSuccess {
  final List<String> mnemonic;
  final String privateKey;
  RestoreWalletSuccess(this.mnemonic, this.privateKey);
}

class CreateLocalAccountSuccess {
  final List<String> mnemonic;
  final String privateKey;
  final String accountAddress;
  CreateLocalAccountSuccess(
      this.mnemonic, this.privateKey, this.accountAddress);
}

class ReLogin {
  ReLogin();
}

class LoginRequest {
  final CountryCode countryCode;
  final String phoneNumber;
  final PhoneCodeSent codeSent;
  final PhoneVerificationCompleted verificationCompleted;
  final PhoneVerificationFailed verificationFailed;
  final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout;

  LoginRequest({@required this.countryCode, @required this.phoneNumber, @required this.codeSent, @required this.verificationCompleted, @required this.verificationFailed, @required this.codeAutoRetrievalTimeout });
}

class LoginRequestSuccess {
  final CountryCode countryCode;
  final String phoneNumber;
  final String displayName;
  final String email;
  final String normalizedPhoneNumber;
  LoginRequestSuccess({this.countryCode, this.phoneNumber, this.displayName, this.email, this.normalizedPhoneNumber});
}

class SetIsoCode {
  final CountryCode countryCode;
  final String normalizedPhoneNumber;
  SetIsoCode({this.countryCode, this.normalizedPhoneNumber});
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

class SyncContactsRejected {
  SyncContactsRejected();
}

class SaveContacts {
  List<Contact> contacts;
  SaveContacts(this.contacts);
}

class SetPincodeSuccess {
  String pincode;
  SetPincodeSuccess(this.pincode);
}

class SetDisplayName {
  String displayName;
  SetDisplayName(this.displayName);
}

class BackupRequest {
  BackupRequest();
}

class BackupSuccess {
  BackupSuccess();
}

class SetCredentials {
  PhoneAuthCredential credentials;
  SetCredentials(this.credentials);
}

class SetVerificationId {
  String verificationId;
  SetVerificationId(this.verificationId);
}

class UpdateDisplayBalance {
  final int displayBalance;
  UpdateDisplayBalance(this.displayBalance);
}

class JustInstalled {
  final DateTime installedAt;
  JustInstalled(this.installedAt);
}

class SetIsLoginRequest {
  final bool isLoading;
  SetIsLoginRequest({this.isLoading});
}

class SetIsVerifyRequest {
  final bool isLoading;
  SetIsVerifyRequest({this.isLoading});
}

class DeviceIdSuccess {
  final String identifier;
  DeviceIdSuccess(this.identifier);
}

ThunkAction setCountryCode(CountryCode countryCode) {
  return (Store store) async {
    String phone = formatPhoneNumber(store.state.userState.phoneNumber, store.state.userState.countryCode);
    String normalizedPhoneNumber = await PhoneService.getNormalizedPhoneNumber(phone, countryCode.code);
    SetIsoCode(countryCode: countryCode, normalizedPhoneNumber: normalizedPhoneNumber);
  };
}

ThunkAction backupWalletCall(VoidCallback successCb) {
  return (Store store) async {
    if (store.state.userState.backup) return;
    final logger = await AppFactory().getLogger('action');
    String communityAddres = store.state.cashWalletState.communityAddress;
    store.dispatch(BackupRequest());
    try {
      dynamic response = await api.backupWallet(communityAddres);
      Community community = store.state.cashWalletState.communities[communityAddres];
      if (community.plugins.backupBonus != null && community.plugins.backupBonus.isActive) {
        BigInt value = toBigInt(community.plugins.backupBonus.amount, community.token.decimals);
        String walletAddress = store.state.cashWalletState.walletAddress;
        dynamic jobId = response['job']['_id'];
        logger.info('Job $jobId - sending backup bonus');
        Transfer backupBonus = new Transfer(
            from: DotEnv().env['FUNDER_ADDRESS'],
            to: walletAddress,
            text: 'You got a backup bonus!',
            type: 'RECEIVE',
            value: value,
            status: 'PENDING',
            jobId: jobId);
        store.dispatch(AddTransaction(backupBonus));

        response['job']['arguments'] = {
          'backupBonus': backupBonus,
        };
        response['job']['jobType'] = 'backup';
        Job job = JobFactory.create(response['job']);
        store.dispatch(AddJob(job));
        successCb();
      }
    } catch (e) {
      successCb();
    }
  };
}

ThunkAction backupSuccessCall(String txHash, transfer) {
  return (Store store) async {
    Transfer confirmedTx = transfer.copyWith(status: 'CONFIRMED', txHash: txHash);
    store.dispatch(new ReplaceTransaction(transfer, confirmedTx));
    store.dispatch(BackupSuccess());
    store.dispatch(segmentIdentifyCall(Map<String, dynamic>.from({ 'Wallet backed up success': true })));
    store.dispatch(segmentTrackCall('Wallet: backup success'));
  };
}

ThunkAction restoreWalletCall(List<String> _mnemonic, VoidCallback successCallback) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      logger.info('restore wallet');
      String mnemonic = _mnemonic.join(' ');
      logger.info('mnemonic: $mnemonic');
      logger.info('compute pk');
      String privateKey = await compute(Web3.privateKeyFromMnemonic, mnemonic);
      logger.info('privateKey: $privateKey');
      store.dispatch(new RestoreWalletSuccess(_mnemonic, privateKey));
      Credentials c = EthPrivateKey.fromHex(privateKey);
      dynamic accountAddress = await c.extractAddress();
      store.dispatch(new CreateLocalAccountSuccess(
          mnemonic.split(' '), privateKey, accountAddress.toString()));
      store.dispatch(initWeb3Call(privateKey));
      store.dispatch(segmentTrackCall("Wallet: restored mnemonic"));
      successCallback();
    } catch (e) {
      logger.severe('ERROR - restoreWalletCall $e');
      store.dispatch(new ErrorAction('Could not restore wallet'));
    }
  };
}

ThunkAction setDeviceId(bool reLogin) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    String identifier = await FlutterUdid.udid;
    logger.info("device identifier: $identifier");
    store.dispatch(new DeviceIdSuccess(identifier));
    if (reLogin) {
      final FirebaseUser currentUser = await firebaseAuth.currentUser();
      final String accountAddress = store.state.userState.accountAddress;
      IdTokenResult token = await currentUser.getIdToken();
      String jwtToken = await api.login(token.token, accountAddress, identifier, appName: 'DigitalRand');
      store.dispatch(new LoginVerifySuccess(jwtToken));
    }
  };
}

ThunkAction createLocalAccountCall(VoidCallback successCallback) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      logger.info('create new wallet');
      String mnemonic = Web3.generateMnemonic();
      logger.info('mnemonic: $mnemonic');
      logger.info('compute pk');
      String privateKey = await compute(Web3.privateKeyFromMnemonic, mnemonic);
      logger.info('privateKey: $privateKey');
      Credentials c = EthPrivateKey.fromHex(privateKey);
      dynamic accountAddress = await c.extractAddress();
      store.dispatch(new CreateLocalAccountSuccess(
          mnemonic.split(' '), privateKey, accountAddress.toString()));
      store.dispatch(initWeb3Call(privateKey));
      store.dispatch(segmentTrackCall("Wallet: Create new wallet"));
      successCallback();
    } catch (e) {
      logger.severe('ERROR - createLocalAccountCall $e');
      store.dispatch(new ErrorAction('Could not create new wallet'));
    }
  };
}

ThunkAction logoutCall() {
  return (Store store) async {
    store.dispatch(new LogoutRequestSuccess());
  };
}

ThunkAction reLoginCall() {
  return (Store store) async {
    store.dispatch(new ReLogin());
    store.dispatch(segmentTrackCall("Wallet: Login clicked"));
  };
}

ThunkAction syncContactsCall(List<Contact> contacts) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      store.dispatch(new SaveContacts(contacts));
      List<String> syncedContacts = store.state.userState.syncedContacts;
      List<String> newPhones = new List<String>();
      String countryCode = store.state.userState.countryCode;
      String isoCode = store.state.userState.isoCode;
      for (Contact contact in contacts) {
        if (isoCode == null) {
          List<String> uniquePhone = contact.phones
            .map((Item phone) => formatPhoneNumber(phone.value, store.state.userState.countryCode))
            .toSet()
            .toList();
          for (String phone in uniquePhone) {
            if (!syncedContacts.contains(phone)) {
              newPhones.add(phone);
            }
          }
        } else {
          Future<List<String>> phones = Future.wait(contact.phones.map((Item phone) async {
            String phoneNum = formatPhoneNumber(phone.value, countryCode);
            bool isValid = await PhoneService.isValid(phoneNum, isoCode);
            if (isValid) {
              String ph = await PhoneService.getNormalizedPhoneNumber(phoneNum, isoCode);
              return ph;
            }
            return phoneNum;
          }));
          List<String> result = await phones;
          result = result.toSet().toList();
          for (String phone in result) {
            if (!syncedContacts.contains(phone)) {
              newPhones.add(phone);
            }
          }
        }
      }
      if (newPhones.length == 0) {
        dynamic response = await api.syncContacts(newPhones);
        store.dispatch(new SyncContactsProgress(newPhones,
            List<Map<String, dynamic>>.from(response['newContacts'])));
        await api.ackSync(response['nonce']);
      } else {
        int limit = 100;
        List<String> partial = newPhones.take(limit).toList();
        while (partial.length > 0) {
          dynamic response = await api.syncContacts(partial);
          store.dispatch(new SyncContactsProgress(partial,
              List<Map<String, dynamic>>.from(response['newContacts'])));

          await api.ackSync(response['nonce']);
          newPhones = newPhones.sublist(partial.length);
          partial = newPhones.take(limit).toList();
        }
      }
    } catch (e) {
      logger.severe('ERROR - syncContactsCall $e');
    }
  };
}

ThunkAction identifyFirstTimeCall() {
  return (Store store) async {
    String fullPhoneNumber = store.state.userState.normalizedPhoneNumber ?? '';
    store.dispatch(enablePushNotifications());
    store.dispatch(segmentAliasCall(fullPhoneNumber));
    store.dispatch(segmentIdentifyCall(
        new Map<String, dynamic>.from({
          "Wallet Generated": true,
          "Phone Number": fullPhoneNumber,
          "Wallet Address": store.state.cashWalletState.walletAddress,
          "Account Address": store.state.userState.accountAddress,
          "Display Name": store.state.userState.displayName,
          "Identifier": store.state.userState.identifier
        })));
  };
}

ThunkAction identifyCall() {
  return (Store store) async {
    store.dispatch(segmentIdentifyCall(
        new Map<String, dynamic>.from({
          "Phone Number": store.state.userState.normalizedPhoneNumber ?? '',
          "Wallet Address": store.state.cashWalletState.walletAddress,
          "Account Address": store.state.userState.accountAddress,
          "Display Name": store.state.userState.displayName,
          "Identifier": store.state.userState.identifier,
          "Pro mode active": store.state.userState.isProMode,
          "Joined Communities": store.state.cashWalletState.communities.keys.toList(),
        })));
  };
}

ThunkAction setPincodeCall(String pincode) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      store.dispatch(SetPincodeSuccess(pincode));
    } catch (e) {
      logger.severe('ERROR - setPincodeCall $e');
      store.dispatch(new ErrorAction('Could not send token to contact'));
    }
  };
}

ThunkAction setDisplayNameCall(String displayName) {
  return (Store store) async {
    try {
      store.dispatch(new SetDisplayName(displayName));
      store.dispatch(segmentTrackCall("Wallet: display name added"));
    } catch (e) {}
  };
}

ThunkAction create3boxAccountCall(accountAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    String displayName = store.state.userState.displayName;
    try {
      Map user = {
        "accountAddress": accountAddress,
        "email": 'wallet-user@fuse.io',
        "provider": 'HDWallet',
        "subscribe": false,
        "source": 'wallet-v2',
        "displayName": displayName
      };
      await api.saveUserToDb(user);
      logger.info('save user $accountAddress');
    } catch (e) {
      logger.severe('user $accountAddress already saved');
    }
  };
}

ThunkAction activateProModeCall() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    store.dispatch(ActivateProMode());
    store.dispatch(initWeb3ProMode());
    try {
      bool deployForeignToken = store.state.userState.networks.contains(foreignNetwork);
      if (!deployForeignToken) {
        dynamic response =  await api.createWalletOnForeign();
        String jobId = response['job']['_id'];
        logger.info('createWalletOnForeign jobId $jobId');
        // store.dispatch(startFetchingJobCall(jobId, (job) {
        //   store.dispatch(getWalletAddressessCall());
        // }));
        store.dispatch(segmentTrackCall('Activate pro mode clicked'));
        store.dispatch(startListenToTransferEvents());
        store.dispatch(fetchTokensBalances());
        store.dispatch(segmentIdentifyCall(
        new Map<String, dynamic>.from({
          "Pro mode active": true,
        })));
      }
    } catch (error, stackTrace) {
      logger.severe('Error createWalletOnForeign', error);
      await AppFactory().reportError(error, stackTrace);
    }
  };
}

ThunkAction loadContacts() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      bool isPermitted = await Contacts.checkPermissions();
      if (isPermitted) {
        logger.info('Start - load contacts');
        List<Contact> contacts = await ContactController.getContacts();
        logger.info('Done - load contacts');
        store.dispatch(syncContactsCall(contacts));
      }
    } catch (error) {
      logger.severe('ERROR - load contacts $error');
    }
  };
}
