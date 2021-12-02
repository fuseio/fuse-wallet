import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:supervecina/generated/l10n.dart';
import 'package:supervecina/redux/viewsmodels/balance.dart';
import 'package:supervecina/models/app_state.dart';

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
                  color: Theme.of(context).canvasColor,
                  fontSize: 13.0,
                ),
              ),
            ),
            Flexible(
              child: AutoSizeText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: viewModel.token.getBalance(),
                      style: TextStyle(
                        fontSize: 32,
                        color: Theme.of(context).canvasColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' ${viewModel.token.symbol}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).canvasColor,
                        fontWeight: FontWeight.normal,
                        height: 0.0,
                      ),
                    ),
                  ],
                ),
              ),
              // child: AutoSizeText(
              //   viewModel.token.getBalance(),
              //   style: TextStyle(
              //     color: Theme.of(context).canvasColor,
              //     fontWeight: FontWeight.bold,
              //   ),
              //   presetFontSizes: [
              //     30,
              //     25,
              //     22,
              //   ],
              // ),
            ),
          ],
        );
      },
    );
  }
}
