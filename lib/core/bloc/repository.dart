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

  bool loaded = false;

  BehaviorSubject<SinglePollution> _pollution =
      BehaviorSubject<SinglePollution>();

  BehaviorSubject<SingleWeather> _weather = BehaviorSubject<SingleWeather>();

  BehaviorSubject<SingleLocation> _location = BehaviorSubject<SingleLocation>();

  Future<void> getLocation() async {
    final location = await locationService.determinePosition();
    _location.sink.add(location);
  }

  //inputs
  Function(SingleWeather) get getWeather => _weather.sink.add;
  Function(SinglePollution) get getPollution => _pollution.sink.add;

  // outputs
  Stream<SingleLocation> get location => _location.stream;

  Stream<SingleWeather> get weather {
    if (!loaded) getLocation();
    return _weather.stream;
  }

  Stream<SinglePollution> get pollution => _pollution.stream;
}
