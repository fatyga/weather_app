import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/bloc_provider.dart';
import 'package:weather_app/ui/shared/app_styles.dart';

class WeatherInfo extends StatelessWidget {
  WeatherInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).weatherInfoBloc;

    return StreamBuilder<Object>(
        stream: bloc.info,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          return Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0),
              child: Column(children: [
                Column(
                  children: [
                    (snapshot.data.location.autoDetected)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                const Icon(Icons.location_on_outlined,
                                    size: 20),
                                Text(snapshot.data.location.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ])
                        : Text(snapshot.data.location.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                    const SizedBox(height: 16),
                    Image.network(snapshot.data.iconUrl),
                    const SizedBox(height: 16),
                  ],
                ),
                Text(snapshot.data.description, style: TextStyle(fontSize: 20)),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('temperature'),
                              Text(snapshot.data.temp),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.grey,
                          ))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('humidity'),
                              Text(snapshot.data.humidity)
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('wind'),
                              Row(
                                children: [
                                  Text(snapshot.data.wind),
                                  const SizedBox(width: 4),
                                  Transform.rotate(
                                      angle: double.parse(
                                          snapshot.data.windDegree),
                                      child: const Icon(Icons.arrow_upward,
                                          size: 16))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('pressure'),
                              Text(snapshot.data.pressure)
                            ],
                          ),
                        )
                      ]),
                ),
              ]));
        });
  }
}
