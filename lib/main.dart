import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/bloc/bloc_provider.dart';
import 'package:weather_app/core/bloc/home_bloc.dart';
import 'package:weather_app/core/bloc/location_search_bloc.dart';
import 'package:weather_app/core/bloc/pollution_info_bloc.dart';
import 'package:weather_app/core/bloc/repository.dart';
import 'package:weather_app/core/bloc/themeBloc.dart';
import 'package:weather_app/core/bloc/weather_info_bloc.dart';
import 'package:weather_app/weather_app.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await CountryCodes.init();
  Repository repo = Repository();
  final prefs = await SharedPreferences.getInstance();
  bool? savedDarkTheme = await prefs.getBool('darkTheme');

  runApp(BlocProvider(
      child: MyApp(savedDarkTheme: savedDarkTheme),
      weatherInfoBloc: WeatherInfoBloc(repo),
      locationSearchBloc: LocationSearchBloc(repo),
      pollutionInfoBloc: PollutionInfoBloc(repo),
      themeBloc: ThemeBloc(repo),
      homeBloc: HomeBloc(repo)));
}
