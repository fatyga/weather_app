import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/bloc_provider.dart';
import 'package:weather_app/core/constants/enums.dart';
import 'package:weather_app/core/models/single_pollution.dart';
import 'package:weather_app/ui/screens/home/components/pollution_components_overview.dart';
import 'package:weather_app/ui/screens/home/components/pollution_forecast.dart';

class PollutionInfo extends StatelessWidget {
  const PollutionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).pollutionInfoBloc;

    return StreamBuilder<Object>(
        stream: bloc.info,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
              child: Column(
                children: [
                  (bloc.currentLocation.autoDetected)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              const Icon(Icons.location_on_outlined, size: 20),
                              Text(bloc.currentLocation.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ])
                      : Text(bloc.currentLocation.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                  Text(bloc.currentLocation.timezone.localTime.toString()),
                  const SizedBox(height: 32),
                  Text(
                      SinglePollution
                          .descriptions[snapshot.data.currentPollution.aqi],
                      style: TextStyle(
                          fontSize: 28,
                          color: SinglePollution
                              .colors[snapshot.data.currentPollution.aqi])),
                  const SizedBox(height: 32),
                  AirComponentsOverview(
                      size: AirComponentSize.standard,
                      airComponents: snapshot
                          .data.currentPollution.airComponents.components),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      children: const [
                        Text('Next hours'),
                      ],
                    ),
                  ),
                  AirPollutionForecast(
                    forecast: snapshot.data.nextHoursPollution,
                  )
                ],
              ),
            );
          }
        });
  }
}
