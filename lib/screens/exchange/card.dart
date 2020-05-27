import 'package:cached_network_image/cached_network_image.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/screens/pro_mode/assets_list.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/format.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';

class ExchangeCard extends StatelessWidget {
  final Token token;
  final String walletAddress;
  final bool isFetching;
  final String title;
  final Token tokenToReceive;
  final Decoration decoration;
  final void Function(String) onChanged;
  final TextEditingController textEditingController;
  const ExchangeCard(
      {Key key,
      this.title,
      this.walletAddress,
      this.onChanged,
      this.token,
      this.isFetching,
      this.textEditingController,
      this.tokenToReceive,
      this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: decoration,
      constraints: BoxConstraints(
          minHeight: 165,
          minWidth: MediaQuery.of(context).size.width,
          maxWidth: MediaQuery.of(context).size.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Color(0xFF888888), fontSize: 13),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    CachedNetworkImage(
                      width: 33,
                      height: 33,
                      imageUrl:
                          getTokenUrl(checksumEthereumAddress(token.address)),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        size: 18,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      token.symbol,
                      style: TextStyle(color: Color(0xFF909090), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        TextFormField(
                          onChanged: onChanged,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Amount',
                            hintStyle: TextStyle(color: Color(0xFFC4C4C4)),
                            filled: true,
                            fillColor: Theme.of(context).splashColor,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11.0)),
                              borderSide: BorderSide(
                                  color: Color(0xFFE5E5E5), width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11.0)),
                              borderSide: BorderSide(
                                  color: Color(0xFFE5E5E5), width: 3),
                            ),
                          ),
                        ),
                        isFetching
                            ? Container(
                                child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Color(0xFF8E8E8E))),
                                width: 10,
                                height: 10,
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    new FutureBuilder<dynamic>(
                        future: fetchSwap(walletAddress, token.address,
                            tokenToReceive.address,
                            sourceAmount:
                                toBigInt(num.parse('1'), token.decimals)
                                    .toString()),
                        builder: (BuildContext _context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            dynamic summary =
                                snapshot.data['response']['summary'][0];
                            String fromTokenAmount = formatValue(
                                BigInt.from(num.parse(summary['sourceAmount'])),
                                token.decimals);
                            String toTokenAmount = formatValue(
                                BigInt.from(
                                    num.parse(summary['destinationAmount'])),
                                tokenToReceive.decimals);
                            return Text(
                              '$fromTokenAmount ${token.symbol} = $toTokenAmount ${tokenToReceive.symbol}',
                              style: TextStyle(
                                  color: Color(0xFF8E8E8E), fontSize: 10),
                            );
                          }
                          return Container(
                            child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xFF8E8E8E))),
                            width: 10,
                            height: 10,
                          );
                          // if (snapshot.connectionState ==
                          //     ConnectionState.waiting) {
                          //   return Container(
                          //     child: CircularProgressIndicator(
                          //         strokeWidth: 2,
                          //         valueColor: new AlwaysStoppedAnimation<Color>(
                          //             Color(0xFF8E8E8E))),
                          //     width: 10,
                          //     height: 10,
                          //   );
                          // } else if (snapshot.hasError) {
                          //   return Text(
                          //     'Error....',
                          //     style: TextStyle(fontSize: 10),
                          //   );
                          // }
                          // dynamic summary =
                          //     snapshot.data['response']['summary'][0];
                          // String fromTokenAmount = formatValue(
                          //     BigInt.from(num.parse(summary['sourceAmount'])),
                          //     token.decimals);
                          // String toTokenAmount = formatValue(
                          //     BigInt.from(
                          //         num.parse(summary['destinationAmount'])),
                          //     tokenToReceive.decimals);
                          // return Text(
                          //   '$fromTokenAmount ${token.symbol} = $toTokenAmount ${tokenToReceive.symbol}',
                          //   style: TextStyle(
                          //       color: Color(0xFF8E8E8E), fontSize: 10),
                          // );
                        }),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Future<dynamic> fetchSwap(
  String walletAddress,
  String fromTokenAddress,
  String toTokenAddress, {
  String sourceAmount,
  String destinationAmount,
}) async {
  final logger = await AppFactory().getLogger('Fetch quate');
  try {
    Map apiOptions = Map.from({
      'swap': {
        'sourceAsset': fromTokenAddress,
        'destinationAsset': toTokenAddress,
      },
      'config': {'transactions': true, 'skipBalanceChecks': true}
    });
    if (sourceAmount != null && sourceAmount.isNotEmpty) {
      apiOptions['swap']['sourceAmount'] = sourceAmount;
    }
    if (destinationAmount != null && destinationAmount.isNotEmpty) {
      apiOptions['swap']['destinationAmount'] = destinationAmount;
    }
    logger.info(apiOptions.toString());
    dynamic response =
        await exchangeApi.swap(walletAddress, options: apiOptions);
    return response;
  } catch (error) {
    logger.severe('$error');
  }
}
