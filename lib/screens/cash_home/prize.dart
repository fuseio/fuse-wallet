import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/svg.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/models/draw_info.dart';
import 'package:digitalrand/models/views/prize.dart';
import 'package:digitalrand/redux/state/store.dart';
import 'package:digitalrand/screens/cash_home/deposit_webview.dart';
import 'package:digitalrand/screens/cash_home/webview_page.dart';
import 'package:digitalrand/utils/format.dart';
import 'package:digitalrand/widgets/main_scaffold.dart';
import 'package:digitalrand/widgets/preloader.dart';
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

class PrizeScreen extends StatefulWidget {
  @override
  _PrizeScreenState createState() => _PrizeScreenState();
}

class _PrizeScreenState extends State<PrizeScreen> {
  Client client;
  @override
  void initState() {
    super.initState();
    client = new Client();
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
    final logger = await AppFactory().getLogger('Prize');
    try {
      String daiPointsUri = DotEnv().env['DAI_POINTS'];
      Response response = await client.get(daiPointsUri);
      Map<String, dynamic> drawInfoResponse = responseHandler(response);
      final data = drawInfoResponse['data'];
      return data;
    } catch (error, stackTrace) {
      logger.severe('_fetchDaiPointsInfo');
      await AppFactory().reportError(error, stackTrace);
      throw 'Error while fetching prize info';
    }
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
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 20), child: Preloader())
              ]);
        } else if (snapshot.hasError) {
          return new MainScaffold(
              backgroundColor: Colors.white,
              title: '',
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: new Text(
                      'Error....',
                      textAlign: TextAlign.center,
                    ))
              ]);
        } else {
          final data = snapshot.data;
          DrawInfo drawInfo = new DrawInfo(
              endTimestamp: int.parse(data['current']['endTimestamp']),
              previous: data['previous'],
              reward: data['current']['reward'],
              blockNumber: data['current']['blockNumber'],
              possibleWinnersCount: data['current']['possibleWinnersCount']);
          Function currentAmountCb =
              add(double.parse(drawInfo.reward['amount']));
          return MainScaffold(
            backgroundColor: Colors.white,
            title: '',
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
                          'Win DAI points!',
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
                      height: 10,
                    ),
                    Text(
                      'A weekly lottery that you join \n just by holding DAI points',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 16),
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
                          DateTime endTimestamp =
                              new DateTime.fromMillisecondsSinceEpoch(
                                  drawInfo.endTimestamp);
                          Duration remaining =
                              endTimestamp.difference(DateTime.now());
                          List<String> formatted = new DateFormat.Hm()
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
                                  counter(context, 'Hours',
                                      int.parse(formatted[0])),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  counter(context, 'Minutes',
                                      int.parse(formatted[1]))
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
                                  (i) => drawInfo.reward['growthRatePerSec'] !=
                                          null
                                      ? double.parse(
                                          drawInfo.reward['growthRatePerSec'])
                                      : 0.0),
                              builder: (BuildContext context,
                                  AsyncSnapshot<double> snapshot) {
                                if (snapshot.hasError) {
                                  return SizedBox.shrink();
                                }
                                double growthedAmount =
                                    currentAmountCb(snapshot.data ?? 0.0);
                                String amount =
                                    growthedAmount.toStringAsFixed(5);
                                String last =
                                    amount.substring(amount.length - 3);
                                String first =
                                    amount.substring(0, amount.length - 3);
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: first,
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          TextSpan(
                                              text: last,
                                              style: TextStyle(
                                                  color: Color(0xFF00BE66))),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
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
                    new StoreConnector<AppState, PrizeViewModel>(
                        distinct: true,
                        onInit: (store) {
                          Segment.screen(screenName: '/prize-scree');
                        },
                        converter: PrizeViewModel.fromStore,
                        builder: (_, viewModel) {
                          List depositPlugins =
                              viewModel?.plugins?.getDepositPlugins();
                          return depositPlugins.isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                builder: (context) =>
                                                    DepositWebView(
                                                        depositPlugin:
                                                            depositPlugins[0]),
                                                fullscreenDialog: true),
                                          );
                                          Segment.track(
                                              eventName:
                                                  'User clicked on top up');
                                        },
                                        child: Text(
                                          'Top up to improve your chances',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox.shrink();
                        }),
                    SizedBox(
                      height: 40,
                    ),
                    drawInfo.previous['winner'] != null
                        ? Text(
                            'Last prize ' +
                                (num.parse(drawInfo.previous['reward'])
                                        .toStringAsFixed(2)
                                        .toString() ??
                                    '') +
                                ' went to ' +
                                formatAddress(drawInfo.previous['winner']),
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.secondary),
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
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => WebViewPage(
                                        pageArgs: WebViewPageArguments(
                                            url:
                                                'https://docs.fuse.io/the-mobile-wallet/what-is-dai-points',
                                            title: 'What is dai points?'),
                                      )));
                        }),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
