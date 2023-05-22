import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/apps/favorite_places/providers/user_places_cubit.dart';
import 'package:flutter_app/apps/favorite_places/widgets/image_input.dart';
import 'package:flutter_app/apps/favorite_places/widgets/location_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/place.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _placeLocation;

  void _savePlace(BuildContext context) {
    final enteredText = _titleController.text;
    if (enteredText.isEmpty ||
        _selectedImage == null ||
        _placeLocation == null) {
      return;
    }
    context.read<UserPlacesCubit>().addPlace(
          enteredText,
          _selectedImage!,
          _placeLocation!,
        );
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPlacesCubit, List<Place>>(builder: (context, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add new Place'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(height: 10),
              ImageInput(onPickImage: (image) {
                _selectedImage = image;
              }),
              const SizedBox(height: 10),
              LocationInput(onPickLocation: (location) {
                _placeLocation = location;
              }),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  _savePlace(context);
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Place'),
              )
            ],
          ),
        ),
      );
    });
  }
}
