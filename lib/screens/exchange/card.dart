import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/services.dart';
import 'package:flutter/material.dart';

class ExchangeCard extends StatelessWidget {
  final Token token;
  final String walletAddress;
  final bool isFetching;
  final bool hasBalance;
  final String title;
  final bool isFetchingPrice;
  final String fromTokenAmount;
  final String toTokenAmount;
  final Token tokenToReceive;
  final List<DropdownMenuItem<Token>> items;
  final void Function(String) onChanged;
  final void Function(Token) onDropDownChanged;
  final TextEditingController textEditingController;
  const ExchangeCard(
      {Key key,
      this.title,
      this.items,
      this.isFetchingPrice,
      this.fromTokenAmount,
      this.toTokenAmount,
      this.hasBalance = true,
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
                          onChanged: onDropDownChanged,
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
                          overflow: Overflow.visible,
                          children: <Widget>[
                            TextFormField(
                              onChanged: onChanged,
                              controller: textEditingController,
                              textInputAction: TextInputAction.done,
                              keyboardType:  TextInputType.numberWithOptions(
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
                              token.symbol,
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
                                : SizedBox.shrink(),
                            !hasBalance
                                ? Positioned(
                                    bottom: -26,
                                    left: 0,
                                    child: Text(
                                      I18n.of(context).no_funds_available,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 10),
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
          fromTokenAmount != null && toTokenAmount != null
              ? Text(
                  '$fromTokenAmount ${token.symbol} = $toTokenAmount ${tokenToReceive.symbol}',
                  style: TextStyle(color: Color(0xFF8E8E8E), fontSize: 10),
                )
              : SizedBox.shrink(),
          isFetchingPrice
              ? Container(
                  child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Color(0xFF8E8E8E))),
                  width: 10,
                  height: 10,
                )
              : SizedBox.shrink()
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
  bool transactions = false,
}) async {
  final logger = await AppFactory().getLogger('action');
  try {
    if (fromTokenAddress != null &&
        fromTokenAddress.isNotEmpty &&
        toTokenAddress != null &&
        toTokenAddress.isNotEmpty) {
      Map apiOptions = Map.from({
        'apiKey': DotEnv().env['TOTLE_API_KEY'],
        'swap': {
          'sourceAsset': fromTokenAddress,
          'destinationAsset': toTokenAddress,
        },
        'config': {'transactions': transactions, 'skipBalanceChecks': true}
      });
      if (sourceAmount != null && sourceAmount.isNotEmpty) {
        apiOptions['swap']['sourceAmount'] = sourceAmount;
      }
      if (destinationAmount != null && destinationAmount.isNotEmpty) {
        apiOptions['swap']['destinationAmount'] = destinationAmount;
      }
      Map<String, dynamic> response =
          await exchangeApi.swap(walletAddress, options: apiOptions);
      bool success = response['success'] ?? false;
      if (success) {
        if (response['response'].containsKey('transactions')) {
          return Map.from({
            ...response['response']['summary'][0],
            'tx': response['response']['transactions'][1]['tx']
          });
        } else {
          return Map.from({...response['response']['summary'][0]});
        }
      }
      throw response;
    }
    throw 'Error fromTokenAddress and toTokenAddress are empty';
  } catch (error) {
    logger.severe('ERROR in fetchSwap - ${error.toString()}');
    throw error;
  }
}
