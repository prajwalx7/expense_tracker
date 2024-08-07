import 'package:expense_tracker/screens/expenses.dart';
import 'package:expense_tracker/screens/splash_screen.dart';
import 'package:expense_tracker/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final TextStyle selectedFontStyle = GoogleFonts.lato();
        final ThemeData currentTheme = themeProvider.themeData;
        final TextTheme newTextTheme = currentTheme.textTheme.apply(
          fontFamily: selectedFontStyle.fontFamily,
        );
        final ThemeData newTheme = currentTheme.copyWith(
          textTheme: newTextTheme,
        );

        return ScreenUtilInit(
          designSize: const Size(360, 640),
          builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: newTheme,
            home: const SplashScreen(),
            routes: {'/home': (context) => const Expenses()},
          ),
        );
      },
    );
  }
}
