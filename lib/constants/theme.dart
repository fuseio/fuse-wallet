import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';

const List<Color> buttonsGradients = [
  Color(0xFF1BC872),
  Color(0xFF41DF91),
];

final List<BoxShadow> boxShadowDark = [
  const BoxShadow(
    color: Color.fromRGBO(34, 41, 38, 0.5),
    blurRadius: 6,
    offset: Offset(0, 6),
  )
];

final List<BoxShadow> boxShadow = [
  const BoxShadow(
    color: lightGreenShadow,
    offset: Offset(0, 4),
    blurRadius: 7.0,
  ),
];

const List<Color> gradientColors = [
  Color(0xFF1DCC75),
  homeBannerLightGreen,
];

const Color lightGreenShadow = Color(0xFFD0FBE5);

const Color homeBannerLightGreen = Color(0xFF0D874A);

const Color lightGreen = Color(0xFFE1F9ED);

const Color lightGray = Color(0xFFC5C5C5);

const Color primaryGlow = Color(0xFF1DCC75);

const Color primary = Color(0xFF37D888);

const Color secondary = Color(0xFFF5F5F5);

const Color blue = Color(0xFF0073D6);

const Color darkGreen = Color(0xFF00542A);

const ColorScheme colorsScheme = ColorScheme.light(
  primary: primary,
  tertiary: blue,
  secondary: secondary,
);

TextTheme defaultTheme =
    Typography.material2018(platform: defaultTargetPlatform).white;

TextTheme textTheme = TextTheme(
  displayLarge: defaultTheme.displayLarge?.copyWith(
    fontFamily: 'SF-Pro-Display',
    color: Colors.black,
  ),
  displayMedium: defaultTheme.displayMedium?.copyWith(
    fontFamily: 'SF-Pro-Display',
    color: Colors.black,
  ),
  displaySmall: defaultTheme.displaySmall?.copyWith(
    fontFamily: 'SF-Pro-Display',
    color: Colors.black,
  ),
  headlineLarge: defaultTheme.headlineLarge?.copyWith(
    fontFamily: 'SF-Pro-Display',
    color: Colors.black,
  ),
  headlineMedium: defaultTheme.headlineMedium?.copyWith(
    fontFamily: 'SF-Pro-Display',
    color: Colors.black,
  ),
  headlineSmall: defaultTheme.headlineSmall?.copyWith(
    fontFamily: 'SF-Pro-Display',
    color: Colors.black,
  ),
  titleLarge: defaultTheme.titleLarge?.copyWith(
    fontFamily: 'SF-Pro-Display',
    color: Colors.black,
  ),
  titleMedium: defaultTheme.titleMedium?.copyWith(
    fontFamily: 'SF-Pro-Display',
    color: Colors.black,
  ),
  titleSmall: defaultTheme.titleSmall?.copyWith(
    fontFamily: 'SF-Pro-Display',
    color: Colors.black,
  ),
  bodyLarge: defaultTheme.bodyLarge?.copyWith(
    fontFamily: 'SF-Pro-Display',
    color: Colors.black,
  ),
  bodyMedium: defaultTheme.bodyMedium?.copyWith(
    fontFamily: 'SF-Pro-Display',
    color: Colors.black,
  ),
  bodySmall: defaultTheme.bodySmall?.copyWith(
    fontFamily: 'SF-Pro-Display',
    color: Colors.black,
  ),
  labelLarge: defaultTheme.labelLarge?.copyWith(
    fontFamily: 'SF-Pro-Display',
    color: Colors.black,
  ),
  labelMedium: defaultTheme.labelMedium?.copyWith(
    fontFamily: 'SF-Pro-Display',
    color: Colors.black,
  ),
  labelSmall: defaultTheme.labelSmall?.copyWith(
    fontFamily: 'SF-Pro-Display',
    color: Colors.black,
  ),
);

FlexColorScheme flexThemeData = FlexColorScheme.light(
  fontFamily: 'SF-Pro-Display',
  useMaterial3: true,
  colorScheme: colorsScheme,
  textTheme: textTheme,
  primaryTextTheme: textTheme,
);
