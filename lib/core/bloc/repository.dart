import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/core/models/single_location.dart';
import 'package:weather_app/core/models/single_pollution.dart';
import 'package:weather_app/core/models/single_weather.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/core/services/pollution_service.dart';
import 'package:weather_app/core/services/weather_service.dart';

class Repository {
  final locationService = LocationService();
  final weatherService = WeatherService();
  final pollutionService = PollutionService();

  bool firstInitialization = true;

  List<SingleLocation> recentLocations = [];

  BehaviorSubject<SinglePollution> _pollution =
      BehaviorSubject<SinglePollution>();

  BehaviorSubject<SingleWeather> _weather = BehaviorSubject<SingleWeather>();

  BehaviorSubject<SingleLocation> _location = BehaviorSubject<SingleLocation>();

  Future<void> getUserLocation() async {
    final location = await locationService.determinePosition();
    location.autoDetected = true;
    _location.sink.add(location);
    if (!recentLocations.any((element) => element.name == location.name)) {
      recentLocations.add(location);
    }
  }

  //inputs
  Function(SingleWeather) get getWeather => _weather.sink.add;
  Function(SinglePollution) get getPollution => _pollution.sink.add;
  Function(SingleLocation) get getlocation => _location.sink.add;

  // outputs
  Stream<SingleLocation> get location => _location.stream;

  Stream<SingleWeather> get weather {
    if (firstInitialization) {
      getUserLocation();
      firstInitialization = false;
    }

    return _weather.stream;
  }

  Stream<SinglePollution> get pollution => _pollution.stream;
}
