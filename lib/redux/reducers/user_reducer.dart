import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/models/user_state.dart';
import 'package:redux/redux.dart';

final userReducers = combineReducers<UserState>([
  TypedReducer<UserState, GetWalletAddressesSuccess>(
      _getWalletAddressesSuccess),
  TypedReducer<UserState, CreateLocalAccountSuccess>(_createNewWalletSuccess),
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
  TypedReducer<UserState, SetIsLoginRequest>(_setIsLoginRequest),
  TypedReducer<UserState, SetIsVerifyRequest>(_setIsVerifyRequest),
  TypedReducer<UserState, DeviceIdSuccess>(_deviceIdSuccess),
  TypedReducer<UserState, SetSecurityType>(_setSecurityType),
  TypedReducer<UserState, ReceiveBackupDialogShowed>(
      _receiveBackupDialogShowed),
  TypedReducer<UserState, DepositBannerShowed>(_depositBannerShowed),
  TypedReducer<UserState, HomeBackupDialogShowed>(_homeBackupDialogShowed),
  TypedReducer<UserState, WarnSendDialogShowed>(_warnSendDialogShowed),
  TypedReducer<UserState, UpdateCurrency>(_updateCurrency),
  TypedReducer<UserState, UpdateLocale>(_updateLocale),
]);

UserState _updateLocale(UserState state, UpdateLocale action) {
  return state.copyWith(locale: action.locale);
}

UserState _updateCurrency(UserState state, UpdateCurrency action) {
  return state.copyWith(currency: action.currency);
}

UserState _receiveBackupDialogShowed(
    UserState state, ReceiveBackupDialogShowed action) {
  return state.copyWith(receiveBackupDialogShowed: true);
}

UserState _depositBannerShowed(UserState state, DepositBannerShowed action) {
  return state.copyWith(depositBannerShowed: true);
}

UserState _homeBackupDialogShowed(
    UserState state, HomeBackupDialogShowed action) {
  return state.copyWith(homeBackupDialogShowed: true);
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

UserState _getWalletAddressesSuccess(
    UserState state, GetWalletAddressesSuccess action) {
  return state.copyWith(
    backup: action.backup,
    networks: action.networks,
    walletAddress: action.walletAddress,
  );
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
    (entry) => new MapEntry(
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

UserState _setIsLoginRequest(UserState state, SetIsLoginRequest action) {
  return state.copyWith(
    isLoginRequest: action.isLoading,
    signupErrorMessage: action.message,
  );
}

UserState _setIsVerifyRequest(UserState state, SetIsVerifyRequest action) {
  return state.copyWith(
    isVerifyRequest: action.isLoading,
    verifyErrorMessage: action.message,
  );
}

UserState _deviceIdSuccess(UserState state, DeviceIdSuccess action) {
  return state.copyWith(identifier: action.identifier);
}
