import 'package:flutter/material.dart';
import 'package:flutter_app/apps/mealsApp/providers/favorites_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  _onPressLikeButton(BuildContext context) {
    final wasAdded =
        context.read<FavoriteCubit>().toggleMealFavoriteStatus(meal);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text(wasAdded ? 'Meal added as a favorite.' : 'Meal removed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, List<Meal>>(
        builder: (context, favoriteMeals) {
      final isFavorite = context.read<FavoriteCubit>().isFavorite(meal);
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(meal.title),
              flexibleSpace: Hero(
                tag: meal.id,
                child: Stack(
                  children: [
                    Image.network(
                      meal.imageUrl,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.0)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              expandedHeight: 300,
              actions: [
                IconButton(
                  onPressed: () {
                    _onPressLikeButton(context);
                  },
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      key: ValueKey(isFavorite),
                    ),
                    transitionBuilder: (child, animation) {
                      return RotationTransition(
                        turns: Tween<double>(begin: 0.8, end: 1.0)
                            .animate(animation),
                        child: child,
                      );
                    },
                  ),
                )
              ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 1,
                (context, index) {
                  return Column(
                    children: [
                      const SizedBox(height: 14),
                      Text(
                        'Ingredients',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 14),
                      for (final ingredient in meal.ingredients)
                        Text(
                          ingredient,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      const SizedBox(height: 14),
                      Text(
                        'Steps',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 14),
                      for (final step in meal.steps)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          child: Text(
                            step,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
