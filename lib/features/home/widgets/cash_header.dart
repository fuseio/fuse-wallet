import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/constants/keys.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/redux/viewsmodels/cash_header.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/send.dart';

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
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  AppKeys.homePageKey.currentState.openDrawer();
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 35, right: 35),
                  child: Image.asset(
                    'assets/images/menu.png',
                    width: 20,
                  ),
                ),
              ),
              Text(
                '${I18n.of(context).hi} ${viewModel?.firstName() ?? ''}',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                verticalDirection: VerticalDirection.up,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        I18n.of(context).balance,
                        style: TextStyle(
                          color: Color(0xFF454545),
                          fontSize: 13.0,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      viewModel.hasErc20Tokens
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'Europa',
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              '\$${viewModel?.usdValue ?? '0'}',
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ])
                          : Container(
                              height: 32,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'Europa',
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      children: viewModel.token == null
                                          ? <TextSpan>[
                                              TextSpan(
                                                text: '0',
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ]
                                          : <TextSpan>[
                                              TextSpan(
                                                text: formatValue(
                                                    viewModel.token.amount,
                                                    viewModel.token.decimals),
                                                style: TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' ' +
                                                    viewModel.token?.symbol
                                                        .toString(),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                  height: 0.0,
                                                ),
                                              )
                                            ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    child: GestureDetector(
                      child: SvgPicture.asset(
                        'assets/images/scan.svg',
                      ),
                      onTap: () {
                        barcodeScannerHandler(
                            ExtendedNavigator.named('homeRouter').context);
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
