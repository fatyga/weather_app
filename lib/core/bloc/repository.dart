import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/models/pollution.dart';
import 'package:weather_app/core/models/single_location.dart';
import 'package:weather_app/core/models/status.dart';
import 'package:weather_app/core/models/weather.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/core/services/pollution_service.dart';
import 'package:weather_app/core/services/weather_service.dart';
import 'package:intl/intl.dart';

class Repository {
  final locationService = LocationService();
  final weatherService = WeatherService();
  final pollutionService = PollutionService();

  bool firstInitialization = true;

  List<SingleLocation> recentLocations = [];

  BehaviorSubject<Pollution> _pollution = BehaviorSubject<Pollution>();

  BehaviorSubject<Weather> _weather = BehaviorSubject<Weather>();

  BehaviorSubject<SingleLocation> _location = BehaviorSubject<SingleLocation>();

  BehaviorSubject<List<SingleLocation>> _searchedLocations =
      BehaviorSubject<List<SingleLocation>>();

  BehaviorSubject<Status> _status = BehaviorSubject<Status>();

  BehaviorSubject<ThemeMode> _theme = BehaviorSubject<ThemeMode>();

  void setStatus(StatusState newStatus, String? comment, [Function()? action]) {
    _status.sink.add(Status(newStatus, comment, action));
  }

  void toggleTheme(bool isDark) async {
    isDark ? _theme.add(ThemeMode.dark) : _theme.add(ThemeMode.light);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkTheme', isDark);
  }

  Future<void> getUserLocation() async {
    setStatus(StatusState.fetching, 'detecting location');
    SingleLocation location;

    try {
      if (!_location.hasValue || _location.value.autoDetected == true) {
        location = await locationService.determinePosition();
        location.autoDetected = true;
        if (!recentLocations.any((element) => element.autoDetected == true)) {
          recentLocations.add(location);
        } else {
          final index =
              recentLocations.indexWhere((element) => element.autoDetected);
          recentLocations[index] = location;
        }
      } else {
        location = _location.value;
      }

      _location.sink.add(location);
    } on Failure catch (e) {
      setStatus(StatusState.error, e.message, getUserLocation);
    }
  }

  //inputs
  Function(Weather) get getWeather => _weather.sink.add;
  Function(Pollution) get getPollution => _pollution.sink.add;
  Function(SingleLocation) get getlocation => _location.sink.add;
  Function(List<SingleLocation>) get getSearchedlocation =>
      _searchedLocations.sink.add;
  Function(Status) get getStatus => _status.sink.add;
  Function(ThemeMode) get getTheme => _theme.sink.add;

  // outputs
  Stream<SingleLocation> get location => _location.stream;
  SingleLocation get currentLocation => _location.value;
  Stream<List<SingleLocation>> get searchedLocations =>
      _searchedLocations.stream;

  Stream<Weather> get weather {
    if (firstInitialization) {
      getUserLocation();
      firstInitialization = false;
    }

    return _weather.stream;
  }

  Stream<Pollution> get pollution => _pollution.stream;

  Stream<Status> get status => _status.stream;
  Stream<ThemeMode> get theme => _theme.stream;
}
