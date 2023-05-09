import 'package:flutter/material.dart';
import 'package:flutter_app/apps/mealsApp/providers/favorites_cubit.dart';
import 'package:flutter_app/apps/mealsApp/providers/filter_cubit.dart';
import 'package:flutter_app/apps/mealsApp/providers/meals_cubit.dart';
import 'package:flutter_app/apps/mealsApp/screens/tabs_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

class MealsApp extends StatelessWidget {
  const MealsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FilterCubit()),
        BlocProvider(create: (context) => MealsCubit(context)),
        BlocProvider(create: (context) => FavoriteCubit()),
      ],
      child: MaterialApp(
        theme: theme,
        home: const TabsScreen(),
      ),
    );
  }
}
