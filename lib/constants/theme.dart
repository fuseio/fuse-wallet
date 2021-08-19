import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

final FlexColorScheme flexColorSchemeLight = FlexColorScheme.light(
  fontFamily: 'Europa',
  background: Colors.black,//todo: ask someone if this change should be here
  colors: FlexSchemeColor.from(
    secondary: Color(0xFFF5F5F5),
    secondaryVariant: Color(0xFF777777),
    primary: Color(0xFFB1FDC0),
    primaryVariant: Color(0xFFFEFD86),
    appBarColor: Color(0xFFFFFFFF),
  ),
);
