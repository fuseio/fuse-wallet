import 'package:cached_network_image/cached_network_image.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/screens/pro_mode/assets_list.dart';
import 'package:fusecash/screens/pro_mode/token_transfers.dart';
import 'package:fusecash/utils/format.dart';

class TokenTile extends StatelessWidget {
  TokenTile({this.token});
  final Token token;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          border: Border(bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
      child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
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
                            Hero(
                              child: CachedNetworkImage(
                                width: 54,
                                height: 54,
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
                              tag: token.name,
                            )
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
                                new RichText(
                                    text: new TextSpan(children: <TextSpan>[
                                  new TextSpan(
                                      text: formatValue(
                                              token.amount, token.decimals) +
                                          ' ' +
                                          token.symbol,
                                      style: new TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ]))
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
