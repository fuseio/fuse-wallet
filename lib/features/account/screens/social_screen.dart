import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fusecash/features/account/widgets/menu_tile.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/utils/url.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
import 'package:rate_my_app/rate_my_app.dart';

class SocialScreen extends StatelessWidget {
  final RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 2,
    remindDays: 7,
    remindLaunches: 10,
    googlePlayIdentifier: 'io.fuse.cash',
    appStoreIdentifier: '1559937899',
  );
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).social,
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            MenuTile(
              label: I10n.of(context).rate_us,
              menuIcon: Platform.isIOS ? 'store.svg' : 'google_store.svg',
              onTap: () {
                rateMyApp.init().then(
                  (_) {
                    if (rateMyApp.shouldOpenDialog) {
                      rateMyApp.showStarRateDialog(
                        context,
                        title: 'Rate this app',
                        message:
                            'You like this app ? Then take a little bit of your time to leave a rating :',
                        actionsBuilder: (context, stars) {
                          return [
                            TextButton(
                              child: Text('OK'),
                              onPressed: () async {
                                log.info('Thanks for the ' +
                                    (stars == null
                                        ? '0'
                                        : stars.round().toString()) +
                                    ' star(s) !');
                                await rateMyApp.callEvent(
                                    RateMyAppEventType.rateButtonPressed);
                                Navigator.pop<RateMyAppDialogButton>(
                                    context, RateMyAppDialogButton.rate);
                              },
                            ),
                          ];
                        },
                        ignoreNativeDialog:
                            false, // This is the one parameter i set to false
                        dialogStyle: DialogStyle(
                          titleAlign: TextAlign.center,
                          messageAlign: TextAlign.center,
                          messagePadding: EdgeInsets.only(bottom: 20),
                        ),
                        starRatingOptions: StarRatingOptions(),
                        onDismissed: () => rateMyApp
                            .callEvent(RateMyAppEventType.laterButtonPressed),
                      );
                    }
                  },
                );
              },
            ),
            Divider(),
            MenuTile(
              label: I10n.of(context).follow_us_on_twitter,
              menuIcon: 'twitter.svg',
              onTap: () {
                launchUrl('https://twitter.com/Fuse_network?s=20');
              },
            ),
          ],
        ),
      ),
    );
  }
}
