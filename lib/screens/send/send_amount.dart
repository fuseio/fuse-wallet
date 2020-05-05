import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:roost/generated/i18n.dart';
import 'package:roost/models/community.dart';
import 'package:roost/screens/send/send_amount_arguments.dart';
import 'package:roost/screens/send/send_review.dart';
import 'package:roost/utils/format.dart';
import 'package:roost/widgets/main_scaffold.dart';
import 'package:roost/widgets/primary_button.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';
import 'package:roost/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:roost/models/token.dart';

class SendAmountScreen extends StatefulWidget {
  final SendAmountArguments pageArgs;
  SendAmountScreen({this.pageArgs});
  @override
  _SendAmountScreenState createState() => _SendAmountScreenState();
}

class _SendAmountScreenState extends State<SendAmountScreen>
    with SingleTickerProviderStateMixin {
  String amountText = "0";
  AnimationController controller;
  Animation<Offset> offset;
  bool isPreloading = false;
  Token dropdownValue;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<dynamic>> buildDropdownMenuItems(
      List<Token> options, Community community) {
    return options.map((Token token) {
      return DropdownMenuItem(
        value: token,
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // CachedNetworkImage(
              //   width: 25,
              //   height: 25,
              //   imageUrl: getIPFSImageUrl(community.metadata.image),
              //   placeholder: (context, url) => CircularProgressIndicator(),
              //   errorWidget: (context, url, error) => Image(
              //     image: NetworkImage(
              //       'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png',
              //     ),
              //     width: 25,
              //     height: 25,
              //   ),
              // ),
              SizedBox(
                width: 5,
              ),
              Text(token.symbol,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w900)),
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    Segment.screen(screenName: '/send-amount-screen');
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    offset = Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset.zero).animate(
        new CurvedAnimation(parent: controller, curve: Curves.easeInOutQuad));
  }

  @override
  Widget build(BuildContext context) {
    final SendAmountArguments args = this.widget.pageArgs;
    String title =
        "${I18n.of(context).send_to} ${args.name != null ? args.name : formatAddress(args.accountAddress)}";
    return new StoreConnector<AppState, SendAmountViewModel>(
      converter: SendAmountViewModel.fromStore,
      onInitialBuild: (viewModel) {
        setState(() {
          dropdownValue = viewModel.tokens[0];
        });
      },
      builder: (_, viewModel) {
        _onKeyPress(VirtualKeyboardKey key) {
          if (key.keyType == VirtualKeyboardKeyType.String) {
            if (amountText == "0") {
              amountText = "";
            }
            amountText = amountText + key.text;
          } else if (key.keyType == VirtualKeyboardKeyType.Action) {
            switch (key.action) {
              case VirtualKeyboardKeyAction.Backspace:
                if (amountText.length == 0) return;
                amountText = amountText.substring(0, amountText.length - 1);
                break;
              case VirtualKeyboardKeyAction.Return:
                amountText = amountText + '\n';
                break;
              case VirtualKeyboardKeyAction.Space:
                amountText = amountText + key.text;
                break;
              default:
            }
          }
          setState(() {});
          if (amountText == "") {
            amountText = "0";
          }
          if (viewModel.isProMode) {
            if (args.sendToCashMode) {
              try {
                double amount = double.parse(amountText);
                BigInt currentBalance = toBigInt(amount, args.erc20Token.decimals);
                if (amount > 0 && args.erc20Token.amount >= currentBalance) {
                  controller.forward();
                } else {
                  controller.reverse();
                }
              } catch (e) {
                controller.reverse();
              }
            } else {
              try {
                double amount = double.parse(amountText);
                BigInt currentBalance = toBigInt(amount, args.erc20Token.decimals);
                if (amount > 0 && args.erc20Token.amount >= currentBalance) {
                  controller.forward();
                } else {
                  controller.reverse();
                }
              } catch (e) {
                controller.reverse();
              }
            }
          } else {
            try {
              BigInt balance = dropdownValue == viewModel.tokens[0]
                  ? viewModel.balance
                  : viewModel.secondaryTokenBalance;
              double amount = double.parse(amountText);
              if (amount > 0 && balance >= toBigInt(amount, dropdownValue.decimals)) {
                controller.forward();
              } else {
                controller.reverse();
              }
            } catch (e) {
              controller.reverse();
            }
          }
        }

        final dropOptions = buildDropdownMenuItems(viewModel.tokens, viewModel.community);
        bool hasSecondToken = (viewModel.community.secondaryToken.address != null && viewModel.community.secondaryToken.address != '');
        return MainScaffold(
            withPadding: true,
            title: title,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text(I18n.of(context).how_much,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal)),
                            !hasSecondToken
                                ? Container(
                                    padding:
                                        EdgeInsets.only(top: 30.0, bottom: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: <Widget>[
                                        Text('$amountText ',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 50,
                                                fontWeight: FontWeight.w900)),
                                        Text(
                                            args.erc20Token != null
                                                ? args.erc20Token.symbol
                                                : viewModel.token.symbol,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w900)),
                                      ],
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 20.0, bottom: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: <Widget>[
                                            Text('$amountText ',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: 50,
                                                    fontWeight:
                                                        FontWeight.w900)),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          width: 150,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: DropdownButtonHideUnderline(
                                            child: Center(
                                              child: DropdownButton(
                                                hint: Container(
                                                    alignment: Alignment.center,
                                                    width: 100,
                                                    child:
                                                        Text('Choose token')),
                                                value: dropdownValue,
                                                selectedItemBuilder:
                                                    (BuildContext context) {
                                                  return viewModel.tokens
                                                      .map<Widget>((Token token) => Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 100,
                                                          child: Text(
                                                              token.symbol,
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  fontSize: 30,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900))))
                                                      .toList();
                                                },
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    dropdownValue = newValue;
                                                  });
                                                },
                                                items: dropOptions,
                                              ),
                                            ),
                                          )),
                                    ],
                                  )
                          ],
                        ),
                      ),
                      VirtualKeyboard(
                          height: MediaQuery.of(context).size.height * 0.37,
                          fontSize: 28,
                          textColor: Theme.of(context).primaryColor,
                          type: VirtualKeyboardType.Numeric,
                          onKeyPress: _onKeyPress),
                    ]),
              )
            ],
            footer: Center(
                child: SlideTransition(
              position: offset,
              child: PrimaryButton(
                labelFontWeight: FontWeight.normal,
                label: I18n.of(context).continue_with +
                    ' $amountText ${hasSecondToken ? dropdownValue.symbol : viewModel.token.symbol}',
                onPressed: () {
                  if (hasSecondToken) {
                    args.tokenToSend = dropdownValue;
                  }
                  args.amount = num.parse(amountText);
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => SendReviewScreen(
                                pageArgs: args,
                              )));
                },
                preload: isPreloading,
                width: 300,
              ),
            )));
      },
    );
  }
}

class SendAmountViewModel extends Equatable {
  final BigInt balance;
  final BigInt secondaryTokenBalance;
  final Token token;
  final bool isProMode;
  final Community community;
  final List<Token> tokens;

  SendAmountViewModel(
      {this.balance,
      this.token,
      this.isProMode,
      this.community,
      this.tokens,
      this.secondaryTokenBalance});

  static SendAmountViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres] ??
            new Community.initial();
    List<Token> tokens = List.from([])
      ..addAll([community.token, community.secondaryToken]);
    return SendAmountViewModel(
        isProMode: store.state.userState.isProMode ?? false,
        token: community.token,
        balance: community.tokenBalance,
        community: community,
        tokens: tokens,
        secondaryTokenBalance: community.secondaryTokenBalance);
  }

  @override
  List<Object> get props => [
        isProMode,
        tokens,
        token,
        balance,
        community,
        secondaryTokenBalance,
      ];
}
