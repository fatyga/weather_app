import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/bloc_provider.dart';
import 'package:weather_app/core/bloc/home_bloc.dart';
import 'package:weather_app/core/bloc/location_search_bloc.dart';
import 'package:weather_app/core/bloc/pollution_info_bloc.dart';
import 'package:weather_app/core/bloc/repository.dart';
import 'package:weather_app/core/bloc/themeBloc.dart';
import 'package:weather_app/core/bloc/weather_info_bloc.dart';
import 'package:weather_app/weather_app.dart';

void main() {
  Repository repo = Repository();

  runApp(BlocProvider(
      child: const MyApp(),
      weatherInfoBloc: WeatherInfoBloc(repo),
      locationSearchBloc: LocationSearchBloc(repo),
      pollutionInfoBloc: PollutionInfoBloc(repo),
      themeBloc: ThemeBloc(repo),
      homeBloc: HomeBloc(repo)));
}
