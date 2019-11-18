import 'package:fusecash/redux/state/user_state.dart';

class AppState {
  final UserState userState;

  AppState({
    this.userState
  });

  factory AppState.initial() {
    return AppState(
      userState: UserState.initial()
    );
  }

  AppState copyWith(
    UserState userState
  ) {
    return AppState(
      userState: userState ?? this.userState
    );
  }

  static AppState fromJson(dynamic json) {
    AppState();
  }

  dynamic toJson() => {
    'userState': null
  };
}
