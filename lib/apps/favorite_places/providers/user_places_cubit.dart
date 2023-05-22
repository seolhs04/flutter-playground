import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/place.dart';

class UserPlacesCubit extends Cubit<List<Place>> {
  UserPlacesCubit() : super([]);

  void addPlace(String title, File image, PlaceLocation location) {
    final newPlace = Place(title: title, image: image, location: location);
    emit([...state, newPlace]);
  }
}
