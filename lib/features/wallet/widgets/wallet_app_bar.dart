import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';

import 'package:fusecash/features/home/widgets/balance.dart';
import 'package:fusecash/features/shared/widgets/add_cash.dart';

class WalletAppBar extends StatelessWidget {
  final EdgeInsetsGeometry? padding;

  const WalletAppBar({
    Key? key,
    this.padding = const EdgeInsets.only(
      left: 15,
      right: 15,
      top: 40,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: AutoSizeText(
                        I10n.of(context).your_balance,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        presetFontSizes: const [
                          28,
                          25,
                          22,
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Balance(),
                        Flexible(
                          child: AddCash(
                            fromScreen: 'Wallet',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
