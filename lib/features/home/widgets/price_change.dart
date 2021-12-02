import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supervecina/services.dart';
import 'package:number_display/number_display.dart';

class TokenPriceChange extends StatelessWidget {
  final String address;
  const TokenPriceChange({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: 80,
        child: FutureBuilder<num>(
          future: fuseSwapService.priceChange(address),
          builder: (context, AsyncSnapshot<num> snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('..');
              case ConnectionState.waiting:
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                      // margin: EdgeInsets.only(left: 28, right: 28),
                    ),
                  ],
                );
              case ConnectionState.active:
                return Text('..');
              case ConnectionState.done:
                final num priceChange = snapshot.data!;
                final Display display = createDisplay(
                  decimal: 1,
                );
                if (priceChange.toStringAsFixed(2).startsWith('0.00') ||
                    priceChange.toStringAsFixed(2).startsWith('-0.00')) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        display(priceChange) + '%',
                        style: TextStyle(color: Color(0xFF292929)),
                      ),
                      SizedBox(
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
                        display(priceChange) + '%',
                        style: TextStyle(color: Color(0xFF292929)),
                      ),
                      SizedBox(
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
                        display(priceChange) + '%',
                        style: TextStyle(color: Color(0xFF292929)),
                      ),
                      SizedBox(
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
