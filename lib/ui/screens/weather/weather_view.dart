import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/bloc/bloc_provider.dart';
import 'package:weather_app/ui/screens/weather/components/weather_forecast.dart';
import 'package:weather_app/ui/screens/weather/components/weather_forecast_card.dart';
import 'package:weather_app/ui/screens/home/components/weather_icon.dart';

import '../../../core/bloc/weather_info_bloc.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WeatherInfoBloc>(context);

    return StreamBuilder<Object>(
        stream: bloc.info,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          return Column(children: [
            Column(
              children: [
                Row(
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    if(bloc.currentLocation.autoDetected) const Icon(Icons.location_on_outlined, size: 20),
                    Text(bloc.currentLocation.name,
                        style: Theme.of(context).textTheme.headlineSmall),
                    Text(
                        ', ${CountryCodes.detailsForLocale(Locale('en', bloc.currentLocation.countryCode)).localizedName}',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(DateFormat.yMMMEd()
                    .add_Hm()
                    .format(snapshot.data.currentWeather.time)),
                const SizedBox(height: 16),
                WeatherIcon(
                    iconCode: snapshot.data.currentWeather.iconCode, size: 96),
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
        const SizedBox(height:48),
         Flexible(child: WeatherForecast(weather: snapshot.data)),
            const SizedBox(height: 16)
          ]);

        });
  }
}
