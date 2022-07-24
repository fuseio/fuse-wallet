import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/balance.dart';

class BalanceTitle extends StatelessWidget {
  const BalanceTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BalanceViewModel>(
      distinct: true,
      converter: BalanceViewModel.fromStore,
      builder: (_, viewModel) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${I10n.of(context).balance}: ',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Flexible(
              child: AutoSizeText(
                '\$${viewModel.usdValue}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
