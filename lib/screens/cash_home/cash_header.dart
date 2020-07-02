import 'package:flutter/material.dart';
import 'package:peepl/generated/i18n.dart';
import 'package:peepl/models/views/cash_header.dart';
import 'package:peepl/models/app_state.dart';
import 'package:peepl/utils/barcode.dart';
import 'package:peepl/utils/format.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CashHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, CashHeaderViewModel>(
        distinct: true,
        converter: CashHeaderViewModel.fromStore,
        builder: (_, viewModel) {
          return Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(20.0),
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
                    Theme.of(context).primaryColorLight,
                    Theme.of(context).primaryColorDark,
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
                      Scaffold.of(context).openDrawer();
                    },
                    child: Padding(
                        padding:
                            EdgeInsets.only(top: 35, bottom: 35, right: 35),
                        child: Image.asset(
                          'assets/images/menu_white.png',
                          width: 20,
                        ))),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 0.0),
                    child: new RichText(
                      text: new TextSpan(
                        children: <TextSpan>[
                          new TextSpan(
                              text: I18n.of(context).hi,
                              style: TextStyle(
                                  fontSize: 33,
                                  color: Theme.of(context).splashColor,
                                  fontWeight: FontWeight.normal)),
                          new TextSpan(
                              text: ' ' + (viewModel?.firstName() ?? ''),
                              style: TextStyle(
                                  fontSize: 33,
                                  color: Theme.of(context).splashColor,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                  ),
                )),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 0.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      verticalDirection: VerticalDirection.up,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  child: Text(I18n.of(context).balance,
                                      style: TextStyle(
                                          color: Theme.of(context).splashColor,
                                          fontSize: 12.0)),
                                  padding: EdgeInsets.only(bottom: 6.0),
                                ),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      RichText(
                                        text: new TextSpan(
                                          children: (viewModel.community
                                                          .tokenBalance ==
                                                      null ||
                                                  viewModel.community.token ==
                                                      null)
                                              ? <TextSpan>[
                                                  new TextSpan(
                                                      text: '0',
                                                      style: new TextStyle(
                                                          fontSize: 30,
                                                          color:
                                                              Theme.of(context)
                                                                  .splashColor,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ]
                                              : <TextSpan>[
                                                  new TextSpan(
                                                      text: formatValue(
                                                          viewModel.community
                                                              .tokenBalance,
                                                          viewModel.community
                                                              .token.decimals),
                                                      style: new TextStyle(
                                                          fontSize: 32,
                                                          color:
                                                              Theme.of(context)
                                                                  .splashColor,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  new TextSpan(
                                                      text: ' ' +
                                                          viewModel.community
                                                              .token?.symbol
                                                              .toString(),
                                                      style: new TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Theme.of(context)
                                                                  .splashColor,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          height: 0.0)),
                                                ],
                                        ),
                                      ),
                                    ]),
                              ],
                            ),
                            SizedBox(width: 30,),
                            viewModel.community.secondaryToken == null
                                ? SizedBox.shrink()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        child: Text('Secondary token',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .splashColor,
                                                fontSize: 12.0)),
                                        padding: EdgeInsets.only(bottom: 6.0),
                                      ),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            RichText(
                                              text: new TextSpan(
                                                children: <TextSpan>[
                                                  new TextSpan(
                                                      text: formatValue(
                                                          viewModel.community
                                                              .secondaryTokenBalance,
                                                          viewModel
                                                              .community
                                                              .secondaryToken
                                                              .decimals),
                                                      style: new TextStyle(
                                                          fontSize: 32,
                                                          color:
                                                              Theme.of(context)
                                                                  .splashColor,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  new TextSpan(
                                                      text: ' ' +
                                                          viewModel
                                                              .community
                                                              .secondaryToken
                                                              ?.symbol
                                                              .toString(),
                                                      style: new TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Theme.of(context)
                                                                  .splashColor,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          height: 0.0)),
                                                ],
                                              ),
                                            ),
                                          ])
                                    ],
                                  )
                          ],
                        ),
                        new Container(
                          child: Row(children: [
                            new FloatingActionButton(
                                heroTag: 'cash_scanner',
                                backgroundColor: const Color(0xFF292929),
                                elevation: 0,
                                child: Image.asset(
                                  'assets/images/scan.png',
                                  width: 25.0,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                onPressed: () {
                                  bracodeScannerHandler(context);
                                })
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
