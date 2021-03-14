import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusecash/widgets/network_explained.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';

class TokenHeader extends StatelessWidget {
  TokenHeader({this.token});
  final Token token;

  @override
  Widget build(BuildContext context) {
    final String price = token.priceInfo != null
        ? reduce(double.parse(token?.priceInfo?.total))
        : '0';
    final bool isFuseToken = ![null, ''].contains(token.originNetwork);
    final String logo = isFuseToken ? 'fuse-network.svg' : 'ether-network.svg';
    return Container(
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                focusColor: Theme.of(context).canvasColor,
                highlightColor: Theme.of(context).canvasColor,
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 35, bottom: 35, right: 35),
                  child: Icon(PlatformIcons(context).back),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text('${token.symbol} ${I18n.of(context).balance}',
                          style: TextStyle(fontSize: 12.0)),
                      padding: EdgeInsets.only(bottom: 6.0),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          verticalDirection: VerticalDirection.down,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 27,
                                      fontFamily: 'Europa',
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                    children: [
                                  TextSpan(text: token.getBalance()),
                                  TextSpan(text: " ${token.symbol}")
                                ])),
                            SizedBox(
                              width: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                text: ![null, ''].contains(token.priceInfo) &&
                                        token.priceInfo.total.isNotEmpty
                                    ? '\$$price'
                                    : "",
                                style: TextStyle(
                                  fontFamily: 'Europa',
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 25,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    focusColor: Theme.of(context).canvasColor,
                    highlightColor: Theme.of(context).canvasColor,
                    child: SvgPicture.asset(
                      'assets/images/$logo',
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => NetworkExplainedScreen(
                          logo: isFuseToken
                              ? 'fuse_network_logo.svg'
                              : 'ether-logo.svg',
                          network: isFuseToken ? 'fuse' : 'ether',
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
