import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:charge_wallet_sdk/charge_wallet_sdk.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_number/phone_number.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/constants/analytics_props.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/models/user_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/contacts.dart';
import 'package:fusecash/utils/crashlytics.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/utils/phone.dart';

class SetWalletConnectURI {
  final String wcURI;
  SetWalletConnectURI(this.wcURI);
}

class ScrollToTop {
  final bool value;
  ScrollToTop(
    this.value,
  );
}

class ToggleUpgrade {
  final bool value;
  ToggleUpgrade({
    required this.value,
  });
}

class UpdateCurrency {
  final String currency;
  UpdateCurrency({required this.currency});
}

class UpdateLocale {
  final Locale locale;
  UpdateLocale({required this.locale});
}

class WarnSendDialogShowed {
  final bool value;
  WarnSendDialogShowed(
    this.value,
  );
}

class SetSecurityType {
  BiometricAuth biometricAuth;
  SetSecurityType({required this.biometricAuth});
}

class CreateLocalAccountSuccess {
  final List<String> mnemonic;
  final String privateKey;
  final String accountAddress;
  CreateLocalAccountSuccess(
    this.mnemonic,
    this.privateKey,
    this.accountAddress,
  );
}

class ReLogin {
  ReLogin();
}

class LoginRequestSuccess {
  final CountryCode countryCode;
  final String phoneNumber;
  final String? displayName;
  final String? email;
  LoginRequestSuccess({
    required this.countryCode,
    required this.phoneNumber,
    this.displayName,
    this.email,
  });
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

class SetUserAvatar {
  String avatarUrl;
  SetUserAvatar(this.avatarUrl);
}

class BackupRequest {
  BackupRequest();
}

class BackupSuccess {
  BackupSuccess();
}

class SetCredentials {
  PhoneAuthCredential? credentials;
  SetCredentials(this.credentials);
}

class SetVerificationId {
  String verificationId;
  SetVerificationId(this.verificationId);
}

class JustInstalled {
  final DateTime installedAt;
  JustInstalled(this.installedAt);
}

class DeviceIdSuccess {
  final String identifier;
  DeviceIdSuccess(this.identifier);
}

ThunkAction loginHandler(
  CountryCode countryCode,
  PhoneNumber phoneNumber,
  Function onSuccess,
  Function(dynamic error) onError,
) {
  return (Store store) async {
    try {
      store.dispatch(setDeviceId(phoneNumber.e164));
      Analytics.setUserId(phoneNumber.e164);
      await onBoardStrategy.login(
        store,
        phoneNumber.e164,
        () {
          Analytics.track(
            eventName: AnalyticsEvents.loginWithPhone,
            properties: {
              AnalyticsProps.status: AnalyticsProps.success,
            },
          );
          store.dispatch(
            LoginRequestSuccess(
              countryCode: countryCode,
              phoneNumber: phoneNumber.e164,
            ),
          );
          onSuccess();
        },
        (e) {
          Analytics.track(
            eventName: AnalyticsEvents.loginWithPhone,
            properties: {
              AnalyticsProps.status: AnalyticsProps.failed,
              "error": e.toString(),
            },
          );
          onError(e.toString());
          Crashlytics.logMessage(
              'Error in login with phone number: ${e.toString()}');
        },
      );
    } catch (e, s) {
      log.error(
        'ERROR - Login Request',
        error: e,
        stackTrace: s,
      );
      onError(e);
      Analytics.track(
        eventName: AnalyticsEvents.loginWithPhone,
        properties: {
          AnalyticsProps.status: AnalyticsProps.failed,
          "error": e.toString(),
        },
      );
      Crashlytics.recordError(
        Exception('Error in login with phone number: ${e.toString()}'),
        s,
        reason: 'ERROR in Login Request',
      );
    }
  };
}

ThunkAction verifyHandler(
  String verificationCode,
  Function onSuccess,
  Function(dynamic error) onError,
) {
  return (Store store) async {
    try {
      await onBoardStrategy.verify(
        store,
        verificationCode,
        (String jwtToken) {
          Analytics.track(
            eventName: AnalyticsEvents.verify,
            properties: {
              AnalyticsProps.status: AnalyticsProps.success,
            },
          );
          store.dispatch(LoginVerifySuccess(jwtToken));
          chargeApi.setJwtToken(jwtToken);
          onSuccess();
          rootRouter.push(const UserNameRoute());
        },
      );
    } catch (error, s) {
      onError(error.toString());
      Analytics.track(
        eventName: AnalyticsEvents.verify,
        properties: {
          AnalyticsProps.status: AnalyticsProps.failed,
          "error": error.toString(),
        },
      );
      Crashlytics.recordError(
        Exception('Error in verify phone number: ${error.toString()}'),
        s,
        reason: 'Error while phone number verification',
      );
    }
  };
}

ThunkAction restoreWalletCall(
  List<String> mnemonic,
  VoidCallback successCallback,
  VoidCallback failureCallback,
) {
  return (Store store) async {
    try {
      Analytics.track(
        eventName: AnalyticsEvents.restoreWallet,
      );
      log.info('restore wallet');
      log.info('mnemonic: $mnemonic');
      log.info('compute pk');
      String privateKey = await compute(
        Web3.privateKeyFromMnemonic,
        mnemonic.join(' '),
      );
      Credentials credentials = EthPrivateKey.fromHex(privateKey);
      EthereumAddress accountAddress = await credentials.extractAddress();
      log.info('privateKey: $privateKey');
      log.info('accountAddress: ${accountAddress.toString()}');
      store.dispatch(
        CreateLocalAccountSuccess(
          mnemonic,
          privateKey,
          accountAddress.toString(),
        ),
      );
      successCallback();
    } catch (e, s) {
      log.error(
        'ERROR - restoreWalletCall',
        error: e,
        stackTrace: s,
      );
      failureCallback();
      Crashlytics.recordError(
        Exception('Error in restore mnemonic: ${e.toString()}'),
        s,
        reason: 'ERROR in restore wallet',
      );
    }
  };
}

ThunkAction setDeviceId(String phoneNumber) {
  return (Store store) async {
    String identifier = await FlutterUdid.udid;
    // mixpanel.alias(identifier, phoneNumber);
    log.info("device identifier: $identifier");
    store.dispatch(DeviceIdSuccess(identifier));
  };
}

ThunkAction createLocalAccountCall(
  VoidCallback successCallback,
) {
  return (Store store) async {
    try {
      log.info('create wallet');
      String mnemonic = Web3.generateMnemonic();
      log.info('mnemonic: $mnemonic');
      log.info('compute pk');
      String privateKey = await compute(
        Web3.privateKeyFromMnemonic,
        mnemonic,
      );
      Credentials credentials = EthPrivateKey.fromHex(privateKey);
      EthereumAddress accountAddress = await credentials.extractAddress();
      log.info('privateKey: $privateKey');
      log.info('accountAddress: ${accountAddress.toString()}');
      store.dispatch(
        CreateLocalAccountSuccess(
          mnemonic.split(' '),
          privateKey,
          accountAddress.toString(),
        ),
      );
      Analytics.track(
        eventName: AnalyticsEvents.createWallet,
      );
      successCallback();
    } catch (e, s) {
      log.error(
        'ERROR - createLocalAccountCall',
        error: e,
        stackTrace: s,
      );
      Crashlytics.recordError(
        Exception('Error in generate mnemonic: ${e.toString()}'),
        s,
        reason: 'ERROR while generate mnemonic',
      );
    }
  };
}

ThunkAction reLoginCall() {
  return (Store store) async {
    store.dispatch(ReLogin());
    store.dispatch(getWalletAddressesCall());
  };
}

ThunkAction syncContactsCall() {
  return (Store store) async {
    try {
      List<Contact> contacts = List.from(await Contacts.getContacts());
      store.dispatch(SaveContacts(contacts));
      List<String> syncedContacts = store.state.userState.syncedContacts;
      List<String> newPhones = <String>[];
      String countryCode = store.state.userState.countryCode;
      String isoCode = store.state.userState.isoCode;
      for (Contact contact in contacts) {
        Future<List<String>> phones = Future.wait(
          contact.phones!.map(
            (Item phone) async {
              String value = clearNotNumbersAndPlusSymbol(phone.value!);
              try {
                PhoneNumber phoneNumber = await phoneNumberUtil.parse(value);
                return phoneNumber.e164;
              } catch (e) {
                String formatted = formatPhoneNumber(value, countryCode);
                bool isValid = await phoneNumberUtil
                    .validate(
                      formatted,
                      regionCode: isoCode,
                    )
                    .catchError(
                      (error) => false,
                    );
                if (isValid) {
                  String phoneNum =
                      await phoneNumberUtil.format(formatted, isoCode);
                  PhoneNumber phoneNumber =
                      await phoneNumberUtil.parse(phoneNum);
                  return phoneNumber.e164;
                }
                return '';
              }
            },
          ),
        );
        List<String> result = await phones;
        result = result.toSet().toList()
          ..removeWhere((element) => element == '');
        for (String phone in result) {
          if (!syncedContacts.contains(phone)) {
            newPhones.add(phone);
          }
        }
      }
      if (newPhones.isEmpty) {
        dynamic response = await chargeApi.syncContacts(newPhones);
        store.dispatch(
          SyncContactsProgress(
            newPhones,
            List<Map<String, dynamic>>.from(
              response['newContacts'],
            ),
          ),
        );
        await chargeApi.ackSync(response['nonce']);
      } else {
        int limit = 100;
        List<String> partial = newPhones.take(limit).toList();
        while (partial.isNotEmpty) {
          dynamic response = await chargeApi.syncContacts(partial);
          store.dispatch(
            SyncContactsProgress(
              partial,
              List<Map<String, dynamic>>.from(
                response['newContacts'],
              ),
            ),
          );

          await chargeApi.ackSync(response['nonce']);
          newPhones = newPhones.sublist(partial.length);
          partial = newPhones.take(limit).toList();
        }
      }
    } catch (e, s) {
      log.error(
        'ERROR - syncContactsCall',
        error: e,
        stackTrace: s,
      );
    }
  };
}

ThunkAction identifyCall({String? wallet}) {
  return (Store store) async {
    UserState userState = store.state.userState;
    String displayName = userState.displayName;

    String phoneNumber = userState.phoneNumber;
    String walletAddress = wallet ?? userState.walletAddress;
    String accountAddress = userState.accountAddress;
    String identifier = userState.identifier;
    await getIt<FirebaseCrashlytics>().setUserIdentifier(phoneNumber);

    final Map<String, dynamic> properties = {
      'identifier': identifier,
      'phoneNumber': phoneNumber,
      'walletAddress': walletAddress,
      'accountAddress': accountAddress,
      'language': userState.locale.toString(),
      'displayName': displayName,
    };
    Analytics.identify(properties);
    Analytics.setUserId(phoneNumber);
    DateTime? installedAt = userState.installedAt;
    if (installedAt == null) {
      log.info('Identify - $phoneNumber');
      installedAt = DateTime.now().toUtc();
      store.dispatch(JustInstalled(installedAt));
    }
  };
}

ThunkAction saveUserProfile(walletAddress) {
  return (Store store) async {
    String displayName = store.state.userState.displayName;
    store.dispatch(storeUserContext());
    try {
      Map<String, dynamic> userProfile =
          await chargeApi.getUserProfile(walletAddress);
      if (userProfile.isNotEmpty) {
        if (userProfile.containsKey('avatarHash')) {
          store.dispatch(SetUserAvatar(userProfile['imageUri']));
        }
      }
    } catch (e) {
      Map user = {
        "accountAddress": walletAddress,
        "email": 'wallet-user@fuse.io',
        "provider": 'HDWallet',
        "subscribe": false,
        "source": 'wallet-v2',
        "displayName": displayName
      };
      await chargeApi.saveUserProfile(user);
    }
  };
}

ThunkAction storeUserContext() {
  return (Store store) async {
    try {
      await chargeApi.addUserContext({
        'os': Platform.isAndroid
            ? 'android'
            : Platform.isIOS
                ? 'ios'
                : 'other',
      });
    } catch (e, s) {
      log.error(
        'Error in api.addUserContext',
        error: e,
        stackTrace: s,
      );
    }
  };
}

ThunkAction loadContacts() {
  return (Store store) async {
    try {
      bool isPermitted = await Contacts.checkPermissions();
      if (isPermitted) {
        store.dispatch(syncContactsCall());
      }
    } catch (e, s) {
      log.error(
        'ERROR - load contacts',
        error: e,
        stackTrace: s,
      );
      Crashlytics.recordError(
        Exception('Error in load contacts: ${e.toString()}'),
        s,
        reason: 'ERROR in loadContacts',
      );
    }
  };
}

ThunkAction web3Init({
  WalletModules? modules,
}) {
  return (Store store) async {
    try {
      UserState userState = store.state.userState;
      final String privateKey = userState.privateKey;
      WalletModules? walletModules = modules ?? userState.walletModules;
      if (walletModules != null) {
        if (getIt.isRegistered<Web3>()) {
          await getIt.unregister(instance: getIt<Web3>());
        }
        getIt.registerSingleton<Web3>(Web3());
        await getIt<Web3>().setCredentials(privateKey);
        getIt<Web3>().setModules(walletModules);
      }
    } catch (e, s) {
      log.error(
        'ERROR - web3Init',
        error: e,
        stackTrace: s,
      );
      Crashlytics.recordError(
        Exception('Error in initiate Web3: ${e.toString()}'),
        s,
        reason: 'ERROR - web3Init',
      );
    }
  };
}

ThunkAction setupWalletCall(Map<String, dynamic> walletData) {
  return (Store store) async {
    try {
      final List<String> networks = List<String>.from(walletData['networks']);
      final String? contractVersion = walletData['version'];
      final String walletAddress = walletData['walletAddress'];
      final bool backup =
          walletData.containsKey('backup') ? walletData['backup'] : false;
      final WalletModules walletModules = WalletModules.fromJson(
        walletData['walletModules'],
      );
      store.dispatch(
        GetWalletDataSuccess(
          backup: backup,
          walletAddress: walletAddress,
          networks: networks,
          contractVersion: contractVersion,
          walletModules: walletModules,
        ),
      );
      store.dispatch(web3Init(modules: walletModules));
    } catch (e, s) {
      log.error(
        'ERROR - setupWalletCall',
        error: e,
        stackTrace: s,
      );
      Crashlytics.recordError(
        Exception('Error in setup wallet call: ${e.toString()}'),
        s,
        reason: 'ERROR - setupWalletCall',
      );
    }
  };
}

ThunkAction getWalletAddressesCall() {
  return (Store store) async {
    try {
      final dynamic walletData = await chargeApi.getWallet();
      final Map<String, dynamic> data = Map<String, dynamic>.from({
        ...walletData,
      });
      store.dispatch(setupWalletCall(data));
    } catch (e, s) {
      log.error(
        'ERROR - getWalletAddressCall',
        error: e,
        stackTrace: s,
      );
      Crashlytics.recordError(
        Exception('Error in get wallet info: ${e.toString()}'),
        s,
        reason: 'ERROR - getWalletAddressCall',
      );
    }
  };
}

ThunkAction updateDisplayNameCall(String displayName) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      if (walletAddress.isNotEmpty) {
        await chargeApi.updateDisplayName(walletAddress, displayName);
        store.dispatch(SetDisplayName(displayName));
      }
    } catch (e, s) {
      log.error(
        'ERROR - updateDisplayNameCall',
        error: e,
        stackTrace: s,
      );
      Crashlytics.recordError(
        Exception('Error in update user profile name: ${e.toString()}'),
        s,
        reason: 'Error in update user profile name',
      );
    }
  };
}

