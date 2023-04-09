import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/location_search_bloc.dart';
import 'package:weather_app/ui/screens/location_search/location_search_view.dart';

import '../../../core/bloc/bloc_provider.dart';
import '../../../core/repositories/provider.dart';
import '../../../core/repositories/weather_repository.dart';
import '../weather/weather_view.dart';

class LocationSearchPage extends StatefulWidget {
  const LocationSearchPage({super.key, required this.backToWeather});
  final VoidCallback backToWeather;

  @override
  State<LocationSearchPage> createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  late LocationSearchBloc locationSearchBloc;

  @override
  void initState() {
    locationSearchBloc =
        LocationSearchBloc(RepositoryProvider.of<WeatherRepository>(context));
    super.initState();
  }

  @override
  void dispose() {
    locationSearchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationSearchBloc>(
        bloc: locationSearchBloc,
        child: LocationSearchView(
          backToWeather: widget.backToWeather,
        ));
  }
}
