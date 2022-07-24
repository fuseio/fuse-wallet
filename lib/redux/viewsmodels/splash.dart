import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';

import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

class SplashViewModel extends Equatable {
  final bool isLoggedOut;
  final Function() loginAgain;

  final Function(
    VoidCallback successCallback,
  ) createLocalAccount;

  const SplashViewModel({
    required this.isLoggedOut,
    required this.createLocalAccount,
    required this.loginAgain,
  });

  static SplashViewModel fromStore(Store<AppState> store) {
    return SplashViewModel(
      isLoggedOut: store.state.userState.isLoggedOut,
      createLocalAccount: (
        VoidCallback successCallback,
      ) {
        store.dispatch(
          createLocalAccountCall(
            successCallback,
          ),
        );
      },
      loginAgain: () {
        store.dispatch(reLoginCall());
      },
    );
  }

  @override
  List<Object?> get props => [];
}
