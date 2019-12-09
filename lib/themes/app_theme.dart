import 'package:flutter/material.dart';

ThemeData getTheme() {
  return ThemeData(
    fontFamily: 'Europa', //'Source',  //'Gotham',
    brightness: Brightness.light,
    primaryColor: const Color(0xFF05283e),
    accentColor: const Color(0xFFA8EB8C),
    canvasColor: const Color(0xFFF8F8F8),
    scaffoldBackgroundColor: Colors.white,
    textSelectionHandleColor: const Color(0xFF05283e),
    textSelectionColor: Colors.black12,
    cursorColor: const Color(0xFF05283e),
    toggleableActiveColor: const Color(0xFF05283e),
    primaryColorLight: const Color(0xFFFEFD86),
    primaryColorDark: const Color(0xFFB1FDC0),
    textTheme: TextTheme(
        body1: new TextStyle(color: const Color(0xFF333333)),
        button: new TextStyle(color: const Color(0xFF333333))
        ),
    inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFF05283e)),
          //borderRadius: BorderRadius.all(Radius.circular(70.0))
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 2),
            //borderRadius: BorderRadius.all(Radius.circular(26.0))
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
        /*
                  hintStyle: const TextStyle(
                    fontSize: 30
                  ),
                  */
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 30)),
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
  );
}
