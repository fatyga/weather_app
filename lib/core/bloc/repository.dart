import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/models/single_location.dart';
import 'package:weather_app/core/models/single_pollution.dart';
import 'package:weather_app/core/models/single_weather.dart';
import 'package:weather_app/core/models/status.dart';
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

  BehaviorSubject<Status> _status = BehaviorSubject<Status>();

  void setStatus(StatusState newStatus, String? comment, [Function()? action]) {
    _status.sink.add(Status(newStatus, comment, action));
  }

  Future<void> getUserLocation() async {
    setStatus(StatusState.fetching, 'detect location');
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
  Function(SingleWeather) get getWeather => _weather.sink.add;
  Function(SinglePollution) get getPollution => _pollution.sink.add;
  Function(SingleLocation) get getlocation => _location.sink.add;
  Function(Status) get getStatus => _status.sink.add;

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

  Stream<Status> get status => _status.stream;
}
