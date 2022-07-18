import 'dart:core';

import 'package:flutter/material.dart';

import 'package:decimal/decimal.dart';

class PercentageActionBar extends StatelessWidget
    implements PreferredSizeWidget {
  final FocusNode node;
  final Decimal available;
  final void Function(String value)? onTap;

  const PercentageActionBar({
    Key? key,
    required this.node,
    required this.available,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Row(
              children: [
                item(context, '25'),
                const SizedBox(
                  width: 5,
                ),
                item(context, '50'),
                const SizedBox(
                  width: 5,
                ),
                item(context, '75'),
                const SizedBox(
                  width: 5,
                ),
                item(context, '100'),
              ],
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => node.unfocus(),
        )
      ],
    );
  }

  Widget item(context, String value) {
    final bool isMax = value == '100';
    return InkWell(
      splashColor: Theme.of(context).canvasColor,
      hoverColor: Theme.of(context).canvasColor,
      focusColor: Theme.of(context).canvasColor,
      highlightColor: Theme.of(context).canvasColor,
      onTap: () {
        final Decimal part =
            (Decimal.parse(value) / Decimal.fromInt(100)).toDecimal() *
                available;
        onTap?.call(part.toString());
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              20.0,
            ),
          ),
          color: Theme.of(context).colorScheme.onSurface,
        ),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * .19,
        height: 26,
        child: Center(
          child: Text(
            isMax ? 'Max' : '$value%',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).canvasColor,
                ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(45);
}
