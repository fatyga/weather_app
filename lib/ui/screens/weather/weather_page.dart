import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/weather_info_bloc.dart';
import 'package:weather_app/ui/screens/weather/weather_view.dart';

import '../../../core/bloc/bloc_provider.dart';
import '../../../core/repositories/provider.dart';
import '../../../core/repositories/weather_repository.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherInfoBloc>(
        bloc:
            WeatherInfoBloc(RepositoryProvider.of<WeatherRepository>(context)),
        child: const WeatherView());
  }
}
