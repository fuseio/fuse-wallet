import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/models/user_state.dart';
import 'package:redux/redux.dart';

final userReducers = combineReducers<UserState>([
  TypedReducer<UserState, RestoreWalletSuccess>(_restoreWalletSuccess),
  TypedReducer<UserState, createLocalAccountSuccess>(_createNewWalletSuccess),
  TypedReducer<UserState, LoginRequestSuccess>(_loginSuccess),
  TypedReducer<UserState, LoginVerifySuccess>(_loginVerifySuccess),
  TypedReducer<UserState, LogoutRequestSuccess>(_logoutSuccess),
  TypedReducer<UserState, SyncContactsProgress>(_syncContactsProgress),
  TypedReducer<UserState, SaveContacts>(_saveContacts),
  TypedReducer<UserState, SetPincodeSuccess>(_setPincode)
]);

UserState _restoreWalletSuccess(UserState state, RestoreWalletSuccess action) {
  return state.copyWith(
      mnemonic: action.mnemonic, privateKey: action.privateKey);
}

UserState _createNewWalletSuccess(
    UserState state, createLocalAccountSuccess action) {
  UserState newState = UserState.initial();
  return newState.copyWith(
      isLoggedOut: false,
      mnemonic: action.mnemonic,
      privateKey: action.privateKey,
      accountAddress: action.accountAddress);
}

UserState _loginSuccess(UserState state, LoginRequestSuccess action) {
  return state.copyWith(
      countryCode: action.countryCode,
      phoneNumber: action.phoneNumber,
      fullName: action.fullName,
      email: action.email,
      loginRequestSuccess: true);
}

UserState _loginVerifySuccess(UserState state, LoginVerifySuccess action) {
  return state.copyWith(jwtToken: action.jwtToken, loginVerifySuccess: true);
}

UserState _logoutSuccess(UserState state, LogoutRequestSuccess action) {
  return state.copyWith(isLoggedOut: true);
  // return UserState.initial();
}

// UserState _logoutSuccess(UserState state, LogoutRequestSuccess action) {
//   return UserState.initial();
// }

UserState _syncContactsProgress(UserState state, SyncContactsProgress action) {
  Map<String, String> reverseContacts =
      Map<String, String>.from(state.reverseContacts);
  Iterable<MapEntry<String, String>> entries = action.newContacts.map((entry) =>
      new MapEntry(entry['walletAddress'].toString().toLowerCase(),
          entry['phoneNumber']));
  reverseContacts.addEntries(entries);
  List<String> syncedContacts = List<String>.from(state.syncedContacts);
  syncedContacts.addAll(action.contacts);
  return state.copyWith(
      reverseContacts: reverseContacts, syncedContacts: syncedContacts);
}

UserState _saveContacts(UserState state, SaveContacts action) {
  return state.copyWith(contacts: action.contacts);
}

UserState _setPincode(UserState state, SetPincodeSuccess action) {
  return state.copyWith(pincode: action.pincode);
}
