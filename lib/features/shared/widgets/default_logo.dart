import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

class DefaultLogo extends StatelessWidget {
  final String symbol;
  final double width;
  final double height;

  const DefaultLogo({
    required this.height,
    required this.width,
    required this.symbol,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: AutoSizeText(
              symbol,
              style: Theme.of(context).textTheme.labelMedium,
              presetFontSizes: const [
                13,
                12,
                11,
              ],
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
