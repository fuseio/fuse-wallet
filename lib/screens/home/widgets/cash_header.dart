import 'package:flutter/material.dart';
import 'package:esol/constans/keys.dart';
import 'package:esol/generated/i18n.dart';
import 'package:esol/models/views/cash_header.dart';
import 'package:esol/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:esol/utils/format.dart';
import 'package:esol/utils/send.dart';
import 'package:flutter_svg/svg.dart';

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
                color: Theme.of(context).primaryColorDark,
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
                        viewModel.hasErc20Tokens
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  '\$${viewModel?.usdValue ?? '0'}',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: Theme.of(context)
                                                      .splashColor)),
                                        ],
                                      ),
                                    ),
                                  ])
                            : RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: Theme.of(context).splashColor),
                                  children: viewModel.token == null
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
                                                  viewModel.token.amount,
                                                  viewModel.token.decimals),
                                              style: TextStyle(
                                                  fontSize: 32,
                                                  color: Theme.of(context)
                                                      .splashColor,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: ' ' +
                                                  viewModel.token?.symbol
                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Theme.of(context)
                                                      .splashColor)),
                                        ],
                                ),
                              ),
                      ],
                    ),
                    Container(
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
                                height: 5,
                              ),
                              Text(
                                'QR',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ),
          );
        });
  }
}
