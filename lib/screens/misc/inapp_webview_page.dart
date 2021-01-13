import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:peepl/services.dart';
import 'package:peepl/utils/send.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:redux/redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:peepl/models/app_state.dart';
import 'package:peepl/models/tokens/token.dart';
import 'package:peepl/redux/actions/cash_wallet_actions.dart';
import 'package:peepl/utils/format.dart';
import 'package:peepl/widgets/my_app_bar.dart';

class WebViewWidget extends StatefulWidget {
  final String url;

  WebViewWidget({this.url});

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  PlaidLink _plaidLinkToken;
  ContextMenu contextMenu;
  InAppWebViewController webView;

  void _onSuccessCallback(String publicToken, LinkSuccessMetadata metadata,
      String walletAddress) async {
    print("onSuccess: $publicToken, metadata: ${metadata.description()}");
    String body = jsonEncode(
        Map.from({'walletAddress': walletAddress, 'publicToken': publicToken}));
    print('body body body $body');
    Map res = responseHandler(await client.post(
      'http://ec2-18-198-1-146.eu-central-1.compute.amazonaws.com/api/plaid/set_access_token',
      body: body,
      headers: {"Content-Type": 'application/json'},
    ));
    print('res res res ${res.toString()}');
  }

  void _onEventCallback(String event, LinkEventMetadata metadata) {
    print("onEvent: $event, metadata: ${metadata.description()}");
  }

  void _onExitCallback(String error, LinkExitMetadata metadata) {
    print("onExit: $error, metadata: ${metadata.description()}");
  }

  void _createLinkToken(walletAddress, amount) async {
    String body = jsonEncode(Map.from({
      'walletAddress': walletAddress,
      'value': num.parse(amount),
    }));
    print('body body body $body');
    openLoadingDialog(context);
    Map response = responseHandler(await client.post(
        'http://ec2-18-198-1-146.eu-central-1.compute.amazonaws.com/api/plaid/create_link_token_for_payment',
        headers: {"Content-Type": 'application/json'},
        body: body));
    print('response ${response.toString()}');
    Navigator.of(context).pop();
    setState(() {
      _plaidLinkToken = PlaidLink(
        configuration: LinkConfiguration(
          linkToken: response['link_token'],
        ),
        onSuccess: (String publicToken, LinkSuccessMetadata metadata) {
          print("onSuccess: $publicToken, metadata: ${metadata.description()}");
          _onSuccessCallback(publicToken, metadata, walletAddress);
        },
        onEvent: _onEventCallback,
        onExit: _onExitCallback,
      );
    });

    if (_plaidLinkToken != null) {
      _plaidLinkToken.open();
    }
  }

  @override
  Widget build(BuildContext context) {
    Segment.screen(screenName: '/web-view-screen');
    return StoreConnector<AppState, InAppWebViewViewModel>(
        converter: InAppWebViewViewModel.fromStore,
        builder: (_, InAppWebViewViewModel viewModel) {
          return Scaffold(
            appBar: MyAppBar(
              height: MediaQuery.of(context).size.height / 20,
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
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(PlatformIcons(context).back),
                              onPressed: () {
                                if (webView != null) {
                                  webView.goBack();
                                }
                              },
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            body: InAppWebView(
                initialUrl: widget.url,
                // initialFile: "assets/index.html",
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                  webView.addJavaScriptHandler(
                      handlerName: "pay",
                      callback: (args) {
                        Map<String, dynamic> paymentDetails = Map.from(args[0]);
                        print(
                            'paymentDetails ${paymentDetails.toString()} ${paymentDetails['amount']} ${paymentDetails['destination']} ${paymentDetails['currency']}');
                        Token token = viewModel.tokens.firstWhere((token) =>
                            token.symbol.contains(paymentDetails['currency']));
                        VoidCallback sendSuccessCallback(jobReponse) {
                          // here you you use the job id. under the job data you can find the transction hash.
                          // or you can track the job status by the job id from our server
                        }
                        ;
                        VoidCallback sendFailureCallback() {}
                        viewModel.sendTokenFromWebView(
                            token,
                            paymentDetails['orderId'],
                            paymentDetails['destination'],
                            paymentDetails['amount'],
                            sendSuccessCallback,
                            sendFailureCallback);
                      });

                  webView.addJavaScriptHandler(
                      handlerName: "topup",
                      callback: (args) {
                        Map<String, dynamic> data = Map.from(args[0]);
                        _createLinkToken(
                            viewModel.walletAddress, data['amount']);
                      });
                }),
          );
        });
  }
}

class InAppWebViewViewModel extends Equatable {
  final List<Token> tokens;
  final String walletAddress;
  final Function(
    Token token,
    String orderId,
    String recieverAddress,
    num amount,
    Function(dynamic) sendSuccessCallback,
    VoidCallback sendFailureCallback,
  ) sendTokenFromWebView;

  @override
  List<Object> get props => [
        tokens,
        walletAddress,
      ];

  InAppWebViewViewModel({
    this.tokens,
    this.sendTokenFromWebView,
    this.walletAddress,
  });

  static InAppWebViewViewModel fromStore(Store<AppState> store) {
    List<Token> foreignTokens = List<Token>.from(
            store.state.proWalletState.erc20Tokens?.values ?? Iterable.empty())
        .where((Token token) =>
            num.parse(formatValue(token.amount, token.decimals,
                    withPrecision: true))
                .compareTo(0) ==
            1)
        .toList();

    List<Token> homeTokens = store.state.cashWalletState.tokens.values
        .where((Token token) =>
            num.parse(formatValue(token.amount, token.decimals, withPrecision: true))
                .compareTo(0) ==
            1)
        .map((Token token) => token?.copyWith(
            imageUrl: store.state.cashWalletState.communities
                    .containsKey(token.communityAddress)
                ? store.state.cashWalletState
                    .communities[token.communityAddress].metadata
                    .getImageUri()
                : null))
        .toList();
    return InAppWebViewViewModel(
      walletAddress: store.state.userState.walletAddress,
      tokens: [...homeTokens, ...foreignTokens]..sort((tokenA, tokenB) =>
          (tokenB?.amount ?? BigInt.zero)
              ?.compareTo(tokenA?.amount ?? BigInt.zero)),
      sendTokenFromWebView: (
        Token token,
        String orderId,
        String recieverAddress,
        num amount,
        Function(dynamic) sendSuccessCallback,
        VoidCallback sendFailureCallback,
      ) {
        store.dispatch(sendTokenFromWebViewCall(
          token,
          orderId,
          recieverAddress,
          amount,
          sendSuccessCallback,
          sendFailureCallback,
        ));
      },
    );
  }
}
