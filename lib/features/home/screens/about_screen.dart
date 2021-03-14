import 'package:flutter/material.dart';
import 'package:fusecash/common/di/package_info.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/utils/url.dart';
import 'dart:core';

import 'package:fusecash/widgets/my_scaffold.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I18n.of(context).about,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: ListView(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                children: <Widget>[
                  ListTile(
                    contentPadding:
                        EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 30),
                    title: Text(
                      I18n.of(context).version,
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Text(
                      "${packageInfo.version} ${(packageInfo.buildNumber)}",
                      style: TextStyle(color: Color(0xFF7E7E7E)),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    contentPadding:
                        EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 30),
                    title: InkWell(
                      focusColor: Theme.of(context).canvasColor,
                      highlightColor: Theme.of(context).canvasColor,
                      onTap: () {
                        // TODO - link to privacy policy
                      },
                      child: Text(
                        I18n.of(context).legal,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      right: 30,
                      left: 30,
                    ),
                    title: InkWell(
                      focusColor: Theme.of(context).canvasColor,
                      highlightColor: Theme.of(context).canvasColor,
                      onTap: () {
                        launchUrl('mailto:hello@fuse.io');
                      },
                      child: Text(
                        I18n.of(context).contact_us,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
