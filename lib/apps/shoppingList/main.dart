import 'package:flutter/material.dart';
import 'package:flutter_app/apps/shoppingList/providers/theme_mode_cubit.dart';
import 'package:flutter_app/apps/shoppingList/widgets/grocery_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListApp extends StatelessWidget {
  const ShoppingListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeModeCubit()),
      ],
      child: BlocBuilder<ThemeModeCubit, bool>(
        builder: (context, isDarkMode) {
          return MaterialApp(
            title: 'Flutter Groceries',
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const GroceryList(),
          );
        },
      ),
    );
  }
}
