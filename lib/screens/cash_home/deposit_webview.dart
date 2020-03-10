import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/models/plugins.dart';
import 'package:paywise/screens/routes.gr.dart';
import 'package:paywise/widgets/drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DepositWebView extends StatefulWidget {
  final DepositPlugin depositPlugin;

  DepositWebView({this.depositPlugin});

  @override
  _DepositWebViewState createState() => _DepositWebViewState();
}

class _DepositWebViewState extends State<DepositWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  TextEditingController address = new TextEditingController();

  @override
  void initState() {
    super.initState();
    address.value =
        address.value.copyWith(text: widget.depositPlugin.widgetUrl);
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, DrawerViewModel>(
        converter: DrawerViewModel.fromStore,
        builder: (_, viewModel) {
          return Scaffold(
            body: Builder(builder: (BuildContext context) {
              dynamic depositPlugin = widget.depositPlugin;
              dynamic url = depositPlugin.generateUrl(
                  walletAddress: viewModel.walletAddress);
              return Container(
                constraints: BoxConstraints.expand(),
                child: Stack(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 150),
                        child: WebView(
                            initialUrl: url,
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated:
                                (WebViewController webViewController) {
                              _controller.complete(webViewController);
                            })),
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Theme.of(context).primaryColor.withAlpha(20),
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
                                    Text('Top up',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .body1
                                                .color,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800))
                                  ]),
                              Positioned(
                                  top: 60,
                                  left: 20,
                                  child: InkWell(
                                    onTap: () {
                                      Router.navigator.pop();
                                    },
                                    child: SvgPicture.asset(
                                        'assets/images/arrow.svg'),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
          );
        });
  }
}
