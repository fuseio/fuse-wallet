import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    backgroundColor: _backgroundColor,
    bottomAppBarColor: _bottomAppBarColor,
    fontFamily: 'Europa',
    textSelectionHandleColor: _textSelectionHandleColor,
    brightness: Brightness.light,
    primaryColor: _primaryColor,
    hintColor: _hintColor,
    textTheme: _textTheme,
    cursorColor: _cursorColor,
    scaffoldBackgroundColor: _scaffoldBackgroundColor,
    unselectedWidgetColor: _unselectedWidgetColor,
    toggleableActiveColor: _toggleableActiveColor,
    primaryColorLight: _primaryColorLight,
    primaryColorDark: _primaryColorDark,
    buttonColor: _buttonColor,
    accentColor: _accentColor,
    splashColor: _splashColor,
    colorScheme: _colorScheme,
    canvasColor: _canvasColor,
    inputDecorationTheme: _inputDecorationTheme,
  );

  static const Color _primaryColor = Colors.black;
  static const Color _hintColor = Color(0xffaaaaaa);
  static const Color _canvasColor = Color(0xFFF8F8F8);
  static const Color _accentColor = Color(0xFFA5A5A5);
  static const Color _unselectedWidgetColor = Color(0xffcccccc);
  static const Color _scaffoldBackgroundColor = Colors.white;
  static const Color _toggleableActiveColor = Color(0xFF05283e);
  static const Color _cursorColor = Color(0xFFA5A5A5);
  static const Color _primaryColorLight = Color(0xFFFEFD86);
  static const Color _primaryColorDark = Color(0xFFB1FDC0);
  static const Color _buttonColor = Color(0xFFB1FDC0);
  static const Color _splashColor = Colors.white;
  static const Color _textSelectionHandleColor = Color(0xFF05283e);
  static const Color _bottomAppBarColor = Color(0xFFF8F8F8);
  static const Color _backgroundColor = Color(0xFFF5F5F5);

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
          color: Color(
        0xFF05283e,
      )),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black.withOpacity(
          0.1,
        ),
        width: 2,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF05283e),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(26.0),
      ),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(26.0),
      ),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(26.0),
      ),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 18,
      horizontal: 30,
    ),
  );

  static final TextTheme _textTheme = TextTheme(
    button: new TextStyle(
      color: const Color(0xFF333333),
    ),
  );

  static final ColorScheme _colorScheme = ColorScheme.light().copyWith(
    background: Color(0xFFF5F5F5),
    primary: Colors.black,
    secondary: Color(0xFF808080),
    secondaryVariant: Color(0xFFF5F5F5),
  );
}
