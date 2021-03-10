import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:peepl/constans/keys.dart';
import 'package:peepl/generated/i18n.dart';
import 'package:peepl/models/views/cash_header.dart';
import 'package:peepl/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:peepl/utils/format.dart';
import 'package:peepl/utils/send.dart';

class CashHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CashHeaderViewModel>(
        distinct: true,
        converter: CashHeaderViewModel.fromStore,
        builder: (_, viewModel) {
          return Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(
                top: 20.0, left: 20.0, right: 20.0, bottom: 15.0),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withAlpha(20),
                    blurRadius: 30.0,
                    spreadRadius: 10.0,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      AppKeys.homePageKey.currentState.openDrawer();
                    },
                    child: Padding(
                        padding:
                            EdgeInsets.only(top: 35, bottom: 35, right: 35),
                        child: Image.asset(
                          'assets/images/menu_white.png',
                          width: 20,
                        ))),
                Text('${I18n.of(context).hi} ${viewModel?.firstName() ?? ''}',
                    style: TextStyle(
                      color: Theme.of(context).splashColor,
                      fontSize: 25,
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  verticalDirection: VerticalDirection.up,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(I18n.of(context).balance,
                                  style: TextStyle(
                                      color: Theme.of(context).splashColor,
                                      fontSize: 12.0)),
                              padding: EdgeInsets.only(bottom: 6.0),
                            ),
                            // viewModel.hasErc20Tokens
                            //     ? Row(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.center,
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: <Widget>[
                            //             RichText(
                            //               text: TextSpan(
                            //                 children: <TextSpan>[
                            //                   TextSpan(
                            //                       text:
                            //                           '\$${viewModel?.usdValue ?? '0'}',
                            //                       style: TextStyle(
                            //                           fontSize: 30,
                            //                           color: Theme.of(context)
                            //                               .splashColor,
                            //                           fontWeight:
                            //                               FontWeight.bold)),
                            //                 ],
                            //               ),
                            //             ),
                            //           ]):
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Theme.of(context).splashColor),
                                children: viewModel.secondaryToken == null
                                    ? <TextSpan>[
                                        TextSpan(
                                            text: '0',
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Theme.of(context)
                                                    .splashColor,
                                                fontWeight: FontWeight.bold))
                                      ]
                                    : <TextSpan>[
                                        TextSpan(
                                            text: formatValue(
                                                viewModel.secondaryToken.amount,
                                                viewModel
                                                    .secondaryToken.decimals),
                                            style: TextStyle(
                                                fontSize: 32,
                                                color: Theme.of(context)
                                                    .splashColor,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: ' ' +
                                                viewModel.secondaryToken?.symbol
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Theme.of(context)
                                                    .splashColor,
                                                fontWeight: FontWeight.normal,
                                                height: 0.0)),
                                      ],
                              ),
                            ),
                          ],
                        ),
                        viewModel.token == null
                            ? SizedBox.shrink()
                            : SizedBox(
                                width: 30,
                              ),
                        viewModel.token == null
                            ? SizedBox.shrink()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text('Rewards',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).splashColor,
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
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: formatValue(
                                                      viewModel.token.amount,
                                                      viewModel.token.decimals),
                                                  style: TextStyle(
                                                      fontSize: 32,
                                                      color: Theme.of(context)
                                                          .splashColor,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: ' ' +
                                                      viewModel.token?.symbol
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .splashColor,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      height: 0.0))
                                            ],
                                          ),
                                        ),
                                      ])
                                ],
                              ),
                      ],
                    ),
                    // Container(
                    //   width: 45,
                    //   height: 45,
                    //   child: FloatingActionButton(
                    //     heroTag: 'cash_header',
                    //     backgroundColor: Color(0xFF292929),
                    //     elevation: 0,
                    //     child: Image.asset(
                    //       'assets/images/scan.png',
                    //       width: 25.0,
                    //       color: Theme.of(context).scaffoldBackgroundColor,
                    //     ),
                    //     onPressed: () {
                    //       barcodeScannerHandler(
                    //           ExtendedNavigator.named('homeRouter').context);
                    //     },
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
          );
        });
  }
}
