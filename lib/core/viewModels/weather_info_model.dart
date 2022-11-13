import 'package:weather_app/core/enums/view_state.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/models/single_weather.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/core/services/weather_service.dart';
import 'package:weather_app/core/viewModels/base_model.dart';

class WeatherInfoModel extends BaseModel {
  WeatherService _weatherService = WeatherService();

  SingleWeather? weather;
  bool firstInfoFetch = true;

  void getWeather() async {
    setFailure(null);
    setViewState(ViewState.busy);
    if (firstInfoFetch == true) firstInfoFetch = false;
    try {
      final userLocation = await LocationService.determinePosition();
      weather = await _weatherService.getWeather(userLocation);
    } on Failure catch (f) {
      print(f);
      setFailure(f);
    }

    setViewState(ViewState.idle);
  }
}
