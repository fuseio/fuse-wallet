import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';

class LanguageSelectorViewModel {
  final Function(Locale) updateLocale;
  LanguageSelectorViewModel({
    required this.updateLocale,
  });

  static LanguageSelectorViewModel fromStore(Store<AppState> store) {
    return LanguageSelectorViewModel(
      updateLocale: (Locale locale) {
        store.dispatch(UpdateLocale(locale: locale));
      },
    );
  }
}
