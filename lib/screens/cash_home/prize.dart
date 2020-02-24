import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/draw_info.dart';
import 'package:fusecash/models/views/prize.dart';
import 'package:fusecash/screens/cash_home/deposit_webview.dart';
import 'package:fusecash/screens/cash_home/webview_page.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/bottombar.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/preloader.dart';
import 'package:http/http.dart';
import 'dart:core';
import 'package:intl/intl.dart';

Map<String, dynamic> responseHandler(Response response) {
  switch (response.statusCode) {
    case 200:
      Map<String, dynamic> obj = jsonDecode(response.body);
      return obj;
      break;
    default:
      throw 'Error! status: ${response.statusCode}, reason: ${response.reasonPhrase}';
  }
}

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
  bool isBigerThen = number >= 10;
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

Future<dynamic> _fetchDaiPointsInfo() async {
  Client client = new Client();
  Response res = await client.get('https://daipoints-oracle.fuse.io/draw-info');
  Map<String, dynamic> drawInfoResponse = responseHandler(res);
  final data = drawInfoResponse['data'];
  return data;
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
    return new FutureBuilder<dynamic>(
      future: _fetchDaiPointsInfo(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return new MainScaffold(
              backgroundColor: Colors.white,
              title: '',
              titleFontSize: 15,
              footer: bottomBar(context),
              withPadding: false,
              children: <Widget>[Preloader()]);
        } else if (snapshot.hasError) {
          return new Text('Error....');
        } else {
          final data = snapshot.data;
          DrawInfo drawInfo = new DrawInfo(
              endTimestamp: int.parse(data['current']['endTimestamp']),
              previous: data['previous'],
              reward: data['current']['reward'],
              blockNumber: data['current']['blockNumber'],
              possibleWinnersCount: data['current']['possibleWinnersCount']);
          return new StoreConnector<AppState, PrizeViewModel>(
              converter: PrizeViewModel.fromStore,
              builder: (_, viewModel) {
                List depositPlugins = viewModel?.plugins?.getDepositPlugins();
                Function currentAmountCb =
                    add(double.parse(drawInfo.reward['amount']));
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
                                    num.parse(drawInfo.reward['estimated'])
                                        .toStringAsFixed(2) +
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
                              stream: Stream.periodic(
                                  Duration(seconds: 1), (i) => i),
                              builder: (BuildContext context,
                                  AsyncSnapshot<int> snapshot) {
                                DateTime endTimestamp = new DateTime.fromMillisecondsSinceEpoch(drawInfo.endTimestamp);
                                Duration remaining = endTimestamp.difference(DateTime.now());
                                List<String> formatted = new DateFormat.m().format(DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds)).split(':');
                                return Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        counter(
                                            context, 'Days', remaining.inDays),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        counter(context, 'Hours',
                                            remaining.inHours),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        counter(context, 'Minutes',
                                            int.parse(formatted[0]))
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Current prize amount:',
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
                                        (i) => drawInfo.reward[
                                                    'growthRatePerSec'] !=
                                                null
                                            ? double.parse(drawInfo
                                                .reward['growthRatePerSec'])
                                            : 0.0),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<double> snapshot) {
                                      if (snapshot.hasError) {
                                        return SizedBox.shrink();
                                      }
                                      double growthedAmount = currentAmountCb(snapshot.data ?? 0.0);
                                      String amount = growthedAmount.toStringAsFixed(5);
                                      String last = amount.substring(amount.length - 3);
                                      String first = amount.substring(0, amount.length - 3);
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                              children: <TextSpan>[
                                                TextSpan(text: first, style: TextStyle(color: Colors.black)),
                                                TextSpan(text: last, style: TextStyle(color: Color(0xFF00BE66))),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            'points',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      );
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Your chances are 1 in ' +
                                drawInfo.possibleWinnersCount.toString(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          depositPlugins.isNotEmpty ? Padding(
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
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DepositWebView(
                                              depositPlugin:
                                                  depositPlugins[0])),
                                    );
                                    await FlutterSegment.track(eventName: 'User clicked on top up');
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
                          ) : SizedBox.shrink(),
                          SizedBox(
                            height: 70,
                          ),
                          drawInfo.previous['winner'] != null
                              ? Text(
                                  'Last prize ' +
                                      (num.parse(drawInfo.previous['reward']).toStringAsFixed(2).toString() ??
                                          '') +
                                      ' went to ' +
                                      formatAddress(
                                          drawInfo.previous['winner']),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                )
                              : SizedBox.shrink(),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                              child: Text(
                                'Learn here how it works',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/WebPage',
                                  arguments: WebViewPageArguments(
                                      url: 'https://docs.fuse.io/the-mobile-wallet/what-is-dai-points',
                                      title: 'What is dai points?'));
                              }),
                        ],
                      ),
                    ),
                  ],
                );
              });
        }
      },
    );
  }
}
