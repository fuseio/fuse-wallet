import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/models/tokens/price.dart';
import 'package:fusecash/services/apis/fuseswap.dart';

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
          future: getIt<FuseSwapService>().price(address),
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
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: AutoSizeText(
                        '\$' + snapshot.data!.quoteHuman,
                        style: TextStyle(
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
