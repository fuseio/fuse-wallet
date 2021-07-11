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
                  color: Theme.of(context).canvasColor.withAlpha(150),
                  fontSize: 13.0,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Flexible(
                  child: AutoSizeText(
                    viewModel.token == null
                        ? '\$${viewModel.usdValue}'
                        : viewModel.token!.getBalance(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).canvasColor,
                    ),
                    presetFontSizes: [30, 25, 24, 23, 22],
                    maxLines: 1,
                  ),
                ),
                viewModel.token == null
                    ? SizedBox.shrink()
                    : Flexible(
                        child: Text(
                          ' ${viewModel.token?.symbol ?? ''}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        );
      },
    );
  }
}
