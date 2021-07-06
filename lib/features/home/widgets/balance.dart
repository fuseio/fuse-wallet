import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/redux/viewsmodels/balance.dart';
import 'package:fusecash/models/app_state.dart';

class Balance extends StatelessWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BalanceViewModel>(
      distinct: true,
      converter: BalanceViewModel.fromStore,
      builder: (_, viewModel) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Flexible(
              child: Text(
                I10n.of(context).balance,
                style: TextStyle(
                  color: Color(0xFF454545),
                  fontSize: 13.0,
                ),
              ),
            ),
            Flexible(
              child: AutoSizeText(
                '\$${viewModel.usdValue}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                presetFontSizes: [
                  30,
                  25,
                  22,
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
