import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/models/user_state.dart';
import 'package:redux/redux.dart';

final userReducers = combineReducers<UserState>([
  TypedReducer<UserState, RestoreWalletSuccess>(_restoreWalletSuccess),
  TypedReducer<UserState, CreateNewWalletSuccess>(_createNewWalletSuccess),
  TypedReducer<UserState, LoginRequestSuccess>(_loginSuccess),
  TypedReducer<UserState, LoginVerifySuccess>(_loginVerifySuccess),
  TypedReducer<UserState, LogoutRequestSuccess>(_logoutSuccess),
  TypedReducer<UserState, SyncContactsSuccess>(_syncContactsSuccess)
]);

UserState _restoreWalletSuccess(UserState state, RestoreWalletSuccess action) {
  return state.copyWith(
      mnemonic: action.mnemonic, privateKey: action.privateKey);
}

UserState _createNewWalletSuccess(
    UserState state, CreateNewWalletSuccess action) {
  return state.copyWith(
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
  return UserState.initial();
}

UserState _syncContactsSuccess(UserState state, SyncContactsSuccess action) {
  Map<String, String> reverseContacts = Map<String, String>.from(state.reverseContacts);
  Iterable<MapEntry<String, String>> entries = action.newContacts.map((entry) => new MapEntry(entry['walletAddress'], entry['phoneNumber']));
  reverseContacts.addEntries(entries);
  return state.copyWith(reverseContacts: reverseContacts, contacts: action.contacts);
}
