import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xffB5C0D0),
  colorScheme: const ColorScheme.light(
    onPrimaryContainer: Color(0xffEEEDEB),
    primary: Colors.black,
    onPrimary: Color(0xffEEEDEB),
    onSecondary: Colors.black,
    onTertiary: Colors.black,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xff1F2537),
  colorScheme: const ColorScheme.dark(
    onPrimaryContainer: Color(0xff465262),
    primary: Colors.white,
    onPrimary: Color(0xff465262),
    onSecondary: Colors.white,
    onTertiary: Colors.white,
  ),
);
