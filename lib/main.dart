import 'package:expense_tracker/screens/expenses.dart';
import 'package:expense_tracker/screens/splash_screen.dart';
import 'package:expense_tracker/storage/expense_storage.dart';
import 'package:expense_tracker/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseStorageAdapter());
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

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

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // Set the new theme for the entire app
          theme: newTheme,
          home: const SplashScreen(),
          routes: {'/home': (context) => const Expenses()},
        );
      },
    );
  }
}
