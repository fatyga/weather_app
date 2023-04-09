import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/weather_info_bloc.dart';
import 'package:weather_app/ui/screens/weather/weather_view.dart';

import '../../../core/bloc/bloc_provider.dart';
import '../../../core/repositories/provider.dart';
import '../../../core/repositories/weather_repository.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late WeatherInfoBloc weatherInfoBloc;

  @override
  void initState() {
    weatherInfoBloc =
        WeatherInfoBloc(RepositoryProvider.of<WeatherRepository>(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherInfoBloc>(
        bloc: weatherInfoBloc, child: const WeatherView());
  }
}
