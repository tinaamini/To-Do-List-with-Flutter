import 'package:flutter/material.dart';
import 'package:todolist_front/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SplashScreen(),
    );
  }
}


