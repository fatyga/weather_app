import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/bloc/bloc_provider.dart';
import 'package:weather_app/ui/screens/home/components/weather_forecast_card.dart';
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
          return Column(children: [
            Column(
              children: [
                (bloc.currentLocation.autoDetected)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            const Icon(Icons.location_on_outlined, size: 20),
                            Text(bloc.currentLocation.name,
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                          ])
                    : Text(bloc.currentLocation.name,
                        style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 2),
                Text(DateFormat.yMMMEd()
                    .add_Hm()
                    .format(snapshot.data.currentWeather.time)),
                const SizedBox(height: 16),
                Image.network(snapshot.data.currentWeather.iconUrl),
                const SizedBox(height: 16),
              ],
            ),
            Text(snapshot.data.currentWeather.description,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: const BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('temperature'),
                            Text(snapshot.data.currentWeather.temp),
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
                            Text(snapshot.data.currentWeather.humidity)
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: const BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('wind'),
                            Row(
                              children: [
                                Text(snapshot.data.currentWeather.wind),
                                const SizedBox(width: 4),
                                Transform.rotate(
                                    angle: double.parse(snapshot
                                        .data.currentWeather.windDegree),
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
                            Text(snapshot.data.currentWeather.pressure)
                          ],
                        ),
                      )
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Next hours',
                      style: Theme.of(context).textTheme.subtitle2),
                ],
              ),
            ),
            Flexible(
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.nextHoursWeather.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 8.0);
                    },
                    itemBuilder: (context, index) {
                      return WeatherForecastCard(
                          weather: snapshot.data.nextHoursWeather[index]);
                    }))
          ]);
        });
  }
}
