import 'package:flutter/material.dart';
import 'package:flutter_app/screens/expenses/expenses_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
        ),
        fontFamily: 'Quicksand',
      ),
      home: const ExpensesScreen(),
    );
  }
}
