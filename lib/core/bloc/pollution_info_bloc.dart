import 'dart:async';
import 'package:weather_app/core/bloc/repository.dart';
import 'package:weather_app/core/models/single_pollution.dart';
import 'package:weather_app/core/models/status.dart';

import '../failure.dart';
import '../models/pollution.dart';
import '../models/single_location.dart';

class PollutionInfoBloc {
  final Repository _repository;

  PollutionInfoBloc(this._repository) {
    _repository.location.listen((event) async {
      try {
        final pollution =
            await _repository.pollutionService.getPollutionInfo(event);
        _repository.getPollution(pollution);
      } on Failure catch (f) {
        _repository.setStatus(StatusState.error, f.message);
      }
    });
  }

  Stream<Pollution> get info => _repository.pollution;
  SingleLocation get currentLocation => _repository.currentLocation;
}
