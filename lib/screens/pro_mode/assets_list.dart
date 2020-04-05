import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:supervecina/generated/i18n.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/models/pro/token.dart';
import 'package:supervecina/models/pro/views/pro_wallet.dart';
import 'package:supervecina/utils/addresses.dart';

final Token daiToken = Token(
    address: daiTokenAddress,
    decimals: 18,
    imageUrl: "https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/assets/0x6B175474E89094C44Da98b954EedeAC495271d0F/logo.png",
    name: "Dai Stablecoin",
    symbol: "DAI");

class AssetsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ProWalletViewModel>(
        converter: ProWalletViewModel.fromStore,
        builder: (_, viewModel) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 15, top: 27, bottom: 8),
                    child: Text(I18n.of(context).assets_and_contracts,
                        style: TextStyle(
                            color: Color(0xFF979797),
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal))),
                ListView(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    children: [
                      viewModel.hasTrasnferdToForeign
                          ? _TokenPendingRow(
                              token: daiToken,
                            )
                          : SizedBox.shrink(),
                      ...viewModel.tokens.reversed
                          .map((Token token) => _TokenRow(
                                token: token,
                              ))
                          .toList()
                    ])
              ]);
        });
  }
}

class _TokenRow extends StatelessWidget {
  _TokenRow({this.token});
  final Token token;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          border: Border(bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
      child: ListTile(
          contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 0),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  flex: 12,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Hero(
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFE0E0E0),
                                radius: 27,
                                backgroundImage: NetworkImage(
                                  token.imageUrl,
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
                        child: Text(token.name,
                            style: TextStyle(
                                color: Color(0xFF333333), fontSize: 15)),
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
                                  token.address.contains(daiTokenAddress)
                                      ? new TextSpan(
                                          text: '\$' +
                                              token.amount.toStringAsFixed(2),
                                          style: new TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary))
                                      : new TextSpan(
                                          text:
                                              token.amount.toStringAsFixed(2) +
                                                  ' ' +
                                                  token.symbol,
                                          style: new TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary)),
                                ])),
                                token.address.contains(daiTokenAddress)
                                    ? Positioned(
                                        bottom: -20,
                                        child: Padding(
                                            child: Text(
                                                token.amount
                                                        .toStringAsFixed(2) +
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

class _TokenPendingRow extends StatelessWidget {
  _TokenPendingRow({this.token});
  final Token token;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          border: Border(bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
      child: ListTile(
          contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 0),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  flex: 12,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Hero(
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFE0E0E0),
                                radius: 27,
                                backgroundImage: NetworkImage(
                                  token.imageUrl,
                                ),
                              ),
                              tag: token.name,
                            ),
                            Container(
                                width: 55,
                                height: 55,
                                child: CircularProgressIndicator(
                                  backgroundColor:
                                      Color(0xFF49D88D).withOpacity(0),
                                  strokeWidth: 3,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Color(0xFF49D88D).withOpacity(1)),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Flexible(
                        flex: 10,
                        child: Text(token.name,
                            style: TextStyle(
                                color: Color(0xFF333333), fontSize: 15)),
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
                                      text: I18n.of(context).pending,
                                      style: new TextStyle(
                                          fontSize: 13.0,
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
