import 'package:flutter/material.dart';
import 'package:flutter_app/apps/favorite_places/main.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();

  runApp(const FavoritePlacesApp());
}
