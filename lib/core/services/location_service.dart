import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/models/single_location.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<SingleLocation> getCoordinatesFromName(String cityName) async {
    try {
      Response response = await get(Uri.parse(
          'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=1ba4d9aff1b4abdd1c75871989db2ded'));

      if (response.statusCode == 200) {
        dynamic result = jsonDecode(response.body);

        return SingleLocation.fromMap(result[0]);
      } else {
        return Future.error('Error');
      }
    } catch (e) {}
    throw 'error';
  }

  static Future<SingleLocation> getNameFromCoordinates(
      {required double latitude, required double longitude}) async {
    try {
      Response response = await get(Uri.parse(
          'http://api.openweathermap.org/geo/1.0/reverse?lat=$latitude&lon=$longitude&limit=1&appid=1ba4d9aff1b4abdd1c75871989db2ded'));

      if (response.statusCode == 200) {
        dynamic result = jsonDecode(response.body);

        return SingleLocation.fromMap(result[0]);
      } else {
        return Future.error('Error');
      }
    } catch (e) {}
    throw 'error';
  }

  static Future<void> checkPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {}
    }
  }

  static Future<SingleLocation> determinePosition() async {
    try {
      await checkPermissions();
      Position result = await Geolocator.getCurrentPosition();
      SingleLocation location = await getNameFromCoordinates(
          latitude: result.latitude, longitude: result.longitude);

      location.autoDetected = true;
      return location;
    } on LocationServiceDisabledException {
      throw Failure(message: 'Location services are disabled.');
    } on PermissionDeniedException {
      throw Failure(message: 'Location permissions are denied');
    }
  }
}
