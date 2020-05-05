import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPageArguments {
  final String url;
  final String title;
  final bool withBack;

  WebViewPageArguments({this.title, this.url, this.withBack = true});
}

class WebViewPage extends StatefulWidget {
  final WebViewPageArguments pageArgs;

  WebViewPage({this.pageArgs});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    final WebViewPageArguments webPageArgs = this.widget.pageArgs;
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: WebView(
                      initialUrl: webPageArgs.url,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController webViewController) {
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
                              Text(webPageArgs.title,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800))
                            ]),
                        webPageArgs.withBack
                            ? Positioned(
                                top: 60,
                                left: 20,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: SvgPicture.asset(
                                      'assets/images/arrow.svg'),
                                ))
                            : SizedBox.shrink(),
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
  }
}
