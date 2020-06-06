import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:farmlyledger/widgets/my_app_bar.dart';

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
  @override
  Widget build(BuildContext context) {
    final WebViewPageArguments webPageArgs = this.widget.pageArgs;
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return WebviewScaffold(
            url: webPageArgs.url,
            appBar: MyAppBar(
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
                                child:
                                    SvgPicture.asset('assets/images/arrow.svg'),
                              ))
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ));
      }),
    );
  }
}
