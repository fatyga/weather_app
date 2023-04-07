import 'dart:async';
import 'package:weather_app/core/repositories/weather_repository.dart';
import 'package:weather_app/core/models/status.dart';

import '../failure.dart';
import '../models/single_location.dart';
import '../models/weather.dart';
import 'bloc.dart';

class WeatherInfoBloc implements Bloc {
  final WeatherRepository _repository;
  late StreamSubscription _locationChangesSubscription;
  late StreamSubscription _weatherChangesSubscription;
  StreamController<Weather> _controller = StreamController<Weather>();

  WeatherInfoBloc(WeatherRepository repository) : _repository = repository {
    _locationChangesSubscription = _repository.location.listen((event) async {
      _repository.setStatus(StatusState.fetching, 'fetching weather info');

      try {
        final weather = await _repository.weatherService.getWeather(event);
        _repository.getWeather(weather);
        _repository.setStatus(StatusState.success, 'Success!', getWeather);
      } on Failure catch (f) {
        _repository.setStatus(StatusState.error, f.message);
      }
    });

    _weatherChangesSubscription =
        _repository.weather.listen((event) => _controller.add(event));
  }

  Stream<Weather> get info => _controller.stream;
  SingleLocation get currentLocation => _repository.currentLocation;

  void getWeather() => _repository.getUserLocation();

  @override
  void dispose() {
    _locationChangesSubscription.cancel();
    _weatherChangesSubscription.cancel();
    _controller.close();
  }
}
