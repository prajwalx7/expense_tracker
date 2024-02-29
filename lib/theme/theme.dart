import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xffB5C0D0),
  colorScheme: const ColorScheme.light(
    onBackground: Color(0xffEEEDEB),
    primary: Colors.black,
    onPrimary: Color(0xffEEEDEB),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xff1F2537),
  colorScheme: const ColorScheme.dark(
    onBackground: Color(0xff465262),
    primary: Colors.white,
    onPrimary: Color(0xff465262),
  ),
);