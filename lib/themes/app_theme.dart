import 'package:flutter/material.dart';

enum MyThemeKeys { DEFAULT, PAYWISE, OPEN_MONEY, GOOD_DOLLAR, WEPY }

class MyThemes {
  static final ThemeData defaultTheme = getTheme();

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.DEFAULT:
        return defaultTheme;
      default:
        return defaultTheme;
    }
  }
}

ThemeData getTheme() {
  return ThemeData(
    colorScheme: ColorScheme.light().copyWith(
      secondary: Color(0xFF808080),
    ),
    appBarTheme: AppBarTheme(
      color: Color.fromRGBO(0, 85, 255, 0),
    ),
    backgroundColor: Color(0xFFF5F5F5),
    bottomAppBarColor: Color(0xFFF8F8F8),
    fontFamily: 'Exo',
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Color.fromRGBO(245, 246, 249, 1),
    primaryColorDark: Color(0xFF0055FF),
    buttonColor: Color(0xFFFFBE00),
    splashColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF05283e)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Colors.black.withOpacity(0.1), width: 2),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF05283e)),
            borderRadius: BorderRadius.all(Radius.circular(26.0))),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(26.0))),
        focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(26.0))),
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 30)),
  );
}