ThunkAction updateUserAvatarCall(ImageSource source) {
  return (Store store) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file != null) {
      try {
        final uploadResponse = await chargeApi.uploadImage(File(file.path));
        String walletAddress = store.state.userState.walletAddress;
        if (walletAddress.isNotEmpty) {
          await chargeApi.updateAvatar(walletAddress, uploadResponse['hash']);
          store.dispatch(SetUserAvatar(uploadResponse['uri']));
        }
      } catch (e, s) {
        log.error(
          'ERROR - updateUserAvatarCall',
          error: e,
          stackTrace: s,
        );
        Crashlytics.recordError(
          Exception('Error in update user profile image: ${e.toString()}'),
          s,
          reason: 'Error in update user profile image',
        );
      }
    }
  };
}

ThunkAction checkWalletUpgrades() {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      if (walletAddress.isNotEmpty) {
        final List<dynamic> response = await chargeApi.getAvailableUpgrades(
          walletAddress,
        );
        final List<WalletUpgrade> walletUpgrades =
            WalletUpgrade.walletUpgradesFromJson(
          response,
        );
        if (walletUpgrades.isNotEmpty) {
          store.dispatch(ToggleUpgrade(value: true));
        }
      }
    } catch (e, s) {
      log.error(
        'ERROR - checkWalletUpgrades',
        error: e,
        stackTrace: s,
      );
      Crashlytics.recordError(
        Exception('Error in check for new wallet upgrades: ${e.toString()}'),
        s,
        reason: 'Error in check for new wallet upgrades',
      );
    }
  };
}

