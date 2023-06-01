import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/apps/mealsApp/screens/meal_detail_screen.dart';
import 'package:flutter_app/apps/mealsApp/widgets/meal_item.dart';

import '../models/meal.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    this.title = '',
  });

  final String title;
  final List<Meal> meals;

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => MealDetailScreen(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: widget.meals.length,
      itemBuilder: (ctx, index) => Padding(
        padding: const EdgeInsets.all(10),
        child: OpenContainer(
            transitionType: ContainerTransitionType.fadeThrough,
            closedBuilder: (context, action) {
              return InkWell(
                onTap: action,
                child: MealItem(meal: widget.meals[index]),
              );
            },
            openBuilder: (context, action) {
              return MealDetailScreen(meal: widget.meals[index]);
            }),
      ),
    );
    if (widget.meals.isEmpty) {
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
      appBar: widget.title.isEmpty ? null : AppBar(title: Text(widget.title)),
      body: content,
    );
  }
}
