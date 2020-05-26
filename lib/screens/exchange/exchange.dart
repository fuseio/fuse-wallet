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

final _tokens = List<Token>.from(exchangableTokens.values);

class Exchange extends StatefulWidget {
  const Exchange({Key key}) : super(key: key);

  @override
  _ExchangeState createState() => _ExchangeState();
}

class _ExchangeState extends State<Exchange> {
  TextEditingController receiveController = TextEditingController();
  TextEditingController payWithController = TextEditingController();
  Token tokenToPayWith;
  Token tokenToReceive;
  final _payWithDebouncer = Debouncer(milliseconds: 500);
  final _receiveDebouncer = Debouncer(milliseconds: 500);
  bool isFetchingPayWith = false;
  bool isFetchingReceive = false;

  @override
  void dispose() {
    payWithController.dispose();
    receiveController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tokenToPayWith = _tokens[0];
    tokenToReceive = _tokens[1];
  }

  void getQuateForPayWith(String value, String walletAddress) async {
    try {
      if (this.mounted) {
        setState(() {
          isFetchingPayWith = true;
        });
      }
      if (value.isEmpty) {
        if (this.mounted) {
          setState(() {
            receiveController.text = '';
            isFetchingPayWith = false;
          });
        }
        return;
      }
      dynamic response = await fetchSwap(walletAddress, tokenToPayWith.address,
          tokenToReceive.address, value, tokenToPayWith.decimals);
      dynamic summary = response['response']['summary'][0];
      String toTokenAmount = formatValue(
          BigInt.from(num.parse(summary['destinationAmount'])),
          tokenToReceive.decimals);
      if (this.mounted) {
        setState(() {
          receiveController.text = toTokenAmount;
          isFetchingPayWith = false;
        });
      }
      return response;
    } catch (error) {
      if (this.mounted) {
        setState(() {
          isFetchingPayWith = false;
        });
      }
    }
  }

  void getQuateForReceive(String value, String walletAddress) async {
    try {
      if (this.mounted) {
        setState(() {
          isFetchingReceive = true;
        });
      }
      if (value.isEmpty) {
        if (this.mounted) {
          setState(() {
            isFetchingReceive = false;
            payWithController.text = '';
          });
        }
        return;
      }
      dynamic response = await fetchSwap(walletAddress, tokenToReceive.address,
          tokenToPayWith.address, value, tokenToReceive.decimals);
      dynamic summary = response['response']['summary'][0];
      String fromTokenAmount = formatValue(
          BigInt.from(num.parse(summary['destinationAmount'])),
          tokenToPayWith.decimals);
      if (this.mounted) {
        setState(() {
          isFetchingReceive = false;
          payWithController.text = fromTokenAmount;
        });
      }
    } catch (error) {
      if (this.mounted) {
        setState(() {
          isFetchingReceive = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ExchangeViewModel>(
        distinct: true,
        onInit: (store) {
          Segment.screen(screenName: '/exchange-screen');
        },
        converter: ExchangeViewModel.fromStore,
        builder: (_, viewModel) {
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
                          ExchangeCard(
                            walletAddress: viewModel.walletAddress,
                            onChanged: (value) {
                              _payWithDebouncer.run(() => getQuateForPayWith(
                                  value, viewModel.walletAddress));
                            },
                            token: tokenToPayWith,
                            tokenToReceive: tokenToReceive,
                            title: 'Pay with',
                            isFetching: isFetchingReceive,
                            textEditingController: payWithController,
                          ),
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
                          ExchangeCard(
                            isFetching: isFetchingPayWith,
                            walletAddress: viewModel.walletAddress,
                            onChanged: (value) {
                              _receiveDebouncer.run(() => getQuateForReceive(
                                  value, viewModel.walletAddress));
                            },
                            textEditingController: receiveController,
                            token: tokenToReceive,
                            tokenToReceive: tokenToPayWith,
                            title: 'Receive',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
            footer: Center(
              child: PrimaryButton(
                labelFontWeight: FontWeight.normal,
                label: I18n.of(context).exchnage,
                fontSize: 15,
                onPressed: () async {},
              ),
            ),
          );
        });
  }
}

class ExchangeViewModel extends Equatable {
  final String walletAddress;

  ExchangeViewModel({this.walletAddress});

  static ExchangeViewModel fromStore(Store<AppState> store) {
    return ExchangeViewModel(
      walletAddress: store.state.userState.walletAddress,
    );
  }

  @override
  List<Object> get props => [walletAddress];
}
