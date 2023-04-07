import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/repositories/provider.dart';
import 'package:weather_app/weather_app.dart';

import 'core/bloc/bloc_provider.dart';
import 'core/bloc/theme_bloc.dart';
import 'core/repositories/weather_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CountryCodes.init();

  final prefs = await SharedPreferences.getInstance();
  bool? savedDarkTheme = prefs.getBool('darkTheme');

  runApp(RepositoryProvider<WeatherRepository>(
      repository: WeatherRepository(),
      child: BlocProvider<ThemeBloc>(
          bloc: ThemeBloc(), child: MyApp(savedDarkTheme: savedDarkTheme))));
}
