import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/prize.dart';
import 'package:fusecash/screens/cash_home/deposit_webview.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/bottombar.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'dart:core';

import 'package:intl/intl.dart';

Function add(double a) {
  double innerFunction(double b) {
    return a += b;
  }
  return innerFunction;
}

Widget counterItem(BuildContext context, number) {
  return Container(
    padding: EdgeInsets.only(top: 8, bottom: 8, left: 7, right: 7),
    decoration: BoxDecoration(
        color: Color(0xFFF0F0F0),
        borderRadius: BorderRadius.all(Radius.circular(8.0))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          number.toString(),
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 35),
        )
      ],
    ),
  );
}

Widget counterCard(BuildContext context, int number) {
  String a = number.toString();
  bool isBigerThen = number > 10;
  String firstNum = isBigerThen ? a.split('')[0] : '0';
  String secondNum = isBigerThen ? a.split('')[1] : a;
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        counterItem(context, firstNum),
        SizedBox(
          width: 10,
        ),
        counterItem(context, secondNum),
      ]);
}

Widget counter(BuildContext context, String text, int value) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      counterCard(context, value),
      SizedBox(
        height: 10,
      ),
      Text(text),
    ],
  );
}

class PrizeScreen extends StatefulWidget {
  PrizeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PrizeScreenState createState() => _PrizeScreenState();
}

class _PrizeScreenState extends State<PrizeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext _context) {
    return new StoreConnector<AppState, PrizeViewModel>(
        converter: PrizeViewModel.fromStore,
        builder: (_, viewModel) {
          List depositPlugins = viewModel?.plugins?.getDepositPlugins();
          Function currentAmountCb = add(double.parse(viewModel.drawInfo.reward['amount']));
          return MainScaffold(
            backgroundColor: Colors.white,
            title: '',
            titleFontSize: 15,
            footer: bottomBar(context),
            withPadding: false,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Win ' +
                              num.parse(viewModel.drawInfo.reward['estimated']).toStringAsFixed(2) +
                              ' DAI points!',
                          style: TextStyle(
                              color: Color(0xFF00BE66),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Image.asset(
                          'assets/images/gift.png',
                          fit: BoxFit.contain,
                          width: 30,
                          height: 30,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Next prize in',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    StreamBuilder(
                        stream: Stream.periodic(Duration(seconds: 1), (i) => i),
                        builder: (BuildContext context,
                            AsyncSnapshot<int> snapshot) {
                          DateFormat format = new DateFormat('hh:mm');
                          int now = DateTime.now().millisecondsSinceEpoch;
                          Duration remaining = Duration(
                              milliseconds:
                                  viewModel.drawInfo.endTimestamp - now);
                          List<String> temp = format
                              .format(DateTime.fromMillisecondsSinceEpoch(
                                  remaining.inMilliseconds))
                              .split(':');
                          return Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  counter(context, 'Days', remaining.inDays),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  counter(context, 'Hours', int.parse(temp[0])),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  counter(
                                      context, 'Minutes', int.parse(temp[1]))
                                ],
                              ));
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Color(0xFFF0FFF3),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Current Prize amount:',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/images/prize.svg',
                            fit: BoxFit.contain,
                            width: 40,
                            height: 40,
                          ),
                          StreamBuilder(
                              stream: Stream.periodic(
                                  Duration(seconds: 1),
                                  (i) => viewModel.drawInfo
                                              .reward['growthRatePerSec'] !=
                                          null
                                      ? double.parse(viewModel
                                          .drawInfo.reward['growthRatePerSec'])
                                      : 0.0),
                              builder: (BuildContext context,
                                  AsyncSnapshot<double> snapshot) {
                                if (snapshot.hasError) {
                                  return SizedBox.shrink();
                                }
                                double growthedAmount =
                                    currentAmountCb(snapshot.data ?? 0.0);
                                return Text(
                                  growthedAmount.toString() + ' points',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                );
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Your chance are 1 in ' +
                          viewModel.drawInfo.possibleWinnersCount.toString(),
                      style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/images/top_up.svg',
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DepositWebView(
                                        depositPlugin: depositPlugins[0])),
                              );
                            },
                            child: Text(
                              'Top up to improve your chances',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    viewModel.drawInfo.previous['winner'] != null
                        ? Text(
                            'Last prize ' +
                                (viewModel.drawInfo.previous['reward']
                                        .toString() ??
                                    '') +
                                'went to ' +
                                formatAddress(
                                    viewModel.drawInfo.previous['winner']),
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.secondary),
                          )
                        : SizedBox.shrink(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Learn here how it works',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
