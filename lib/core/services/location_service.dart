import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/models/single_location.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<SingleLocation> getCoordinatesFromName(String cityName) async {
    try {
      Response response = await get(Uri.parse(
          'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=1ba4d9aff1b4abdd1c75871989db2ded'));

      dynamic result = jsonDecode(response.body);

      return SingleLocation.fromMap(result[0]);
    } on SocketException {
      throw const Failure(message: 'Check your internet connection.');
    } on HttpException {
      throw const Failure(message: 'Couldn\'t fetch info about loaction.');
    } on FormatException {
      throw const Failure(message: 'Bad response format.');
    }
  }

  Future<SingleLocation> getNameFromCoordinates(
      {required double latitude, required double longitude}) async {
    try {
      Response response = await get(Uri.parse(
          'http://api.openweathermap.org/geo/1.0/reverse?lat=$latitude&lon=$longitude&limit=1&appid=1ba4d9aff1b4abdd1c75871989db2ded'));

      dynamic result = jsonDecode(response.body);

      return SingleLocation.fromMap(result[0]);
    } on SocketException {
      throw const Failure(message: 'Check your internet connection.');
    } on HttpException {
      throw const Failure(message: 'Couldn\'t fetch info about loaction.');
    } on FormatException {
      throw const Failure(message: 'Bad response format.');
    }
  }

  Future<void> checkPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {}
    }
  }

  Future<SingleLocation> determinePosition() async {
    try {
      await checkPermissions();
      Position result = await Geolocator.getCurrentPosition();
      return await getNameFromCoordinates(
          latitude: result.latitude, longitude: result.longitude);
    } on LocationServiceDisabledException {
      throw const Failure(message: 'Location services are disabled.');
    } on PermissionDeniedException {
      throw const Failure(message: 'Location permissions are denied.');
    }
  }
}
