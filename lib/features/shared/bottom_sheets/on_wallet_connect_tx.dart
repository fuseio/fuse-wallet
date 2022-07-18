import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:fusecash/features/shared/widgets/wallet_connect_actions.dart';
import 'package:fusecash/features/shared/widgets/wallet_connect_logos.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:fusecash/utils/format.dart';

class OnTransactionBottomSheet extends StatelessWidget {
  final VoidCallback onApprove;
  final VoidCallback onReject;
  final String? to;
  final String? value;

  const OnTransactionBottomSheet({
    Key? key,
    required this.to,
    required this.value,
    required this.onApprove,
    required this.onReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const WalletConnectLogos(),
            const SizedBox(height: 20),
            Text(
              I10n.of(context).would_you_like_to_approve_tx,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            YesOrNoActions(
              to: to,
              value: Formatter.amountPrinter(
                BigInt.parse(
                  value ?? '0',
                ),
                fuseToken.decimals,
                null,
              ),
              onApprove: onApprove,
              onReject: onReject,
            ),
          ],
        ),
      ),
    );
  }
}

extension OnTransactionBottomSheetExtension on OnTransactionBottomSheet {
  Future<T?> showSheet<T>(BuildContext context) => showBarModalBottomSheet(
        useRootNavigator: true,
        context: context,
        enableDrag: true,
        builder: (context) => this,
      );
}
