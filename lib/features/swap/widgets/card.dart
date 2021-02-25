import 'package:cached_network_image/cached_network_image.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/utils/images.dart';

class TradeCard extends StatelessWidget {
  final Token token;
  final bool hasBalance;
  final String title;
  final Widget useMaxWidget;
  final void Function(String) onChanged;
  final TextEditingController textEditingController;
  final void Function() onTap;

  TradeCard({
    this.title,
    this.onTap,
    this.useMaxWidget,
    this.hasBalance = true,
    this.onChanged,
    this.token,
    this.textEditingController,
  });

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
                        InkWell(
                          onTap: onTap,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                child: CachedNetworkImage(
                                  width: 33,
                                  height: 33,
                                  imageUrl: token?.imageUrl != null &&
                                          token.imageUrl.isNotEmpty
                                      ? token?.imageUrl
                                      : ImageUrl.getTokenUrl(
                                          checksumEthereumAddress(
                                              token?.address)),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    size: 18,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                token?.symbol ?? '',
                                style: TextStyle(fontSize: 16),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
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
                              autofocus: false,
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
                              token?.symbol ?? '',
                              style: TextStyle(
                                  color: Color(0xFFC4C4C4), fontSize: 14),
                            ),
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
          // SizedBox(
          //   height: 2,
          // ),
          // pricesText != null
          //     ? Padding(
          //         padding: EdgeInsets.only(left: 10.0),
          //         child: Text(
          //           pricesText,
          //           // '${info.inputAmount} ${info.inputToken} = ${info.outputToken} ${info.outputAmount}',
          //           style: TextStyle(color: Color(0xFF8E8E8E), fontSize: 10),
          //         ),
          //       )
          //     : SizedBox.shrink(),
        ],
      ),
    );
  }
}
