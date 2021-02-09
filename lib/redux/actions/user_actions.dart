import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/constants/variables.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/jobs/base.dart';
import 'package:fusecash/models/pro_wallet_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/pro_mode_wallet_actions.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/utils/contacts.dart';
import 'package:fusecash/utils/format.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_number/phone_number.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:wallet_core/wallet_core.dart';
import 'package:fusecash/services.dart';
// import 'package:fusecash/redux/state/store.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:fusecash/utils/phone.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:fusecash/utils/log/log.dart';

class CreateAccountWalletRequest {
  CreateAccountWalletRequest();
}

class CreateAccountWalletSuccess {
  CreateAccountWalletSuccess();
}

class UpdateCurrency {
  final String currency;
  UpdateCurrency({this.currency});
}

class UpdateTotalBalance {
  final num totalBalance;
  UpdateTotalBalance({this.totalBalance});
}

class HomeBackupDialogShowed {
  HomeBackupDialogShowed();
}

class ReceiveBackupDialogShowed {
  ReceiveBackupDialogShowed();
}

class DepositBannerShowed {
  DepositBannerShowed();
}

class SetSecurityType {
  BiometricAuth biometricAuth;
  SetSecurityType({this.biometricAuth});
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

class LoginRequestSuccess {
  final CountryCode countryCode;
  final String phoneNumber;
  final String displayName;
  final String email;
  LoginRequestSuccess({
    this.countryCode,
    this.phoneNumber,
    this.displayName,
    this.email,
  });
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
  final dynamic message;
  SetIsLoginRequest({this.isLoading, this.message});
}

class SetIsVerifyRequest {
  final bool isLoading;
  final dynamic message;
  SetIsVerifyRequest({this.isLoading, this.message});
}

class DeviceIdSuccess {
  final String identifier;
  DeviceIdSuccess(this.identifier);
}

ThunkAction loginHandler(CountryCode countryCode, PhoneNumber phoneNumber) {
  return (Store store) async {
    try {
      store.dispatch(SetIsLoginRequest(isLoading: true));
      String normalizedPhoneNumber = phoneNumber.e164;
      await onBoardStrategy.login(store, normalizedPhoneNumber);
      store.dispatch(LoginRequestSuccess(
        countryCode: countryCode,
        phoneNumber: phoneNumber.e164,
      ));
      store.dispatch(segmentAliasCall(normalizedPhoneNumber));
      store.dispatch(
        segmentTrackCall(
          "Wallet: user insert his phone number",
          properties: Map<String, dynamic>.from({
            "Phone number": normalizedPhoneNumber,
          }),
        ),
      );
    } catch (e, s) {
      store.dispatch(SetIsLoginRequest(isLoading: false, message: ''));
      log.error('ERROR - LoginRequest $e');
      await Sentry.captureException(e, stackTrace: s);
      store.dispatch(
        segmentTrackCall(
          "ERROR in LoginRequest",
          properties: Map.from({"error": e.toString()}),
        ),
      );
    }
  };
}

ThunkAction verifyHandler(String verificationCode) {
  return (Store store) async {
    try {
      final Function onSuccess = (jwtToken) {
        log.info('jwtToken $jwtToken');
        store.dispatch(LoginVerifySuccess(jwtToken));
        store.dispatch(SetIsVerifyRequest(isLoading: false));
        store.dispatch(segmentTrackCall("Wallet: verified phone number"));
        ExtendedNavigator.root.pushUserNameScreen();
      };
      await onBoardStrategy.verify(store, verificationCode, onSuccess);
    } catch (error, s) {
      store.dispatch(
          SetIsVerifyRequest(isLoading: false, message: error.message));
      await Sentry.captureException(error, stackTrace: s);
      store.dispatch(segmentTrackCall("ERROR in VerifyRequest",
          properties: Map.from({"error": error.toString()})));
    }
  };
}

ThunkAction setCountryCode(CountryCode countryCode) {
  return (Store store) async {
    String phone =
        '${countryCode.dialCode}${store.state.userState.phoneNumber}';
    PhoneNumber phoneNumber =
        await phoneNumberUtil.parse(phone, regionCode: countryCode.code);
    store.dispatch(SetIsoCode(
        countryCode: countryCode, normalizedPhoneNumber: phoneNumber.e164));
  };
}

ThunkAction backupWalletCall() {
  return (Store store) async {
    if (store.state.userState.backup) return;
    try {
      String communityAddress = store.state.cashWalletState.communityAddress;
      store.dispatch(BackupRequest());
      dynamic response =
          await api.backupWallet(communityAddress: communityAddress);
      dynamic jobId = response['job']['_id'];
      Community community =
          store.state.cashWalletState.communities[communityAddress];
      Token token =
          store.state.cashWalletState.tokens[community?.homeTokenAddress];
      if (community.plugins.backupBonus != null &&
          community.plugins.backupBonus.isActive &&
          ![null, ''].contains(jobId)) {
        BigInt value =
            toBigInt(community.plugins.backupBonus.amount, token.decimals);
        String walletAddress = store.state.userState.walletAddress;
        log.info('Job $jobId - sending backup bonus');
        final String tokenAddress = token.address;
        Transfer backupBonus = new Transfer(
          tokenAddress: token.address,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          from: DotEnv().env['FUNDER_ADDRESS'],
          to: walletAddress,
          text: 'You got a backup bonus!',
          type: 'RECEIVE',
          value: value,
          status: 'PENDING',
          jobId: jobId,
        );
        store.dispatch(AddTransaction(
            transaction: backupBonus, tokenAddress: tokenAddress));

        response['job']['arguments'] = {
          'backupBonus': backupBonus,
        };
        response['job']['jobType'] = 'backup';
        Job job = JobFactory.create(response['job']);
        store.dispatch(AddJob(job: job, tokenAddress: tokenAddress));
        store.dispatch(BackupSuccess());
      }
    } catch (e) {
      store.dispatch(BackupSuccess());
    }
  };
}

ThunkAction backupSuccessCall(Transfer transfer) {
  return (Store store) async {
    Transfer confirmedTx = transfer.copyWith(
        status: 'CONFIRMED', timestamp: DateTime.now().millisecondsSinceEpoch);
    store.dispatch(ReplaceTransaction(
        transactionToReplace: confirmedTx,
        transaction: transfer,
        tokenAddress: transfer.tokenAddress));
    store.dispatch(BackupSuccess());
    store.dispatch(segmentIdentifyCall(
        Map<String, dynamic>.from({'Wallet backed up success': true})));
    store.dispatch(segmentTrackCall('Wallet: backup success'));
  };
}

ThunkAction restoreWalletCall(
    List<String> _mnemonic, VoidCallback successCallback) {
  return (Store store) async {
    try {
      log.info('restore wallet');
      String mnemonic = _mnemonic.join(' ');
      log.info('mnemonic: $mnemonic');
      log.info('compute pk');
      String privateKey = await compute(Web3.privateKeyFromMnemonic, mnemonic);
      log.info('privateKey: $privateKey');
      Credentials credentials = EthPrivateKey.fromHex(privateKey);
      EthereumAddress accountAddress = await credentials.extractAddress();
      store.dispatch(CreateLocalAccountSuccess(
          mnemonic.split(' '), privateKey, accountAddress.toString()));
      store.dispatch(initWeb3Call(privateKey: privateKey));
      store.dispatch(segmentTrackCall("Wallet: restored mnemonic"));
      successCallback();
    } catch (e) {
      log.error('ERROR - restoreWalletCall $e');
    }
  };
}

ThunkAction setDeviceId() {
  return (Store store) async {
    String identifier = await FlutterUdid.udid;
    log.info("device identifier: $identifier");
    store.dispatch(DeviceIdSuccess(identifier));
  };
}

ThunkAction createLocalAccountCall(
    VoidCallback successCallback, VoidCallback errorCallback) {
  return (Store store) async {
    try {
      log.info('create wallet');
      String mnemonic = Web3.generateMnemonic();
      log.info('mnemonic: $mnemonic');
      log.info('compute pk');
      String privateKey = await compute(Web3.privateKeyFromMnemonic, mnemonic);
      log.info('privateKey: $privateKey');
      Credentials credentials = EthPrivateKey.fromHex(privateKey);
      EthereumAddress accountAddress = await credentials.extractAddress();
      store.dispatch(CreateLocalAccountSuccess(
          mnemonic.split(' '), privateKey, accountAddress.toString()));
      store.dispatch(initWeb3Call(privateKey: privateKey));
      store.dispatch(segmentTrackCall("Wallet: Create wallet"));
      successCallback();
    } catch (e, s) {
      log.error('ERROR - createLocalAccountCall $e');
      await Sentry.captureException(e, stackTrace: s);
      errorCallback();
    }
  };
}

ThunkAction logoutCall() {
  return (Store store) async {
    store.dispatch(LogoutRequestSuccess());
  };
}

ThunkAction reLoginCall() {
  return (Store store) async {
    store.dispatch(ReLogin());
    store.dispatch(segmentTrackCall("Wallet: Login clicked"));
  };
}

ThunkAction syncContactsCall(List<Contact> contacts) {
  return (Store store) async {
    try {
      store.dispatch(SaveContacts(contacts));
      List<String> syncedContacts = store.state.userState.syncedContacts;
      List<String> newPhones = List<String>();
      String countryCode = store.state.userState.countryCode;
      String isoCode = store.state.userState.isoCode;
      for (Contact contact in contacts) {
        Future<List<String>> phones =
            Future.wait(contact.phones.map((Item phone) async {
          String value = clearNotNumbersAndPlusSymbol(phone.value);
          try {
            PhoneNumber phoneNumber = await phoneNumberUtil.parse(value);
            return phoneNumber.e164;
          } catch (e) {
            String formatted = formatPhoneNumber(value, countryCode);
            bool isValid = await phoneNumberUtil.validate(formatted, isoCode);
            if (isValid) {
              String phoneNum =
                  await phoneNumberUtil.format(formatted, isoCode);
              PhoneNumber phoneNumber = await phoneNumberUtil.parse(phoneNum);
              return phoneNumber.e164;
            }
            return '';
          }
        }));
        List<String> result = await phones;
        result = result.toSet().toList()
          ..removeWhere((element) => element == '');
        for (String phone in result) {
          if (!syncedContacts.contains(phone)) {
            newPhones.add(phone);
          }
        }
      }
      if (newPhones.length == 0) {
        dynamic response = await api.syncContacts(newPhones);
        store.dispatch(SyncContactsProgress(newPhones,
            List<Map<String, dynamic>>.from(response['newContacts'])));
        await api.ackSync(response['nonce']);
      } else {
        int limit = 100;
        List<String> partial = newPhones.take(limit).toList();
        while (partial.length > 0) {
          dynamic response = await api.syncContacts(partial);
          store.dispatch(SyncContactsProgress(partial,
              List<Map<String, dynamic>>.from(response['newContacts'])));

          await api.ackSync(response['nonce']);
          newPhones = newPhones.sublist(partial.length);
          partial = newPhones.take(limit).toList();
        }
      }
    } catch (e) {
      log.error('ERROR - syncContactsCall $e');
    }
  };
}

ThunkAction identifyCall() {
  return (Store store) async {
    store.dispatch(segmentIdentifyCall(Map<String, dynamic>.from({
      "Phone Number": store.state.userState.phoneNumber ?? '',
      "Wallet Address": store.state.userState.walletAddress,
      "Account Address": store.state.userState.accountAddress,
      "Display Name": store.state.userState.displayName,
      "Identifier": store.state.userState.identifier,
      "Joined Communities":
          store.state.cashWalletState.communities.keys.toList(),
    })));
  };
}

ThunkAction saveUserInDB(walletAddress) {
  return (Store store) async {
    String displayName = store.state.userState.displayName;
    try {
      Map user = {
        "accountAddress": walletAddress,
        "email": 'wallet-user@fuse.io',
        "provider": 'HDWallet',
        "subscribe": false,
        "source": 'wallet-v2',
        "displayName": displayName
      };
      await api.saveUserToDb(user);
      log.info('save user $walletAddress');
    } catch (e) {
      log.error('user $walletAddress already saved');
    }
  };
}

ThunkAction loadContacts() {
  return (Store store) async {
    try {
      bool isPermitted = await Contacts.checkPermissions();
      if (isPermitted) {
        log.info('Start - load contacts');
        List<Contact> contacts = await Contacts.getContacts();
        log.info('Done - load contacts');
        store.dispatch(syncContactsCall(contacts));
      }
    } catch (error) {
      log.error('ERROR - load contacts $error');
    }
  };
}

ThunkAction updateTotalBalance() {
  return (Store store) async {
    try {
      ProWalletState proWalletState = store.state.proWalletState;
      num combiner(num previousValue, Token token) => token?.priceInfo != null
          ? previousValue +
              num.parse(Decimal.parse(token?.priceInfo?.total).toString())
          : previousValue + 0;
      List<Token> foreignTokens = List<Token>.from(
              proWalletState.erc20Tokens?.values ?? Iterable.empty())
          .where((Token token) =>
              num.parse(formatValue(token.amount, token.decimals,
                      withPrecision: true))
                  .compareTo(0) ==
              1)
          .toList();
      List<Token> allTokens = [...foreignTokens];
      num value = allTokens.fold<num>(0, combiner);
      store.dispatch(UpdateTotalBalance(totalBalance: value));
    } catch (error) {
      log.error('ERROR while update total balance $error');
    }
  };
}

ThunkAction setupWalletCall(walletData) {
  return (Store store) async {
    try {
      List<String> networks = List<String>.from(walletData['networks']);
      String walletAddress = walletData['walletAddress'];
      bool backup = walletData['backup'];
      String communityManagerAddress = walletData['communityManager'];
      String transferManagerAddress = walletData['transferManager'];
      String dAIPointsManagerAddress = walletData['dAIPointsManager'];
      store.dispatch(GetWalletAddressesSuccess(
        backup: backup,
        walletAddress: walletAddress,
        daiPointsManagerAddress: dAIPointsManagerAddress,
        communityManagerAddress: communityManagerAddress,
        transferManagerAddress: transferManagerAddress,
        networks: networks,
      ));
      store.dispatch(initWeb3Call(
        communityManagerAddress: communityManagerAddress,
        transferManagerAddress: transferManagerAddress,
        dAIPointsManagerAddress: dAIPointsManagerAddress,
      ));
      if (networks.contains(foreignNetwork)) {
        store.dispatch(initWeb3ProMode());
        Future.delayed(Duration(seconds: Variables.INTERVAL_SECONDS), () {
          store.dispatch(startListenToTransferEvents());
          store.dispatch(startFetchBalancesOnForeign());
          store.dispatch(fetchTokensBalances());
          store.dispatch(startFetchTransferEventsCall());
          store.dispatch(startFetchTokensLastestPrices());
          store.dispatch(startProcessingTokensJobsCall());
        });
      } else {
        store.dispatch(createForiegnWalletOnlyIfNeeded());
      }
    } catch (e) {
      log.error('ERROR - getWalletAddressCall $e');
    }
  };
}

ThunkAction getWalletAddressessCall() {
  return (Store store) async {
    try {
      dynamic walletData = await api.getWallet();
      store.dispatch(setupWalletCall(walletData));
    } catch (e) {
      log.error('ERROR - getWalletAddressCall $e');
    }
  };
}

ThunkAction createForiegnWalletOnlyIfNeeded() {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      List transfersEvents = await ethereumExplorerApi
          .getTransferEventsByAccountAddress(walletAddress);
      if (transfersEvents.isNotEmpty) {
        dynamic response = await api.createWalletOnForeign(force: true);
        String jobId = response['job']['_id'];
        log.info('Create wallet on foreign jobId - $jobId');
        store.dispatch(initWeb3ProMode());
        Future.delayed(Duration(seconds: Variables.INTERVAL_SECONDS), () {
          store.dispatch(startListenToTransferEvents());
          store.dispatch(startFetchBalancesOnForeign());
          store.dispatch(fetchTokensBalances());
          store.dispatch(startFetchTransferEventsCall());
          store.dispatch(startFetchTokensLastestPrices());
          store.dispatch(startProcessingTokensJobsCall());
        });
        store.dispatch(segmentIdentifyCall(Map<String, dynamic>.from({
          "Pro mode active": true,
        })));
      }
    } catch (e) {
      log.error('ERROR - createForiegnWallet $e');
    }
  };
}

ThunkAction updateDisplayNameCall(String displayName) {
  return (Store store) async {
    try {
      String accountAddress = store.state.userState.accountAddress;
      await api.updateDisplayName(accountAddress, displayName);
      store.dispatch(SetDisplayName(displayName));
      store.dispatch(segmentTrackCall("Wallet: display name updated"));
      store.dispatch(segmentIdentifyCall(Map<String, dynamic>.from({
        "Display Name": displayName,
      })));
    } catch (e) {}
  };
}

ThunkAction updateUserAvatarCall(ImageSource source) {
  return (Store store) async {
    final picker = ImagePicker();
    final file = await picker.getImage(source: source);
    try {
      final uploadResponse = await api.uploadImage(File(file.path));
      String accountAddress = store.state.userState.accountAddress;
      await api.updateAvatar(accountAddress, uploadResponse['hash']);
      store.dispatch(SetUserAvatar(uploadResponse['uri']));
      store.dispatch(segmentTrackCall("User avatar updated"));
    } catch (e) {}
  };
}
