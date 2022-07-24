import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/features/shared/bottom_sheets/deposit.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/topup_your_account.dart';

class TopupYourAccount extends StatelessWidget {
  const TopupYourAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TopupYourAccountViewModel>(
      distinct: true,
      converter: TopupYourAccountViewModel.fromStore,
      builder: (_, viewModel) {
        return Flexible(
          child: !viewModel.hasFUSD
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        const DepositBottomSheet().showSheet(
                          context,
                          'swapScreen',
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: AutoSizeText.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '${I10n.of(context).your_balance_is_empty} ',
                                  ),
                                  TextSpan(
                                    text: I10n.of(context).top_up_your_account,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                ],
                              ),
                              presetFontSizes: const [15, 14, 13],
                            ),
                          ),
                          Icon(
                            Icons.arrow_right_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
