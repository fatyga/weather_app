import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/home_bloc.dart';
import 'package:weather_app/core/bloc/location_search_bloc.dart';
import 'package:weather_app/core/bloc/pollution_info_bloc.dart';
import 'package:weather_app/core/bloc/weather_info_bloc.dart';

class BlocProvider extends InheritedWidget {
  final WeatherInfoBloc weatherInfoBloc;
  final PollutionInfoBloc pollutionInfoBloc;
  final LocationSearchBloc locationSearchBloc;
  final HomeBloc homeBloc;

  const BlocProvider(
      {Key? key,
      required this.weatherInfoBloc,
      required this.pollutionInfoBloc,
      required this.locationSearchBloc,
      required this.homeBloc,
      required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(Widget oldWidget) => true;

  static BlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider>()!;
  }
}
