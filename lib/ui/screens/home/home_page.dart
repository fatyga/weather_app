import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/home_bloc.dart';

import '../../../core/bloc/bloc_provider.dart';
import '../../../core/repositories/provider.dart';
import '../../../core/repositories/weather_repository.dart';
import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
        bloc: HomeBloc(RepositoryProvider.of<WeatherRepository>(context)),
        child: const HomeView());
  }
}
