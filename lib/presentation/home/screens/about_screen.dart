import 'package:flutter/material.dart';
import 'package:fusecash/common/di/package_info.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/utils/url.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'dart:core';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      trailing: Text(
                        "${packageInfo.version} ${(packageInfo.buildNumber)}",
                        style: TextStyle(color: Color(0xFF7E7E7E)),
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
