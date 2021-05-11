import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/settings.dart';
import 'package:fusecash/widgets/my_scaffold.dart';

class EarnScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).settings,
      body: StoreConnector<AppState, SettingsViewModel>(
        distinct: true,
        converter: SettingsViewModel.fromStore,
        builder: (_, viewModel) => Container(
          padding: EdgeInsets.all(20),
          child: SizedBox.shrink(),
        ),
      ),
    );
  }
}
