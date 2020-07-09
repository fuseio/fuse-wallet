import 'package:flutter/material.dart';
import 'package:digitalrand/generated/i18n.dart';
import 'package:digitalrand/models/views/cash_header.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/utils/barcode.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
                    Theme.of(context).primaryColorDark,
                    Theme.of(context).primaryColorLight,
                  ],
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                        '${I18n.of(context).hi} ${viewModel?.firstName() ?? ''}',
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
                              padding: EdgeInsets.only(bottom: 3.0),
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                '${viewModel?.dzarValue ?? '0'} DZAR',
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Theme.of(context)
                                                    .splashColor,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ])
                          ],
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          child: FloatingActionButton(
                              heroTag: 'cash_scanner',
                              backgroundColor: Color(0xFF002669),
                              elevation: 0,
                              child: Image.asset(
                                'assets/images/scan.png',
                                width: 25.0,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              onPressed: () {
                                bracodeScannerHandler(context);
                              }),
                        )
                      ],
                    ),
                  ],
                ),
                Positioned(
                  right: 10,
                  top: 35,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/images/digital_rand_title.svg',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

//  SvgPicture.asset(
//                               "assets/images/${widget.network}_network.svg",
//                               width: 150,
//                               height: 150,
//                             )
