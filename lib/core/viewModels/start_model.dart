import 'package:flutter/material.dart';
import 'package:weather_app/core/enums/view_state.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/models/single_location.dart';
import 'package:weather_app/core/models/single_weather.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/core/services/weather_service.dart';
import 'package:weather_app/core/viewModels/base_model.dart';

class StartModel extends BaseModel {
  Future<SingleWeather?> setup() async {
    setViewState(ViewState.busy);
    try {
      if (await LocationService.checkPermissions()) {
        final userPosition = await getUserPosition();
        return await getCurrentWeather(userPosition);
      }
    } on Failure catch (f) {
      setFailure(f);
    }
    setViewState(ViewState.idle);
  }

  Future<void> checkPermissions() async {
    final permission = await LocationService.checkPermissions();
  }

  Future<SingleLocation> getUserPosition() async {
    final position = await LocationService.determinePosition();
    return position;
  }

  Future<SingleWeather> getCurrentWeather(SingleLocation location) async {
    return await WeatherService().getWeather(location);
  }
}
