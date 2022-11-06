import 'package:get_it/get_it.dart';
import 'package:weather_app/core/viewModels/start_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => StartModel());
}
