import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/prize.dart';
import 'package:fusecash/widgets/bottombar.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'dart:core';

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
  print(a);
  bool isBigerThen = number > 10;
  String firstNum = isBigerThen ? a.split('')[0] : 0;
  String secondNum = isBigerThen ? a.split('')[1] : 0;
  print(firstNum);
  print(secondNum);
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
  print('$text $value');
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext _context) {
    return new StoreConnector<AppState, PrizeViewModel>(
        converter: PrizeViewModel.fromStore,
        builder: (_, viewModel) {
          final DateTime dateTime = new DateTime.fromMillisecondsSinceEpoch(
              viewModel.drawInfo.endTimestamp * 1000);
          print(dateTime.toLocal());
          // DateFormat temp = DateFormat('dd-MM-yyyy hh:mm a');
          final num days = dateTime.day;
          final int hour = dateTime.hour;
          final int minute = dateTime.minute;
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
                              num.parse(viewModel.drawInfo.reward['estimated'])
                                  .toStringAsFixed(4) +
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        counter(context, 'Days', days),
                        SizedBox(
                          width: 30,
                        ),
                        counter(context, 'Hours', hour),
                        SizedBox(
                          width: 30,
                        ),
                        counter(context, 'Minutes', minute),
                      ],
                    ),
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
                          // Padding(
                          //   padding: EdgeInsets.only(top: 10),
                          //   child: Container(
                          //     width: 60.0,
                          //     padding: EdgeInsets.only(top: 3.0, right: 4.0),
                          //     child: CountDownTimer(
                          //       secondsRemaining: 30,
                          //       whenTimeExpires: () {
                          //         print('dfsdf');
                          //       },
                          //       countDownTimerStyle: TextStyle(
                          //           fontSize: 20, fontWeight: FontWeight.bold),
                          //     ),
                          //   ),
                          // )

                            Text(
                              num.parse(viewModel.drawInfo.reward['amount'])
                                      .toStringAsFixed(4) +
                                  ' points',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
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
                          Text(
                            'Top up to improve your chances',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      'Last prize 3500 went to Gilat',
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
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
