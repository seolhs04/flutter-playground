import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/place.dart';

class UserPlacesCubit extends Cubit<List<Place>> {
  UserPlacesCubit() : super([]);

  void addPlace(String title) {
    final newPlace = Place(title: title);
    emit([...state, newPlace]);
  }
}
