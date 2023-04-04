import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/core/bloc/repository.dart';
import 'package:weather_app/core/models/single_location.dart';

class LocationSearchBloc {
  final Repository _repository;
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
}
