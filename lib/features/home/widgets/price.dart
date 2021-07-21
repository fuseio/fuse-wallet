import 'package:flutter/material.dart';
import 'package:fusecash/models/tokens/price.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/format.dart';
import 'package:number_display/number_display.dart';

final Display display2 = createDisplay(
  decimal: 6,
);

class TokenPrice extends StatelessWidget {
  final String address;
  const TokenPrice({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: 100,
        child: FutureBuilder<Price>(
          future: fuseSwapService.price(address),
          builder: (context, AsyncSnapshot<Price> snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('..');
              case ConnectionState.waiting:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                      ),
                      width: 10,
                      height: 10,
                    ),
                  ],
                );
              case ConnectionState.active:
                return Text('..');
              case ConnectionState.done:
                final num quote = num.tryParse(snapshot.data!.quote)!;
                final String price = smallNumberTest(quote)
                    ? display2(quote)
                    : '${display(quote)}';
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '\$' + price,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                );
              default:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                      ),
                      width: 10,
                      height: 10,
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
