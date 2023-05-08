import 'package:flutter/material.dart';
import 'package:flutter_app/apps/mealsApp/models/meal.dart';
import 'package:flutter_app/apps/mealsApp/providers/favorites_cubit.dart';
import 'package:flutter_app/apps/mealsApp/providers/filter_cubit.dart';
import 'package:flutter_app/apps/mealsApp/providers/meals_cubit.dart';
import 'package:flutter_app/apps/mealsApp/screens/categories_screen.dart';
import 'package:flutter_app/apps/mealsApp/screens/filters_screen.dart';
import 'package:flutter_app/apps/mealsApp/screens/meals_screen.dart';
import 'package:flutter_app/apps/mealsApp/widgets/main_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String activePageTitle = 'Pick your category';
    Widget activePage = BlocBuilder<MealsCubit, List<Meal>>(
      builder: (context, meals) => CategoriesScreen(availableMeals: meals),
    );

    if (_selectedPageIndex == 1) {
      activePage = BlocBuilder<FavoriteCubit, List<Meal>>(
        builder: (context, meals) => MealsScreen(meals: meals),
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
