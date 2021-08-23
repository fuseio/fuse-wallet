import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

final FlexColorScheme flexColorSchemeLight = FlexColorScheme.dark(
  fontFamily: 'Europa',
  colors: FlexSchemeColor.from(
    secondary: Color.fromRGBO(230, 160, 65, 1),
    secondaryVariant: Color(0xFF777777),
    primary: Color.fromRGBO(230, 160, 65, 1),//Color(0xE6A041),//Color(0xFFB1FDC0),
    primaryVariant: Color.fromRGBO(230, 160, 65, 1),//Color(0xE6A041),//Color(0xFFFEFD86),
    appBarColor: Color(0xFFFFFFFF),
  ),
);
