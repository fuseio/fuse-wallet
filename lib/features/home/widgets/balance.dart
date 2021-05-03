import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/redux/viewsmodels/balance.dart';
import 'package:fusecash/models/app_state.dart';

class Balance extends StatelessWidget {
  const Balance({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BalanceViewModel>(
      distinct: true,
      converter: BalanceViewModel.fromStore,
      builder: (_, viewModel) {
        return Flexible(
          child: AutoSizeText(
            '\$${viewModel?.usdValue ?? '0'}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            presetFontSizes: [
              30,
              25,
              22,
            ],
          ),
        );
      },
    );
  }
}
