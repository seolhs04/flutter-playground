import 'package:flutter_bloc/flutter_bloc.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterCubit extends Cubit<Map<Filter, bool>> {
  FilterCubit()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilter(Filter filter, bool isActive) {
    emit({...state, filter: isActive});
  }
}
