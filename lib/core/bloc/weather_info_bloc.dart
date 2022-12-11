import 'dart:async';
import 'package:weather_app/core/bloc/repository.dart';
import 'package:weather_app/core/models/single_weather.dart';
import 'package:weather_app/core/models/status.dart';

import '../failure.dart';

class WeatherInfoBloc {
  final Repository _repository;

  WeatherInfoBloc(this._repository) {
    _repository.location.listen((event) async {
      _repository.setStatus(StatusState.fetching, 'fetching weather info');
      try {
        final weather = await _repository.weatherService.getWeather(event);
        _repository.getWeather(weather);
        _repository.setStatus(StatusState.success, 'info fetched succesfully');
      } on Failure catch (f) {
        _repository.setStatus(StatusState.error, f.message);
      }
    });
  }

  Stream<SingleWeather> get info => _repository.weather;

  void getWeather() => _repository.getUserLocation();
}
