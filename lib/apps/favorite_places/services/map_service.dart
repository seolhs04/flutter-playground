import 'dart:convert';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

String? apiKey = FlutterConfig.get('GOOGLE_MAPS_API_KEY');

class MapService {
  static getReverseGeoCoding(lat, long) async {
    try {
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=${apiKey!}');
      final response = await http.get(url);
      final resData = json.decode(response.body);
      return resData['results'][0]['formatted_address'];
    } catch (err) {
      throw Exception(err);
    }
  }

  static getMapImage(lat, long) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=17&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$long&key=${apiKey!}';
  }
}
