import 'dart:async';

import 'package:weather_app/core/bloc/bloc.dart';
import 'package:weather_app/core/repositories/weather_repository.dart';
import 'package:weather_app/core/models/status.dart';

class HomeBloc implements Bloc {
  final WeatherRepository _repository;
  late StreamSubscription _statusSubscription;

  HomeBloc(WeatherRepository repository) : _repository = repository {
    _statusSubscription = _repository.status.listen((event) {
      _controller.add(event);
    });
  }

  final StreamController<Status> _controller = StreamController<Status>();

  Stream<Status> get status => _controller.stream;

  @override
  void dispose() {
    _statusSubscription.cancel();
    _controller.close();
  }
}
