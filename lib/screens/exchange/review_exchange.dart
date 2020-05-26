import 'dart:core';
import 'package:fusecash/utils/debouncer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/constans/exchangable_tokens.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/screens/exchange/card.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';

class ReviewExchange extends StatefulWidget {
  const ReviewExchange({Key key}) : super(key: key);

  @override
  _ReviewExchangeState createState() => _ReviewExchangeState();
}

class _ReviewExchangeState extends State<ReviewExchange> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        withPadding: true,
        title: I18n.of(context).exchnage,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Use max',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF4FCFF),
                    border: Border.all(
                      color: Color(0xFFCCE0E8),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: SizedBox(
                              child: Divider(
                                thickness: 1.0,
                                color: Color(0xFFD0E3EA),
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                'assets/images/swap_icon.svg',
                                fit: BoxFit.fill,
                                width: 40,
                                height: 40,
                                alignment: Alignment.topLeft,
                              ))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
        footer: new StoreConnector<AppState, ReviewExchangeViewModel>(
            distinct: true,
            onInit: (store) {
              Segment.screen(screenName: '/exchange-screen');
            },
            converter: ReviewExchangeViewModel.fromStore,
            builder: (_, viewModel) {
              return Center(
                child: PrimaryButton(
                  labelFontWeight: FontWeight.normal,
                  label: I18n.of(context).exchnage,
                  fontSize: 15,
                  onPressed: () async {},
                ),
              );
            }));
  }
}

class ReviewExchangeViewModel extends Equatable {
  final String walletAddress;

  ReviewExchangeViewModel({this.walletAddress});

  static ReviewExchangeViewModel fromStore(Store<AppState> store) {
    return ReviewExchangeViewModel(
      walletAddress: store.state.userState.walletAddress,
    );
  }

  @override
  List<Object> get props => [walletAddress];
}
