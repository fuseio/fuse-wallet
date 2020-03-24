import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:localpay/generated/i18n.dart';
import 'package:localpay/screens/pro_routes.gr.dart';
import 'package:localpay/screens/routes.gr.dart';
import 'package:localpay/themes/custom_theme.dart';

class MainWrapper extends StatefulWidget {
  final GeneratedLocalizationsDelegate i18n;
  final bool isProMode;
  final bool isNavigated;
  final bool isLoggedIn;
  MainWrapper(
      {Key key, this.i18n, this.isProMode, this.isNavigated, this.isLoggedIn})
      : super(key: key);

  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: MaterialApp(
      title: 'Fuse Cash',
      initialRoute: widget.isProMode
          ? ProRouter.proModeHomeScreen
          : widget.isLoggedIn
            ? Router.cashHomeScreen
            : Router.splashScreen,
      navigatorKey:
          widget.isProMode ? ProRouter.navigator.key : Router.navigator.key,
      onGenerateRoute:
          widget.isProMode ? ProRouter.onGenerateRoute : Router.onGenerateRoute,
      theme: CustomTheme.of(context),
      localizationsDelegates: [
        widget.i18n,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: widget.i18n.supportedLocales,
      localeResolutionCallback:
          widget.i18n.resolution(fallback: new Locale("en", "US")),
      navigatorObservers: [SegmentObserver()],
    ));
  }
}
