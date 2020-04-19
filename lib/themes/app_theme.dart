import 'package:flutter/material.dart';

enum MyThemeKeys { DEFAULT, PAYWISE, OPEN_MONEY, GOOD_DOLLAR, WEPY }

class MyThemes {
  static final ThemeData defaultTheme = getTheme();

  static final ThemeData paywiseTheme = getTheme().copyWith(
      primaryColorLight: const Color(0xFF8AD57F),
      primaryColorDark: const Color(0xFF1876B5),
      buttonColor: const Color(0xFF8AD57F),
      textTheme: TextTheme(button: new TextStyle(color: Colors.white)));

  static final ThemeData openMoneyTheme = getTheme().copyWith(
      primaryColorLight: const Color(0xFF65944A),
      primaryColorDark: const Color(0xFF2C4514),
      textTheme: TextTheme(button: new TextStyle(color: Colors.white)));

  static final ThemeData goodDollarTheme = getTheme().copyWith(
      primaryColorLight: const Color(0xFF02B0FF),
      primaryColorDark: const Color(0xFF00B247),
      textTheme: TextTheme(button: new TextStyle(color: Colors.white)));

  static final ThemeData wepyTheme = getTheme().copyWith(
      primaryColorLight: const Color(0xFF06DEA4),
      primaryColorDark: const Color(0xFF1077D8),
      textTheme: TextTheme(button: new TextStyle(color: Colors.white)));

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.DEFAULT:
        return defaultTheme;
      case MyThemeKeys.PAYWISE:
        return paywiseTheme;
      case MyThemeKeys.OPEN_MONEY:
        return openMoneyTheme;
      case MyThemeKeys.GOOD_DOLLAR:
        return goodDollarTheme;
      case MyThemeKeys.WEPY:
        return wepyTheme;
      default:
        return defaultTheme;
    }
  }
}

ThemeData getTheme() {
  ColorScheme myScheme = new ColorScheme.light().copyWith(
      background: Color(0xFFF5F5F5),
      primary: Colors.black,
      secondary: Color(0xFF808080),
      secondaryVariant: Color(0xFFF5F5F5));
  return ThemeData(
    colorScheme: myScheme,
    backgroundColor: Color(0xFFF5F5F5),
    bottomAppBarColor: const Color(0xFFF8F8F8),
    fontFamily: 'Europa', //'Source',  //'Gotham',
    brightness: Brightness.light,
    primaryColor: Colors.black,
    accentColor: const Color(0xFFA5A5A5),
    canvasColor: const Color(0xFFF8F8F8),
    scaffoldBackgroundColor: Colors.white,
    textSelectionHandleColor: const Color(0xFF05283e),
    textSelectionColor: Colors.black12,
    cursorColor: const Color(0xFF05283e),
    toggleableActiveColor: const Color(0xFF05283e),
    primaryColorLight: const Color(0xFF414C74),
    primaryColorDark: const Color(0xFF06144C),
    buttonColor: const Color(0xFF0462FF),
    splashColor: Colors.white,
    textTheme: TextTheme(button: new TextStyle(color: const Color(0xFF333333))),
    inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFF05283e)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Colors.black.withOpacity(0.1), width: 2),
        ),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: const Color(0xFF05283e)),
            borderRadius: BorderRadius.all(Radius.circular(26.0))),
        errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(26.0))),
        focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(26.0))),
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 30)),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
  );
}
