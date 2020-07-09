import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/views/cash_header.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/screens/cash_home/prize.dart';
import 'package:fusecash/utils/barcode.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
                          'assets/images/menu.png',
                          width: 20,
                        ))),
                Text('${I18n.of(context).hi} ${viewModel?.firstName() ?? ''}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
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
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withAlpha(150),
                                  fontSize: 12.0)),
                          padding: EdgeInsets.only(bottom: 6.0),
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '\$${viewModel?.usdValue ?? '0'}',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ])
                      ],
                    ),
                    Container(
                      child: Row(children: [
                        viewModel.isCommunityMember
                            ? InkWell(
                                child: SvgPicture.asset(
                                  'assets/images/winPoints.svg',
                                  width: 45,
                                  height: 45,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PrizeScreen()));
                                  Segment.track(
                                      eventName: "User open prize page");
                                },
                              )
                            : SizedBox.shrink(),
                        viewModel.isCommunityMember
                            ? SizedBox(
                                width: 10,
                              )
                            : SizedBox.shrink(),
                        Container(
                          width: 45,
                          height: 45,
                          child: FloatingActionButton(
                              heroTag: 'cash_header',
                              backgroundColor: Color(0xFF292929),
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
                      ]),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}
