import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:peepl/models/app_state.dart';
import 'package:peepl/models/community/community.dart';
import 'package:peepl/models/tokens/token.dart';
import 'package:peepl/redux/actions/cash_wallet_actions.dart';
import 'package:peepl/utils/format.dart';
import 'package:peepl/widgets/my_app_bar.dart';

class WebViewWidget extends StatelessWidget {
  final String url;
  final String title;
  final bool withBack;
  final InAppWebViewController controller;

  WebViewWidget({this.url, this.title, this.withBack = false, this.controller});

  @override
  Widget build(BuildContext context) {
    Segment.screen(screenName: '/web-view-screen');
    return Scaffold(
        appBar: MyAppBar(
          backgroundColor: Colors.white,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withAlpha(20),
                  blurRadius: 5.0,
                  spreadRadius: 0.0,
                  offset: Offset(
                    0.0,
                    3.0,
                  ),
                )
              ],
              color: Color(0xFFF5F5F5),
            ),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(title,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w800))
                      ]),
                  withBack
                      ? Positioned(
                          top: 60,
                          left: 20,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(PlatformIcons(context).back),
                          ))
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
        body: StoreConnector<AppState, InAppWebViewViewModel>(
            converter: InAppWebViewViewModel.fromStore,
            builder: (_, InAppWebViewViewModel viewModel) {
              return InAppWebView(
                // initialUrl: url,
                initialFile: "assets/index.html",
                onWebViewCreated: (InAppWebViewController controller) {
                  controller = controller;
                  controller.addJavaScriptHandler(
                      handlerName: "pay",
                      callback: (args) {
                        print("From the JavaScript side:");
                        Map<String, dynamic> paymentDetails = Map.from(args[0]);
                        print(
                            'paymentDetails ${paymentDetails.toString()} ${paymentDetails['amount']} ${paymentDetails['destination']} ${paymentDetails['currency']}');
                        Token token = viewModel.tokens.firstWhere((token) =>
                            token.symbol.contains(paymentDetails['currency']));
                        Function sendSuccessCallback(jobReponse) {
                          // here you you use the job id. under the job data you can find the transction hash.
                          // or you can track the job status by the job id from our server
                        }
                        ;
                        VoidCallback sendFailureCallback() {}
                        viewModel.sendTokenFromWebView(
                            token,
                            paymentDetails['destination'],
                            num.parse(paymentDetails['amount']),
                            sendSuccessCallback,
                            sendFailureCallback);
                      });
                },
                onConsoleMessage: (InAppWebViewController controller,
                    ConsoleMessage consoleMessage) {
                  print("console message: ${consoleMessage.message}");
                },
              );
            }));
  }
}

class InAppWebViewViewModel extends Equatable {
  final List<Token> tokens;
  final Function(
    Token token,
    String recieverAddress,
    num amount,
    Function(dynamic) sendSuccessCallback,
    VoidCallback sendFailureCallback,
  ) sendTokenFromWebView;

  @override
  List<Object> get props => [
        tokens,
      ];

  InAppWebViewViewModel({
    this.tokens,
    this.sendTokenFromWebView,
  });

  static InAppWebViewViewModel fromStore(Store<AppState> store) {
    List<Community> communities =
        store.state.cashWalletState.communities.values.toList();
    List<Token> foreignTokens = List<Token>.from(
            store.state.proWalletState.erc20Tokens?.values ?? Iterable.empty())
        .where((Token token) =>
            num.parse(formatValue(token.amount, token.decimals,
                    withPrecision: true))
                .compareTo(0) ==
            1)
        .toList();

    List<Token> homeTokens =
        communities.fold<List<Token>>([], (previousValue, Community community) {
      if (community?.secondaryToken != null &&
          community?.secondaryToken?.address != null) {
        previousValue.add(community.secondaryToken
            .copyWith(imageUrl: community.metadata.getImageUri()));
      }
      previousValue.add(
          community.token.copyWith(imageUrl: community.metadata.getImageUri()));
      return previousValue;
    });
    return InAppWebViewViewModel(
      tokens: [...homeTokens, ...foreignTokens]..sort((tokenA, tokenB) =>
          (tokenB?.amount ?? BigInt.zero)
              ?.compareTo(tokenA?.amount ?? BigInt.zero)),
      sendTokenFromWebView: (
        Token token,
        String recieverAddress,
        num amount,
        Function(dynamic) sendSuccessCallback,
        VoidCallback sendFailureCallback,
      ) {
        store.dispatch(sendTokenFromWebViewCall(
          token,
          recieverAddress,
          amount,
          sendSuccessCallback,
          sendFailureCallback,
        ));
      },
    );
  }
}
