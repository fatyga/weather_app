import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/models/single_weather.dart';
import 'package:weather_app/ui/screens/home/components/weather_icon.dart';

class WeatherForecastCard extends StatefulWidget {
  const WeatherForecastCard({super.key, required this.weather});
  final SingleWeather weather;

  @override
  State<WeatherForecastCard> createState() => _WeatherForecastCardState();
}

class _WeatherForecastCardState extends State<WeatherForecastCard> {
  bool extended = false;

  void toogleSide() {
    setState(() {
      extended = !extended;
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
          child: Row(
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat.Hm().format(widget.weather.time)),
                    WeatherIcon(iconCode: widget.weather.iconCode, size: 72),
                    Text(widget.weather.temp),
                  ]),
              extended ? const VerticalDivider() : Container(),
              showSide(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showSide() {
    if (extended) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
            const Divider(color: Colors.black),
            Column(
              children: [
                const Text('humidity', style: TextStyle(fontSize: 10)),
                Text(widget.weather.humidity.toString(),
                    style: TextStyle(fontSize: 12)),
              ],
            ),
            const Divider(color: Colors.black),
            Column(
              children: [
                const Text('pressure', style: TextStyle(fontSize: 10)),
                Text(widget.weather.pressure.toString(),
                    style: TextStyle(fontSize: 12))
              ],
            ),
          ]);
    } else {
      return Container();
    }
  }
}
