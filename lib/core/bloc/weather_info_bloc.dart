import 'dart:async';
import 'package:weather_app/core/bloc/repository.dart';
import 'package:weather_app/core/models/single_weather.dart';

class WeatherInfoBloc {
  final Repository _repository;

  WeatherInfoBloc(this._repository) {
    _repository.location.listen((event) async {
      final weather = await _repository.weatherService.getWeather(event);
      _repository.getWeather(weather);
    });
  }

  Stream<SingleWeather> get info => _repository.weather;

  void getWeather() => _repository.getLocation();
}
