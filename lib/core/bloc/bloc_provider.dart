import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/pollution_info_bloc.dart';
import 'package:weather_app/core/bloc/weather_info_bloc.dart';

class BlocProvider extends InheritedWidget {
  final WeatherInfoBloc weatherInfoBloc;
  final PollutionInfoBloc pollutionInfoBloc;

  const BlocProvider(
      {Key? key,
      required this.weatherInfoBloc,
      required this.pollutionInfoBloc,
      required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(Widget oldWidget) => true;

  static BlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider>()!;
  }
}
