import 'package:weather_app/core/enums/view_state.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/models/single_weather.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/core/services/weather_service.dart';
import 'package:weather_app/core/viewModels/base_model.dart';

class WeatherInfoModel extends BaseModel {
  WeatherService _weatherService = WeatherService();

  SingleWeather? weather;

  void getWeather() async {
    setViewState(ViewState.busy);
    try {
      final userLocation = await LocationService.determinePosition();
      weather = await _weatherService.getWeather(userLocation);
    } on Failure catch (f) {
      setFailure(f);
    }

    setViewState(ViewState.idle);
  }
}
