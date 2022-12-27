import 'dart:async';
import 'package:weather_app/core/bloc/repository.dart';
import 'package:weather_app/core/models/status.dart';

import '../failure.dart';
import '../models/single_location.dart';
import '../models/weather.dart';

class WeatherInfoBloc {
  final Repository _repository;

  WeatherInfoBloc(this._repository) {
    _repository.location.listen((event) async {
      _repository.setStatus(StatusState.fetching, 'fetching weather info');

      try {
        final weather = await _repository.weatherService.getWeather(event);
        _repository.getWeather(weather);
        _repository.setStatus(
            StatusState.success, 'info fetched succesfully', getWeather);
      } on Failure catch (f) {
        _repository.setStatus(StatusState.error, f.message);
      }
    });
  }

  Stream<Weather> get info => _repository.weather;
  SingleLocation get currentLocation => _repository.currentLocation;

  void getWeather() => _repository.getUserLocation();
}
