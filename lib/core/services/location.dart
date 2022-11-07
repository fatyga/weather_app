import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/services/single_location.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<SingleLocation> getCoordinatesFromName(String cityName) async {
    try {
      Response response = await get(Uri.parse(
          'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=1ba4d9aff1b4abdd1c75871989db2ded'));

      if (response.statusCode == 200) {
        List result = jsonDecode(response.body);
        return SingleLocation(
            latitude: result[0]['lat'],
            longitude: result[0]['lon'],
            countryCode: result[0]['country'],
            name: result[0]['name']);
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
        List result = jsonDecode(response.body);
        return SingleLocation(
            latitude: result[0]['lat'],
            longitude: result[0]['lon'],
            countryCode: result[0]['country'],
            name: result[0]['name']);
      } else {
        return Future.error('Error');
      }
    } catch (e) {}
    throw 'error';
  }

  static Future<bool> checkPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      permission = await Geolocator.checkPermission();
      permission == LocationPermission.deniedForever;
    } on LocationServiceDisabledException {
      throw Failure(message: 'Location services are disabled.');
    } on PermissionDeniedException {
      throw Failure(message: 'Location permissions are denied');
    }
    return true;
  }

  static Future<SingleLocation> determinePosition() async {
    Position result = await Geolocator.getCurrentPosition();

    SingleLocation location = await getNameFromCoordinates(
        latitude: result.latitude, longitude: result.longitude);

    location.autoDetected = true;
    return location;
  }
}
