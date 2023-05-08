import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/meal.dart';

class FavoriteCubit extends Cubit<List<Meal>> {
  FavoriteCubit() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealsArr = [...state];
    bool status = isFavorite(meal);
    if (isFavorite(meal)) {
      mealsArr.remove(meal);
    } else {
      mealsArr.add(meal);
    }
    emit(mealsArr);
    return status;
  }

  bool isFavorite(Meal meal) {
    return state.contains(meal);
  }
}
