import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/pollution_info_bloc.dart';

import '../../../core/bloc/bloc_provider.dart';
import '../../../core/repositories/provider.dart';
import '../../../core/repositories/weather_repository.dart';

import 'package:weather_app/ui/screens/pollution/pollution_view.dart';

class PollutionPage extends StatefulWidget {
  const PollutionPage({super.key});

  @override
  State<PollutionPage> createState() => _PollutionPageState();
}

class _PollutionPageState extends State<PollutionPage> {
  late PollutionInfoBloc pollutionInfoBloc;

  @override
  void initState() {
    pollutionInfoBloc =
        PollutionInfoBloc(RepositoryProvider.of<WeatherRepository>(context));
    super.initState();
  }

  @override
  void dispose() {
    pollutionInfoBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PollutionInfoBloc>(
        bloc: pollutionInfoBloc, child: const PollutionView());
  }
}
