import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/pollution_info_bloc.dart';

import '../../../core/bloc/bloc_provider.dart';
import '../../../core/repositories/provider.dart';
import '../../../core/repositories/weather_repository.dart';

import 'package:weather_app/ui/screens/pollution/pollution_view.dart';

class PollutionPage extends StatelessWidget {
  const PollutionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PollutionInfoBloc>(
        bloc: PollutionInfoBloc(
            RepositoryProvider.of<WeatherRepository>(context)),
        child: const PollutionView());
  }
}
