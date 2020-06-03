import 'dart:core';
import 'package:fusecash/redux/actions/pro_mode_wallet_actions.dart';
import 'package:fusecash/screens/pro_routes.gr.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';

class ReviewExchange extends StatelessWidget {
  final Map exchangeSummry;
  const ReviewExchange({Key key, this.exchangeSummry}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        withPadding: true,
        title: I18n.of(context).trade,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    border: Border.all(
                      color: Color(0xFFDEDEDE),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        constraints: BoxConstraints(
                            minHeight: 165,
                            minWidth: MediaQuery.of(context).size.width,
                            maxWidth: MediaQuery.of(context).size.width),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Pay with',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              verticalDirection: VerticalDirection.down,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(
                                  formatValue(
                                      BigInt.from(num.parse(
                                          exchangeSummry['sourceAmount'])),
                                      int.parse(exchangeSummry['sourceAsset']
                                          ['decimals'])),
                                  style: TextStyle(fontSize: 40),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  exchangeSummry['sourceAsset']['symbol'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        constraints: BoxConstraints(
                            minHeight: 165,
                            minWidth: MediaQuery.of(context).size.width,
                            maxWidth: MediaQuery.of(context).size.width),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Receive',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              verticalDirection: VerticalDirection.down,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(
                                  formatValue(
                                      BigInt.from(num.parse(
                                          exchangeSummry['destinationAmount'])),
                                      int.parse(
                                          exchangeSummry['destinationAsset']
                                              ['decimals'])),
                                  style: TextStyle(fontSize: 40),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  exchangeSummry['destinationAsset']['symbol'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
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
                  onPressed: () {
                    viewModel.swap(
                        exchangeSummry['sourceAsset']['address'],
                        exchangeSummry['amount'],
                        exchangeSummry['tx']['to'],
                        exchangeSummry['tx']['data']);
                    ProRouter.navigator.pushNamed(ProRouter.proModeHomeScreen,
                        arguments: ProModeScaffoldArguments(tabIndex: 0));
                  },
                ),
              );
            }));
  }
}

class ReviewExchangeViewModel extends Equatable {
  final String walletAddress;
  final Function(String tokenAddress, num tokensAmoun,
      String swapContractAddress, String swapData) swap;

  ReviewExchangeViewModel({this.walletAddress, this.swap});

  static ReviewExchangeViewModel fromStore(Store<AppState> store) {
    return ReviewExchangeViewModel(
        walletAddress: store.state.userState.walletAddress,
        swap: (String tokenAddress, num tokensAmount,
            String swapContractAddress, String swapData) {
          store.dispatch(totleSwap(
              tokenAddress, tokensAmount, swapContractAddress, swapData));
        });
  }

  @override
  List<Object> get props => [walletAddress];
}
