import 'package:flutter/material.dart';

import 'package:charge_wallet_sdk/models/models.dart';

import 'package:fusecash/features/shared/widgets/preloader.dart';
import 'package:fusecash/services.dart';

class Quote extends StatelessWidget {
  final String? tokenInAddress;
  final String? tokenOutAddress;
  const Quote({
    Key? key,
    this.tokenInAddress,
    this.tokenOutAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tokenInAddress == null || tokenOutAddress == null) {
      return const SizedBox.shrink();
    }
    return FutureBuilder(
      future: chargeApi.quote(
        TradeRequestBody(
          currencyOut: tokenInAddress!,
          currencyIn: tokenOutAddress!,
          amountIn: '1',
        ),
      ),
      builder: (BuildContext context, AsyncSnapshot<Trade> snapshot) {
        if (snapshot.hasError) {
          return const SizedBox.shrink();
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const SizedBox.shrink();
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 30,
                  ),
                  Preloader(
                    width: 25,
                    height: 25,
                  )
                ],
              ),
            );
          case ConnectionState.done:
            return Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${snapshot.data?.inputAmount} ${snapshot.data?.inputToken} = ',
                      ),
                      Text(
                        '${snapshot.data?.outputAmount} ${snapshot.data?.outputToken}',
                      ),
                    ],
                  ),
                ],
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
