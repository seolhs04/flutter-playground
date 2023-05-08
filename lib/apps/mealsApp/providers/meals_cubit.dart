import 'package:flutter_app/apps/mealsApp/providers/filter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/dummy_data.dart';
import '../models/meal.dart';

class MealsCubit extends Cubit<List<Meal>> {
  MealsCubit(context) : super(dummyMeals) {
    BlocProvider.of<FilterCubit>(context).stream.listen((filter) {
      setFilteredMeals(filter);
    });
  }

  void setFilteredMeals(Map<Filter, bool> activeFilter) {
    final filteredMeals = dummyMeals.where((meal) {
      if (activeFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilter[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    emit(filteredMeals);
  }
}
