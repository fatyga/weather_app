import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/bloc_provider.dart';
import 'package:weather_app/core/models/single_pollution.dart';

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
                  const SizedBox(height: 32),
                  Text(SinglePollution.descriptions[snapshot.data.aqi],
                      style: TextStyle(
                          fontSize: 28,
                          color: SinglePollution.colors[snapshot.data.aqi])),
                  const SizedBox(height: 32),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: snapshot.data.airComponents.components
                          .map<Widget>((element) => Column(
                                children: [
                                  Text(element.name),
                                  const SizedBox(height: 8),
                                  Container(
                                      width: 54,
                                      height: 54,
                                      decoration: BoxDecoration(
                                          color: element.color[100],
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Center(
                                        child: Text(element.value.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: element.color[700])),
                                      ))
                                ],
                              ))
                          .toList())
                ],
              ),
            );
          }
        });
  }
}
