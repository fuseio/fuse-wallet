import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/I10n.dart';

import 'package:fusecash/features/shared/bottom_sheets/deposit.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';

class AddCash extends StatelessWidget {
  final String fromScreen;
  const AddCash({
    Key? key,
    required this.fromScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      width: 120,
      textColor: Theme.of(context).canvasColor,
      text: I10n.of(context).add_cash,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
      icon: Image.asset(
        'assets/images/add_cash.png',
        height: 25,
        width: 25,
      ),
      onPressed: () {
        const DepositBottomSheet().showSheet(
          context,
          fromScreen,
        );
      },
    );
  }
}
