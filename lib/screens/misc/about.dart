import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'dart:core';
import 'package:package_info/package_info.dart';

class AboutScreen extends StatelessWidget {
  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return "${packageInfo.version} ${(packageInfo.buildNumber)}";
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: I18n.of(context).about,
      titleFontSize: 15,
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
                        style: TextStyle(fontSize: 16),
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
                      title: Text(
                        I18n.of(context).legal,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    new Divider(),
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
