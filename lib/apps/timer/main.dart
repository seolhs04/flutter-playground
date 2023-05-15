import 'package:flutter/material.dart';
import 'package:flutter_app/apps/timer/screens/button_screen.dart';

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.dark,
        home: const ButtonScreen());
  }
}
