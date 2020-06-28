import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/utils/format.dart';

class ProTokenHeader extends StatelessWidget {
  ProTokenHeader({this.token});
  final Token token;

  @override
  Widget build(BuildContext context) {
    String price;
    if (prices.containsKey(token.symbol)) {
      price =
          getDollarValue(token.amount, token.decimals, prices[token.symbol]);
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(30.0),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withAlpha(20),
              blurRadius: 30.0,
              spreadRadius: 0.0,
              offset: Offset(
                0.0,
                3.0,
              ),
            )
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Color(0xFF414141),
              Colors.black,
            ],
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 35, right: 35),
                  child: SvgPicture.asset(
                    'assets/images/arrow_white.svg',
                    fit: BoxFit.fill,
                    width: 18,
                    height: 18,
                    alignment: Alignment.topLeft,
                  ))),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                child: Text('${token.symbol} ${I18n.of(context).balance}',
                    style: TextStyle(
                        color: Theme.of(context).splashColor, fontSize: 12.0)),
                padding: EdgeInsets.only(bottom: 6.0),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                verticalDirection: VerticalDirection.down,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  RichText(
                      text: new TextSpan(
                          text: prices.containsKey(token.symbol)
                              ? '\$$price'
                              : "${token.getTokenBalance()}",
                          style: new TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).splashColor))),
                  SizedBox(
                    width: 10,
                  ),
                  RichText(
                      text: new TextSpan(
                          style:
                              TextStyle(color: Color(0xFFBEBEBE), fontSize: 18),
                          children: [
                        new TextSpan(
                            text: prices.containsKey(token.symbol)
                                ? token.getTokenBalance()
                                : ''),
                        new TextSpan(text: " ${token.symbol}")
                      ])),
                ],
              )
            ],
          )),
        ],
      ),
    );
  }
}
