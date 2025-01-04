import 'package:flutter/material.dart';
import 'package:todolist_front/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('fa', 'IR'), // زبان فارسی
      supportedLocales: [
        Locale('fa', 'IR'), // فارسی
        Locale('en', 'US'), // انگلیسی
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
        home: SplashScreen(),
    );
  }
}


