// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:ethereum_address/ethereum_address.dart';
// import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
// import 'package:fusecash/screens/home/widgets/assets_list.dart';
import 'package:esol/generated/i18n.dart';
import 'package:esol/models/tokens/token.dart';
import 'package:flutter/material.dart';

class TradeCard extends StatelessWidget {
  final Token token;
  final String walletAddress;
  final bool isFetching;
  final bool hasBalance;
  final String title;
  final bool isFetchingPrice;
  final String fromTokenAmount;
  final String toTokenAmount;
  final Token tokenToReceive;
  final Widget useMaxWidget;
  final List<DropdownMenuItem<Token>> items;
  final void Function(String) onChanged;
  final void Function(Token) onDropDownChanged;
  final TextEditingController textEditingController;
  // final void Function() onTap;
  TradeCard(
      {Key key,
      this.title,
      this.items,
      // this.onTap,
      this.useMaxWidget,
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
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(color: Color(0xFF888888), fontSize: 13),
              ),
              useMaxWidget != null ? useMaxWidget : SizedBox.shrink(),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 65,
            decoration: BoxDecoration(
                color: Theme.of(context).splashColor,
                borderRadius: BorderRadius.all(Radius.circular(11.0)),
                border: Border.all(color: Color(0xFFE5E5E5), width: 2)),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * .33,
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
                        // InkWell(
                        //   onTap: onTap,
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: <Widget>[
                        //       CachedNetworkImage(
                        //         width: 33,
                        //         height: 33,
                        //         imageUrl: token.imageUrl != null &&
                        //                 token.imageUrl.isNotEmpty
                        //             ? token.imageUrl
                        //             : getTokenUrl(
                        //                 checksumEthereumAddress(token.address)),
                        //         placeholder: (context, url) =>
                        //             CircularProgressIndicator(),
                        //         errorWidget: (context, url, error) => Icon(
                        //           Icons.error,
                        //           size: 18,
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         width: 10,
                        //       ),
                        //       Text(
                        //         token.symbol,
                        //         style: TextStyle(fontSize: 16),
                        //       ),
                        //       Icon(Icons.arrow_drop_down)
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: 20,
                  child: VerticalDivider(
                    color: Color(0xFFE5E5E5),
                    thickness: 2,
                  ),
                ),
                Expanded(
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
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: true, decimal: true),
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF888888)),
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
                                                  Color(0xFFC4C4C4))),
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
              ? Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    '$fromTokenAmount ${token.symbol} = $toTokenAmount ${tokenToReceive.symbol}',
                    style: TextStyle(color: Color(0xFF8E8E8E), fontSize: 10),
                  ),
                )
              : SizedBox.shrink(),
          isFetchingPrice
              ? Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Container(
                    child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Color(0xFFC4C4C4))),
                    width: 10,
                    height: 10,
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
