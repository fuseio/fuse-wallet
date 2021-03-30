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
        final hasToken = viewModel.token != null;
        return viewModel.hasErc20Tokens
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '\$${viewModel?.usdValue ?? '0'}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : AutoSizeText.rich(
                TextSpan(
                  style: TextStyle(
                    fontFamily: 'Europa',
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  children: !hasToken
                      ? <TextSpan>[
                          TextSpan(
                            text: "\$0",
                          )
                        ]
                      : <TextSpan>[
                          TextSpan(
                            text: viewModel.token.getBalance(),
                          ),
                          TextSpan(
                            text: ' ' + viewModel.token?.symbol.toString(),
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                ),
                minFontSize: 30,
                maxFontSize: 32,
                maxLines: 1,
                style: TextStyle(
                  // fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              );
      },
    );
  }
}
