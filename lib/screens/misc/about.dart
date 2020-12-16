import 'package:flutter/material.dart';
import 'package:esol/generated/i18n.dart';
import 'package:esol/widgets/main_scaffold.dart';
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
    return MainScaffold(
      drawerIcon: Icon(Icons.arrow_back),
      expandedHeight: 0.8,
      newHeaderAppBar: SizedBox.shrink(),
      title: Text(I18n.of(context).about),
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
                    Divider(
                      color: Color(0xFFE8E8E8),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 30, left: 30),
                      title: InkWell(
                        onTap: () {
                          // TODO - link to privacy policy
                        },
                        child: Text(
                          I18n.of(context).legal,
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xFFE8E8E8),
                    ),
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
