import 'dart:async';
import 'package:weather_app/core/bloc/repository.dart';
import 'package:weather_app/core/models/single_pollution.dart';

class PollutionInfoBloc {
  final Repository _repository;

  PollutionInfoBloc(this._repository) {
    _repository.location.listen((event) async {
      final pollution =
          await _repository.pollutionService.getPollutionInfo(event);
      _repository.getPollution(pollution);
    });
  }

  Stream<SinglePollution> get info => _repository.pollution;
}
