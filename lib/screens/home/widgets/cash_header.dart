import 'package:flutter/material.dart';
import 'package:esol/constans/keys.dart';
import 'package:esol/models/views/cash_header.dart';
import 'package:esol/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:esol/utils/format.dart';
import 'package:esol/utils/send.dart';
import 'package:flutter_svg/svg.dart';

class CashHeader extends StatefulWidget {
  @override
  _CashHeaderState createState() => _CashHeaderState();
}

class _CashHeaderState extends State<CashHeader> {
  bool imageshow = true;
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CashHeaderViewModel>(
        distinct: true,
        converter: CashHeaderViewModel.fromStore,
        builder: (_, viewModel) {
          return Container(
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
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    AppKeys.homePageKey.currentState.openDrawer();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 35, bottom: 35, right: 35),
                    child: Image.asset(
                      'assets/images/menu_white.png',
                      width: 20,
                    ),
                  ),
                ),
                //Editing Start
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(
                            viewModel?.token?.symbol ?? 'S/',
                            style: TextStyle(
                              color: Theme.of(context).splashColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/conversion_icon.png'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(viewModel?.token?.name?.toUpperCase() ?? 'ESOL',
                              style: TextStyle(
                                color: Theme.of(context).splashColor,
                                fontSize: 14,
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                imageshow = !imageshow;
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue[600],
                              ),
                              child: Container(
                                height: 10,
                                child: Image.asset(
                                  imageshow
                                      ? 'assets/images/eye_hide.png'
                                      : 'assets/images/eye_show.png',
                                  // filterQuality: FilterQuality.high,
                                ),
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // verticalDirection: VerticalDirection.up,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                viewModel.hasErc20Tokens
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                            RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          '\$${viewModel?.usdValue ?? '0'}',
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          color: Theme.of(
                                                                  context)
                                                              .splashColor)),
                                                ],
                                              ),
                                            ),
                                          ])
                                    : RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .splashColor),
                                          children: viewModel.token == null
                                              ? <TextSpan>[
                                                  TextSpan(
                                                      text: '0',
                                                      style: TextStyle(
                                                        fontSize: 30,
                                                        color: Theme.of(context)
                                                            .splashColor,
                                                      ))
                                                ]
                                              : <TextSpan>[
                                                  TextSpan(
                                                      text: imageshow
                                                          ? '${viewModel?.token?.symbol} ${formatValue(viewModel?.token?.amount, viewModel?.token?.decimals)}'
                                                          : '${viewModel?.token?.symbol} ****',
                                                      style: TextStyle(
                                                          fontSize: 36,
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          color: Theme.of(
                                                                  context)
                                                              .splashColor)),
                                                ],
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    FittedBox(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).splashColor,
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: EdgeInsets.all(15),
                          child: InkWell(
                            onTap: bracodeScannerHandler,
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/QR.svg",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'QR',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
