import 'package:flutter/material.dart';
import 'package:flutter_app/apps/mealsApp/screens/meal_detail_screen.dart';
import 'package:flutter_app/apps/mealsApp/widgets/meal_item.dart';

import '../models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    this.title = '',
  });

  final String title;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => MealDetailScreen(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => Hero(
        tag: meals[index].id,
        child: MealItem(
          meal: meals[index],
          onSelectMeal: (meal) {
            selectMeal(ctx, meal);
          },
        ),
      ),
    );
    if (meals.isEmpty) {
      content = Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'nothing here',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'select a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          )
        ],
      ));
    }

    return Scaffold(
      appBar: title.isEmpty ? null : AppBar(title: Text(title)),
      body: content,
    );
  }
}
