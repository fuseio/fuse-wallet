import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/format.dart';
import 'package:flutter/material.dart';

class ExchangeCard extends StatelessWidget {
  final Token token;
  final String walletAddress;
  final bool isFetching;
  final String title;
  final Token tokenToReceive;
  final List<DropdownMenuItem<Token>> items;
  final void Function(String) onChanged;
  final void Function(Token) onDropDownChanged;
  final TextEditingController textEditingController;
  const ExchangeCard(
      {Key key,
      this.title,
      this.items,
      this.walletAddress,
      this.onDropDownChanged,
      this.onChanged,
      this.token,
      this.isFetching,
      this.textEditingController,
      this.tokenToReceive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
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
          Container(
            height: 80,
            decoration: BoxDecoration(
                color: Theme.of(context).splashColor,
                borderRadius: BorderRadius.all(Radius.circular(11.0)),
                border: Border.all(color: Color(0xFFE5E5E5), width: 3)),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: <Widget>[
                        DropdownButton<Token>(
                          value: token,
                          underline: Container(
                            height: 0,
                            color: Colors.white,
                          ),
                          onChanged: (token) {
                            onDropDownChanged(token);
                          },
                          items: items,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: 20,
                  child: VerticalDivider(
                    color: Color(0xFFE5E5E5),
                    thickness: 3,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.centerRight,
                          children: <Widget>[
                            TextFormField(
                              onChanged: onChanged,
                              controller: textEditingController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Amount',
                                hintStyle: TextStyle(color: Color(0xFFC4C4C4)),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                            Text(
                              tokenToReceive.symbol,
                              style: TextStyle(
                                  color: Color(0xFFC4C4C4), fontSize: 14),
                            ),
                            isFetching
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Color(0xFF8E8E8E))),
                                      width: 10,
                                      height: 10,
                                    ),
                                  )
                                : SizedBox.shrink()
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
          new FutureBuilder<dynamic>(
              future: fetchSwap(
                  walletAddress, token.address, tokenToReceive.address,
                  sourceAmount:
                      toBigInt(num.parse('1'), token.decimals).toString()),
              builder:
                  (BuildContext _context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Container(
                    child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Color(0xFF8E8E8E))),
                    width: 10,
                    height: 10,
                  );
                }
                if (snapshot.hasError) {
                  return Text(
                    'Error....',
                    style: TextStyle(color: Colors.red, fontSize: 10),
                  );
                }
                String fromTokenAmount = formatValue(
                    BigInt.from(num.parse(snapshot.data['sourceAmount'])),
                    token.decimals);
                String toTokenAmount = formatValue(
                    BigInt.from(num.parse(snapshot.data['destinationAmount'])),
                    tokenToReceive.decimals);
                return Text(
                  '$fromTokenAmount ${token.symbol} = $toTokenAmount ${tokenToReceive.symbol}',
                  style: TextStyle(color: Color(0xFF8E8E8E), fontSize: 10),
                );
              }),
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
  final logger = await AppFactory().getLogger('action');
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
    Map<String, dynamic> response =
        await exchangeApi.swap(walletAddress, options: apiOptions);

    if (response.containsKey('success')) {
      return response['response']['summary'][0];
    }
    logger.severe('ERROR in fetchSwap - ${response['message']}');
    throw response;
  } catch (error) {
    logger.severe('ERROR in fetchSwap - $error');
    throw error;
  }
}
