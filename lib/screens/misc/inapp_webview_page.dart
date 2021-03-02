import 'dart:convert';
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
import 'package:peepl/redux/actions/cash_wallet_actions.dart';

class WebViewWidget extends StatefulWidget {
  final String url;
  final String walletAddress;

  WebViewWidget({
    this.url,
    this.walletAddress,
  });

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  InAppWebViewController webView;

  void _onSuccessCallback(
    String publicToken,
    LinkSuccessMetadata metadata,
  ) async {
    print("onSuccess: $publicToken, metadata: ${metadata.description()}");
    String body = jsonEncode(Map.from(
        {'walletAddress': widget.walletAddress, 'publicToken': publicToken}));
    responseHandler(await client.post(
      'https://stripe.itsaboutpeepl.com/api/plaid/set_access_token',
      body: body,
      headers: {"Content-Type": 'application/json'},
    ));
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
    openLoadingDialog(context);
    Map response = responseHandler(await client.post(
        'https://stripe.itsaboutpeepl.com/api/plaid/create_link_token_for_payment',
        headers: {"Content-Type": 'application/json'},
        body: body));
    Navigator.of(context).pop();
    PlaidLink(
      configuration: LinkConfiguration(
        linkToken: response['link_token'],
      ),
      onSuccess: _onSuccessCallback,
      onEvent: _onEventCallback,
      onExit: _onExitCallback,
    )..open();
  }

  @override
  Widget build(BuildContext context) {
    Segment.screen(screenName: '/web-view-screen');
    return StoreConnector<AppState, InAppWebViewViewModel>(
        converter: InAppWebViewViewModel.fromStore,
        builder: (_, InAppWebViewViewModel viewModel) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Theme.of(context).splashColor,
              toolbarHeight: MediaQuery.of(context).size.height / 17,
              leading: Builder(
                builder: (_) {
                  return IconButton(
                    icon: Icon(
                      PlatformIcons(context).back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      if (webView != null) {
                        webView.goBack();
                      }
                    },
                  );
                },
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
                      sendSuccessCallback(jobId) async {
                        // Flushbar(
                        //   boxShadows: [
                        //     BoxShadow(
                        //       color: Colors.grey[500],
                        //       offset: Offset(0.5, 0.5),
                        //       blurRadius: 5,
                        //     ),
                        //   ],
                        //   titleText: Text(
                        //     'Payment sent',
                        //     style: TextStyle(
                        //         fontSize: 16.0,
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        //   messageText: Text(
                        //     'Go back to home page to track the transction status',
                        //     style:
                        //         TextStyle(fontSize: 14.0, color: Colors.black),
                        //   ),
                        //   backgroundColor:
                        //       Theme.of(ExtendedNavigator.root.context)
                        //           .bottomAppBarColor,
                        //   margin: EdgeInsets.only(
                        //       top: 8, right: 8, left: 8, bottom: 80),
                        //   borderRadius: 8,
                        //   icon: SvgPicture.asset(
                        //     'assets/images/receive_icon.svg',
                        //     width: 20,
                        //     height: 20,
                        //   ),
                        // )..show(context);
                      }

                      sendFailureCallback() {
                        // Flushbar(
                        //     boxShadows: [
                        //       BoxShadow(
                        //         color: Colors.grey[500],
                        //         offset: Offset(0.5, 0.5),
                        //         blurRadius: 5,
                        //       ),
                        //     ],
                        //     titleText: Text(
                        //       I18n.of(ExtendedNavigator.root.context).oops,
                        //       style: TextStyle(
                        //           fontSize: 16.0,
                        //           color: Colors.black,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //     messageText: Text(
                        //       I18n.of(ExtendedNavigator.root.context)
                        //           .something_went_wrong,
                        //       style: TextStyle(
                        //           fontSize: 14.0, color: Colors.black),
                        //     ),
                        //     backgroundColor:
                        //         Theme.of(ExtendedNavigator.root.context)
                        //             .bottomAppBarColor,
                        //     margin: EdgeInsets.only(
                        //         top: 8, right: 8, left: 8, bottom: 80),
                        //     borderRadius: 8,
                        //     icon: SvgPicture.asset(
                        //       'assets/images/failed_icon.svg',
                        //       width: 20,
                        //       height: 20,
                        //     ))
                        //   ..show(context);
                      }

                      viewModel.sendTokenFromWebView(
                        paymentDetails['currency'],
                        paymentDetails['destination'],
                        paymentDetails['amount'],
                        paymentDetails['orderId'],
                        sendSuccessCallback,
                        sendFailureCallback,
                      );
                    },
                  );

                  webView.addJavaScriptHandler(
                      handlerName: "topup",
                      callback: (args) {
                        Map<String, dynamic> data = Map.from(args[0]);
                        _createLinkToken(widget.walletAddress, data['amount']);
                      });
                }),
          );
        });
  }
}

class InAppWebViewViewModel {
  final Function(
    String currency,
    String recieverAddress,
    num amount,
    dynamic orderId,
    Function(dynamic) sendSuccessCallback,
    VoidCallback sendFailureCallback,
  ) sendTokenFromWebView;

  InAppWebViewViewModel({
    this.sendTokenFromWebView,
  });

  static InAppWebViewViewModel fromStore(Store<AppState> store) {
    return InAppWebViewViewModel(
      sendTokenFromWebView: (
        String currency,
        String recieverAddress,
        num amount,
        dynamic orderId,
        Function(dynamic) sendSuccessCallback,
        VoidCallback sendFailureCallback,
      ) {
        store.dispatch(sendTokenFromWebViewCall(
          currency,
          recieverAddress,
          amount,
          orderId,
          sendSuccessCallback,
          sendFailureCallback,
        ));
      },
    );
  }
}
