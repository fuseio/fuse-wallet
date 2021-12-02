import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

final FlexColorScheme flexColorSchemeLight = FlexColorScheme.light(
  fontFamily: 'Europa',
  colors: FlexSchemeColor.from(
    secondary: Color(0xFFF5F5F5),
    secondaryVariant: Color(0xFF777777),
    primary: Color(0xFFA0D28B),
    primaryVariant: Color(0xFF003399),
    appBarColor: Color(0xFFFFFFFF),
  ),
);

final List<Color> gradientColors = [
  Color(0xFFA0D28B),
  Color(0xFF003399),
];
