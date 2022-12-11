import 'package:weather_app/core/bloc/repository.dart';
import 'package:weather_app/core/models/status.dart';

class HomeBloc {
  final Repository _repository;

  HomeBloc(this._repository);

  Stream<Status> get status => _repository.status;
}
