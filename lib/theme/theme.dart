import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xffB5C0D0),
  canvasColor: const Color(0xffF2EFE5),
  colorScheme: const ColorScheme.light(
    primary: Colors.black,
    onPrimary: Colors.black,
    onPrimaryContainer: Color(0xff465262),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  canvasColor: const Color(0xff465262),
  scaffoldBackgroundColor: const Color(0xff1F2537),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xff1F2537),
    onPrimary: Colors.white,
    onPrimaryContainer: Color(0xff465262),
  ),
);


// 1F2537