ThunkAction installWalletUpgrades(
  VoidCallback onSuccess,
  VoidCallback onError,
) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      final List<dynamic> response =
          await chargeApi.getAvailableUpgrades(walletAddress);
      final List<WalletUpgrade> walletUpgrades =
          WalletUpgrade.walletUpgradesFromJson(response);
      if (walletUpgrades.isNotEmpty) {
        final WalletUpgrade walletUpgrade = walletUpgrades.first;
        final Map<String, dynamic> installUpgradeJob =
            await chargeApi.installUpgrades(
          getIt<Web3>(),
          walletAddress,
          store.state.userState.walletModules.transferManager,
          walletUpgrade.contractAddress,
          walletUpgrade.id,
        );
        store.dispatch(
          fetchJobCall(
            installUpgradeJob['_id'],
            (Map jobData) {
              log.info('txHash ${jobData['data']['txHash']}');
              store.dispatch(getWalletAddressesCall());
              onSuccess();
              store.dispatch(ToggleUpgrade(value: false));
              store.dispatch(checkWalletUpgrades());
            },
            (dynamic error) {
              Crashlytics.logMessage(
                  'Error while wallet upgrade ${error.toString()}');
              store.dispatch(ToggleUpgrade(value: false));
              onError();
            },
          ),
        );
      }
    } catch (e, s) {
      store.dispatch(ToggleUpgrade(value: false));
      onError();
      log.error(
        'ERROR - installWalletUpgrades',
        error: e,
        stackTrace: s,
      );
      Crashlytics.recordError(
        Exception('Error in install wallet upgrades: ${e.toString()}'),
        s,
        reason: 'Error in install wallet upgrades',
      );
    }
  };
}

