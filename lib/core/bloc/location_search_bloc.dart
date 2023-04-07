import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/core/repositories/weather_repository.dart';
import 'package:weather_app/core/models/single_location.dart';

import 'bloc.dart';

class LocationSearchBloc implements Bloc {
  final WeatherRepository _repository;
  LocationSearchBloc(this._repository);

  final StreamController<String> _locationController =
      StreamController<String>.broadcast();

  // inputs
  Function(String) get searchByLocationName => _locationController.sink.add;

  // outputs
  Stream<List<SingleLocation>?> get searchLocation => _locationController.stream
      .debounceTime(const Duration(milliseconds: 100))
      .switchMap((locationName) => _repository.locationService
          .getCoordinatesFromName(locationName)
          .asStream()
          .startWith(null));

  List<SingleLocation> get recentLocations => _repository.recentLocations;
  Function(SingleLocation) get setLocation => _repository.setlocation;

  @override
  void dispose() {
    _locationController.close();
  }
}
