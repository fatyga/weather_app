import 'dart:async';
import 'package:weather_app/core/bloc/bloc.dart';
import 'package:weather_app/core/repositories/weather_repository.dart';
import 'package:weather_app/core/models/status.dart';

import '../failure.dart';
import '../models/pollution.dart';
import '../models/single_location.dart';

class PollutionInfoBloc implements Bloc {
  final WeatherRepository _repository;
  late StreamSubscription _locationChangesSubscription;
  late StreamSubscription _pollutionChangesSubscription;
  StreamController<Pollution> _controller = StreamController<Pollution>();

  PollutionInfoBloc(WeatherRepository repository) : _repository = repository {
    _locationChangesSubscription = _repository.location.listen((event) async {
      try {
        final pollution =
            await _repository.pollutionService.getPollutionInfo(event);
        _repository.getPollution(pollution);
      } on Failure catch (f) {
        _repository.setStatus(StatusState.error, f.message);
      }
    });

    _pollutionChangesSubscription =
        _repository.pollution.listen((event) => _controller.add(event));
  }

  Stream<Pollution> get info => _controller.stream;
  SingleLocation get currentLocation => _repository.currentLocation;

  @override
  void dispose() {
    _locationChangesSubscription.cancel();
    _pollutionChangesSubscription.cancel();
    _controller.close();
  }
}
