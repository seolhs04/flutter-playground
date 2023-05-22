import 'package:flutter/material.dart';
import 'package:flutter_app/apps/favorite_places/models/place.dart';
import 'package:flutter_app/apps/favorite_places/services/location_service.dart';
import 'package:flutter_app/apps/favorite_places/services/map_service.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onPickLocation});

  final void Function(PlaceLocation location) onPickLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  String? _locationImage;
  bool _isGettingLocation = false;

  void _getCurrentLocation() async {
    setState(() {
      _isGettingLocation = true;
    });
    final locationData = await LocationService.getCurrentLocation();
    final lat = locationData.latitude;
    final long = locationData.longitude;
    final address = await MapService.getReverseGeoCoding(lat, long);

    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: lat!,
        longitude: long!,
        address: address,
      );
      _locationImage = MapService.getMapImage(lat, long);
      _isGettingLocation = false;
    });
    widget.onPickLocation(_pickedLocation!);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (_locationImage != null) {
      previewContent = Image.network(
        _locationImage!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ),
            child: previewContent),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current Location'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
            ),
          ],
        ),
      ],
    );
  }
}
