import 'package:flutter/material.dart';
import 'package:flutter_app/apps/shoppingList/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ShoppingListApp());
}
