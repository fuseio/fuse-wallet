// import 'package:flex_color_scheme/flex_color_scheme.dart';
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
    dividerColor: _dividerColor,
    inputDecorationTheme: _inputDecorationTheme,
  );

  static const Color _primaryColor = Colors.black;
  static const Color _dividerColor = Color(0xFFE3E3E3);
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
    headline1: TextStyle(
      fontSize: 32,
      color: _colorScheme.primary,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontSize: 18,
      color: _colorScheme.primary,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontSize: 18,
      color: _colorScheme.primary,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      color: _colorScheme.secondaryVariant,
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
    ),
    subtitle2: TextStyle(
      color: _colorScheme.secondaryVariant,
      fontSize: 10.0,
      fontWeight: FontWeight.normal,
    ),
  );

  static final ColorScheme _colorScheme = ColorScheme.light().copyWith(
    primary: Color(0xFF38D989),
    secondary: Colors.black,
    secondaryVariant: Color(0xFFF5F5F5),
    primaryVariant: Color(0xFF454545),
    surface: Colors.white,
    background: Colors.white,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Color(0xFFFFFFF),
  );
}

// Create a custom flex scheme color for a light theme.
// const FlexSchemeColor myScheme1Light = FlexSchemeColor.from(
//   primary: Color(0xFF38D989),

// );

// Create a corresponding custom flex scheme color for a dark theme.
// const FlexSchemeColor myScheme1Dark = FlexSchemeColor(
//   primary: Color(0xFF9E7389),
//   primaryVariant: Color(0xFF775C69),
//   secondary: Color(0xFF738F81),
//   secondaryVariant: Color(0xFF5C7267),
//   // Again we use same secondaryVariant color as optional custom app bar color.
//   appBarColor: Color(0xFF5C7267),
// );
