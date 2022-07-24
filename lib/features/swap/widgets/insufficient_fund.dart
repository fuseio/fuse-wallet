import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/I10n.dart';

class InsufficientFund extends StatelessWidget {
  final bool? hasFund;
  const InsufficientFund({
    this.hasFund,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasFund == null
        ? const SizedBox.shrink()
        : hasFund == true
            ? const SizedBox.shrink()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    I10n.of(context).insufficient_fund,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                ],
              );
  }
}
