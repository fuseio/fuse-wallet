import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/constants/analytics_props.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/balance.dart';
import 'package:fusecash/utils/analytics/analytics.dart';

class Balance extends StatelessWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BalanceViewModel>(
      distinct: true,
      converter: BalanceViewModel.fromStore,
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.usdValue != newViewModel.usdValue) {
          Analytics.identify({
            AnalyticsProps.humanAmount: newViewModel.usdValue,
          });
        }
      },
      builder: (_, viewModel) => Flexible(
        child: AutoSizeText(
          '\$${viewModel.usdValue}',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          presetFontSizes: const [
            28,
            25,
            22,
          ],
        ),
      ),
    );
  }
}