ThunkAction fetchJobCall(
  String jobId,
  Function(Map jobData) successCallback,
  Function(dynamic jobData) failureCallback, {
  bool untilDone = true,
  int seconds = 5,
  Function(String txHash)? onTxCallback,
}) {
  return (Store store) {
    Timer.periodic(Duration(seconds: seconds), (Timer timer) async {
      try {
        log.info('jobId $jobId');
        dynamic response = await chargeApi.getJob(jobId);
        if (untilDone) {
          if (response['lastFinishedAt'] == null ||
              response['lastFinishedAt'].isEmpty) {
            log.info('job not done');
            return;
          }
        }
        final Map jobData = response['data'];
        if (jobData.containsKey('transactionBody')) {
          if ((jobData['transactionBody']['status'] != null &&
                  jobData['transactionBody']['status'] == 'failed') ||
              response['failReason'] != null) {
            final String failReason =
                response['failReason'] ?? jobData['transactionBody']['status'];
            log.info('JobId  $jobId failed, failReason: $failReason');
            if (jobData['txHash'] == null) {
              log.info('fetched job with txHash null');
              return;
            } else {
              onTxCallback?.call(jobData['txHash']);
            }
            failureCallback(failReason);
            timer.cancel();
          } else {
            if (jobData['txHash'] == null) {
              log.info('fetched job with txHash null');
              return;
            } else {
              onTxCallback?.call(jobData['txHash']);
            }
            successCallback(response);
            timer.cancel();
          }
        } else {
          if (jobData['txHash'] == null) {
            log.info('fetched job with txHash null');
            return;
          } else {
            onTxCallback?.call(jobData['txHash']);
          }
          successCallback(response);
          timer.cancel();
        }
      } catch (e) {
        log.error('ERROR - fetchJobCall $e');
        failureCallback(e.toString());
        timer.cancel();
      }
    });
  };
}
