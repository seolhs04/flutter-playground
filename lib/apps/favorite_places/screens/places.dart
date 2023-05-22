import 'package:flutter/material.dart';
import 'package:flutter_app/apps/favorite_places/models/place.dart';
import 'package:flutter_app/apps/favorite_places/providers/user_places_cubit.dart';
import 'package:flutter_app/apps/favorite_places/screens/add_place.dart';
import 'package:flutter_app/apps/favorite_places/widgets/places_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => const AddPlaceScreen(),
              ));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<UserPlacesCubit, List<Place>>(
        builder: (context, places) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: PlacesList(places: places),
        ),
      ),
    );
  }
}
