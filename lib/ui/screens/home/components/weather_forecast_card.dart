import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/models/single_weather.dart';

class WeatherForecastCard extends StatefulWidget {
  const WeatherForecastCard({super.key, required this.weather});
  final SingleWeather weather;

  @override
  State<WeatherForecastCard> createState() => _WeatherForecastCardState();
}

class _WeatherForecastCardState extends State<WeatherForecastCard> {
  bool frontSide = true;

  void toogleSide() {
    setState(() {
      frontSide = !frontSide;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: toogleSide,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateFormat.Hm().format(widget.weather.time)),
              showSide(),
              Text(widget.weather.temp)
            ],
          ),
        ),
      ),
    );
  }

  Widget showSide() {
    if (frontSide) {
      return Image.network(widget.weather.iconUrl, scale: 1.5);
    } else {
      return Expanded(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(
            children: [
              const Text('wind',
                  style: TextStyle(
                    fontSize: 10,
                  )),
              Text(widget.weather.wind.toString(),
                  style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            children: [
              const Text('humidity', style: TextStyle(fontSize: 10)),
              Text(widget.weather.humidity.toString(),
                  style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            children: [
              const Text('pressure', style: TextStyle(fontSize: 10)),
              Text(widget.weather.pressure.toString(),
                  style: TextStyle(fontSize: 12))
            ],
          ),
        ]),
      );
    }
  }
}
