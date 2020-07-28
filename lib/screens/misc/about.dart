import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:digitalrand/generated/i18n.dart';
import 'package:digitalrand/widgets/main_scaffold.dart';
import 'dart:core';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

launchUrl(url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false);
  } else {
    throw 'Could not launch $url';
  }
}

class AboutScreen extends StatelessWidget {
  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return "${packageInfo.version} ${(packageInfo.buildNumber)}";
  }

  @override
  Widget build(BuildContext context) {
    Segment.screen(screenName: '/about-screen');
    return MainScaffold(
      title: I18n.of(context).about,
      withPadding: true,
      children: <Widget>[
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 30, left: 30),
                      title: Text(
                        I18n.of(context).version,
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor),
                      ),
                      trailing: FutureBuilder(
                        future: getVersionNumber(),
                        builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) =>
                            Text(
                          snapshot.hasData ? snapshot.data : "...",
                          style: TextStyle(color: Color(0xFF7E7E7E)),
                        ),
                      ),
                    ),
                    new Divider(),
                    ListTile(
                      contentPadding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 30, left: 30),
                      title: InkWell(
                        onTap: () {
                          launchUrl(
                              'https://digitalrand.co.za/legal/terms.html');
                        },
                        child: Text(
                          I18n.of(context).legal,
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    new Divider(),
                    ListTile(
                      contentPadding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 30, left: 30),
                      title: InkWell(
                        onTap: () {
                          launchUrl('mailto:hello@fuse.io');
                        },
                        child: Text(
                          I18n.of(context).contact_us,
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
