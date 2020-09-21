import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/widgets/my_app_bar.dart';

class WebViewWidget extends StatelessWidget {
  final String url;
  final String title;
  final bool withBack;

  WebViewWidget({this.url, this.title, this.withBack = false});

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
        body: InAppWebView(initialUrl: url));
  }
}
