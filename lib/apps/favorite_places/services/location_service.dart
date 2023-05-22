import 'package:location/location.dart';

class LocationService {
  static Future<PermissionStatus?> checkingPermission(Location location) async {
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return permissionGranted;
  }

  static Future<bool?> checkingServiceEnable(Location location) async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    return serviceEnabled;
  }

  static Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    LocationService.checkingServiceEnable(location);
    LocationService.checkingPermission(location);

    return await location.getLocation();
  }
}
