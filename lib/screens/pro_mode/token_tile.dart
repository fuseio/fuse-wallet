import 'package:cached_network_image/cached_network_image.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:digitalrand/models/tokens/token.dart';
import 'package:digitalrand/screens/pro_mode/assets_list.dart';
import 'package:digitalrand/screens/pro_mode/token_transfers.dart';
import 'package:digitalrand/utils/format.dart';

class TokenTile extends StatelessWidget {
  TokenTile({this.token});
  final Token token;
  @override
  Widget build(BuildContext context) {
    String price;
    if (prices.containsKey(token.symbol)) {
      price =
          getDollarValue(token.amount, token.decimals, prices[token.symbol]);
    }
    bool isFuseTxs = token.originNetwork != null;
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
      child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TokenTransfersScreen(token: token)));
          },
          contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 0),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  flex: 8,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                width: 60,
                                height: 60,
                                imageUrl: token.imageUrl != null &&
                                        token.imageUrl.isNotEmpty
                                    ? token.imageUrl
                                    : getTokenUrl(
                                        checksumEthereumAddress(token.address)),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                  size: 54,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: SvgPicture.asset(
                                'assets/images/${isFuseTxs ? 'fuse' : 'ethereum'}_network.svg',
                                fit: BoxFit.contain,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            token.transactions.list
                                    .any((transfer) => transfer.isPending())
                                ? Container(
                                    width: 55,
                                    height: 55,
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                          Color(0xFF49D88D).withOpacity(0),
                                      strokeWidth: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xFF49D88D).withOpacity(1)),
                                    ))
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Flexible(
                        flex: 10,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(token.name,
                                style: TextStyle(
                                    color: Color(0xFF333333), fontSize: 15)),
                            SizedBox(
                              width: 5,
                            ),
                            SvgPicture.asset(
                              'assets/images/go_to_pro.svg',
                              width: 10,
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
              Flexible(
                  flex: 4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              overflow: Overflow.visible,
                              alignment: AlignmentDirectional.bottomEnd,
                              children: <Widget>[
                                RichText(
                                    text: TextSpan(children: <TextSpan>[
                                  prices.containsKey(token.symbol)
                                      ? TextSpan(
                                          text: '\$' + price,
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Theme.of(context)
                                                  .primaryColor))
                                      : TextSpan(
                                          text: token.getBalance() +
                                              ' ' +
                                              token.symbol,
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                ])),
                                prices.containsKey(token.symbol)
                                    ? Positioned(
                                        bottom: -20,
                                        child: Padding(
                                            child: Text(
                                                token.getBalance() +
                                                    ' ' +
                                                    token.symbol,
                                                style: TextStyle(
                                                    color: Color(0xFF8D8D8D),
                                                    fontSize: 10)),
                                            padding: EdgeInsets.only(top: 10)))
                                    : SizedBox.shrink()
                              ],
                            )
                          ],
                        )
                      ]))
            ],
          )),
    );
  }
}
