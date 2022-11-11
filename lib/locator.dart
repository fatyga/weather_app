import 'package:get_it/get_it.dart';
import 'package:weather_app/core/viewModels/pollution_info_model.dart';
import 'package:weather_app/core/viewModels/weather_info_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => WeatherInfoModel());
  locator.registerFactory(() => PollutionInfoModel());
}
