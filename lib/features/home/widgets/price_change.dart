import 'package:flutter/material.dart';

import 'package:decimal/decimal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:number_display/number_display.dart';

import 'package:fusecash/services.dart';

final display = createDisplay(decimal: 2);

class TokenPriceChange extends StatelessWidget {
  final String address;
  const TokenPriceChange({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle? runTextStyle =
        Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF292929),
            );
    return Flexible(
      child: SizedBox(
        width: 80,
        child: FutureBuilder<String>(
          future: chargeApi.priceChange(address),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('..');
              case ConnectionState.waiting:
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                );
              case ConnectionState.active:
                return const Text('..');
              case ConnectionState.done:
                final num priceChange =
                    num.parse(Decimal.parse(snapshot.data!).toString());
                final value = display(priceChange);
                if (priceChange.toStringAsFixed(2).startsWith('0.00') ||
                    priceChange.toStringAsFixed(2).startsWith('-0.00')) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$value%',
                        style: runTextStyle,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  );
                }
                if (priceChange.isNegative) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$value%',
                        style: runTextStyle,
                      ),
                      const SizedBox(
                        width: 2.5,
                      ),
                      SvgPicture.asset(
                        'assets/images/percent_down.svg',
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$value%',
                        style: runTextStyle,
                      ),
                      const SizedBox(
                        width: 2.5,
                      ),
                      SvgPicture.asset(
                        'assets/images/percent_up.svg',
                      ),
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
