import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/core/bloc/repository.dart';
import 'package:weather_app/core/models/single_location.dart';

class LocationSearchBloc {
  final Repository _repository;
  LocationSearchBloc(this._repository);

  Future<void> getLocationFromName(String name) async {
    final location =
        await _repository.locationService.getCoordinatesFromName(name);
    _repository.getlocation(location);

    if (!_repository.recentLocations.any((loc) => loc.name == location.name)) {
      _repository.recentLocations.add(location);
    }
  }

  List<SingleLocation> get recentLocations => _repository.recentLocations;
  Function(SingleLocation) get getLocation => _repository.getlocation;
}
