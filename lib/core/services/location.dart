import 'dart:convert';
import 'package:http/http.dart';
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

  static Future<SingleLocation> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position result = await Geolocator.getCurrentPosition();

    SingleLocation location = await getNameFromCoordinates(
        latitude: result.latitude, longitude: result.longitude);

    location.autoDetected = true;
    return location;
  }
}
