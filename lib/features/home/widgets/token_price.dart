import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:decimal/decimal.dart';

import 'package:fusecash/services.dart';
import 'package:fusecash/utils/format.dart';

class TokenPrice extends StatelessWidget {
  final String address;
  const TokenPrice({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: 100,
        child: FutureBuilder<String>(
          future: chargeApi.price(address),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('..');
              case ConnectionState.waiting:
                return Row(
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
                final String quate =
                    Decimal.parse(snapshot.data ?? '0').toString();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: AutoSizeText(
                        '\$${Formatter.padZeroIfNeeded(
                          Decimal.parse(quate),
                        )}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 15,
                            ),
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              default:
                return Row(
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
            }
          },
        ),
      ),
    );
  }
}
