import 'package:flutter/material.dart';
import 'package:weather_app/core/models/weather.dart';
import 'package:weather_app/ui/screens/weather/components/weather_forecast_card.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({required this.weather,super.key});

  final Weather weather;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Next hours',
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        Flexible(
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: weather.nextHoursWeather.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8.0);
              },
              itemBuilder: (context, index) {
                return WeatherForecastCard(
                    weather: weather.nextHoursWeather[index]);
              }),
        ),
      ],
    );
  }
}
