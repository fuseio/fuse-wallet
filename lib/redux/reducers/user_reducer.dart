import 'package:flutter/foundation.dart';
import 'package:fusecash/models/user_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/utils/did/did_service.dart';
import 'package:redux/redux.dart';

final userReducers = combineReducers<UserState>([
  TypedReducer<UserState, SetWalletConnectURI>(
    _setWalletConnectURI,
  ),
  TypedReducer<UserState, GetWalletDataSuccess>(_getWalletDataSuccess),
  TypedReducer<UserState, ScrollToTop>(_scrollToTop),
  TypedReducer<UserState, ToggleUpgrade>(_toggleUpgrade),
  TypedReducer<UserState, CreateLocalAccountSuccess>(_createNewWalletSuccess),
  TypedReducer<UserState, GenerateDIDSuccess>(_generateDIDSuccess),
  TypedReducer<UserState, IssueUserInfoVCSuccess>(_issueUserInfoVCSuccess),
  TypedReducer<UserState, LoginRequestSuccess>(_loginSuccess),
  TypedReducer<UserState, LoginVerifySuccess>(_loginVerifySuccess),
  TypedReducer<UserState, LogoutRequestSuccess>(_logoutSuccess),
  TypedReducer<UserState, SyncContactsProgress>(_syncContactsProgress),
  TypedReducer<UserState, SyncContactsRejected>(_syncContactsRejected),
  TypedReducer<UserState, SaveContacts>(_saveContacts),
  TypedReducer<UserState, SetPincodeSuccess>(_setPincode),
  TypedReducer<UserState, SetDisplayName>(_setDisplayName),
  TypedReducer<UserState, SetUserAvatar>(_setUserAvatar),
  TypedReducer<UserState, ReLogin>(_reLoginUser),
  TypedReducer<UserState, BackupSuccess>(_backupSuccess),
  TypedReducer<UserState, SetCredentials>(_setCredentials),
  TypedReducer<UserState, SetVerificationId>(_setVerificationId),
  TypedReducer<UserState, JustInstalled>(_justInstalled),
  TypedReducer<UserState, DeviceIdSuccess>(_deviceIdSuccess),
  TypedReducer<UserState, SetSecurityType>(_setSecurityType),
  TypedReducer<UserState, WarnSendDialogShowed>(_warnSendDialogShowed),
  TypedReducer<UserState, UpdateCurrency>(_updateCurrency),
  TypedReducer<UserState, UpdateLocale>(_updateLocale),
]);

UserState _setWalletConnectURI(UserState state, SetWalletConnectURI action) {
  return state.copyWith(wcURI: action.wcURI);
}

UserState _scrollToTop(UserState state, ScrollToTop action) {
  return state.copyWith(scrollToTop: action.value);
}

UserState _toggleUpgrade(UserState state, ToggleUpgrade action) {
  return state.copyWith(
    hasUpgrade: action.value,
  );
}

UserState _updateLocale(UserState state, UpdateLocale action) {
  return state.copyWith(locale: action.locale);
}

UserState _updateCurrency(UserState state, UpdateCurrency action) {
  return state.copyWith(currency: action.currency);
}

UserState _warnSendDialogShowed(UserState state, WarnSendDialogShowed action) {
  return state.copyWith(
    warnSendDialogShowed: action.value,
  );
}

UserState _setSecurityType(UserState state, SetSecurityType action) {
  return state.copyWith(
    authType: action.biometricAuth,
  );
}

UserState _getWalletDataSuccess(UserState state, GetWalletDataSuccess action) {
  return state.copyWith(
    backup: action.backup,
    networks: action.networks,
    walletAddress: action.walletAddress,
    walletModules: action.walletModules,
    contractVersion: action.contractVersion,
  );
}

UserState _generateDIDSuccess(UserState state, GenerateDIDSuccess action) {
  return state.copyWith(
    did: action.did,
    privateKeyForDID: action.privateKeyForDID,
  );
}

UserState _issueUserInfoVCSuccess(
  UserState state,
  IssueUserInfoVCSuccess action,
) {
  return state.copyWith(userInfoVC: action.userInfoVC);
}

UserState _backupSuccess(UserState state, BackupSuccess action) {
  return state.copyWith(backup: true);
}

UserState _reLoginUser(UserState state, ReLogin action) {
  return state.copyWith(isLoggedOut: false);
}

UserState _createNewWalletSuccess(
  UserState state,
  CreateLocalAccountSuccess action,
) {
  return UserState(
    isLoggedOut: false,
    mnemonic: action.mnemonic,
    privateKey: action.privateKey,
    accountAddress: action.accountAddress,
    did: action.did,
    privateKeyForDID: action.privateKeyForDID,
  );
}

UserState _loginSuccess(UserState state, LoginRequestSuccess action) {
  return state.copyWith(
    countryCode: action.countryCode.dialCode!,
    isoCode: action.countryCode.code!,
    phoneNumber: action.phoneNumber,
  );
}

UserState _setVerificationId(UserState state, SetVerificationId action) {
  return state.copyWith(
    verificationId: action.verificationId,
  );
}

UserState _loginVerifySuccess(UserState state, LoginVerifySuccess action) {
  return state.copyWith(
    jwtToken: action.jwtToken,
  );
}

UserState _logoutSuccess(UserState state, LogoutRequestSuccess action) {
  return state.copyWith(isLoggedOut: true);
  // return UserState.initial();
}

// UserState _logoutSuccess(UserState state, LogoutRequestSuccess action) {
//   return UserState.initial();
// }

UserState _syncContactsRejected(UserState state, SyncContactsRejected action) {
  return state.copyWith(isContactsSynced: false);
}

UserState _setDisplayName(UserState state, SetDisplayName action) {
  return state.copyWith(displayName: action.displayName);
}

UserState _setUserAvatar(UserState state, SetUserAvatar action) {
  return state.copyWith(avatarUrl: action.avatarUrl);
}

UserState _syncContactsProgress(UserState state, SyncContactsProgress action) {
  Map<String, String> reverseContacts = Map<String, String>.from(
    state.reverseContacts,
  );
  Iterable<MapEntry<String, String>> entries = action.newContacts.map(
    (entry) => MapEntry(
      entry['walletAddress'].toString().toLowerCase(),
      entry['phoneNumber'],
    ),
  );
  reverseContacts.addEntries(entries);
  List<String> syncedContacts = List<String>.from(state.syncedContacts);
  syncedContacts.addAll(action.contacts);
  return state.copyWith(
    reverseContacts: reverseContacts,
    syncedContacts: syncedContacts,
  );
}

UserState _saveContacts(UserState state, SaveContacts action) {
  return state.copyWith(contacts: action.contacts, isContactsSynced: true);
}

UserState _setPincode(UserState state, SetPincodeSuccess action) {
  return state.copyWith(pincode: action.pincode);
}

UserState _setCredentials(UserState state, SetCredentials action) {
  return state.copyWith(credentials: action.credentials);
}

UserState _justInstalled(UserState state, JustInstalled action) {
  return state.copyWith(installedAt: action.installedAt);
}

UserState _deviceIdSuccess(UserState state, DeviceIdSuccess action) {
  return state.copyWith(identifier: action.identifier);
}
