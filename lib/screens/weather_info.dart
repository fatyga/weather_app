import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utils/app_styles.dart';

class WeatherView extends StatefulWidget {
  Weather weather;
  Function() toUpdate;

  WeatherView({required this.weather, required this.toUpdate});

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
        child: Row(children: <Widget>[
          Expanded(
            child: Column(children: [
              const SizedBox(height: 50),
              Text(
                  '${widget.weather.weatherInfo['locationName']}'.toUpperCase(),
                  style: Styles.headline1),
              Text(widget.weather.weatherInfo['time'].toUpperCase()),
              const SizedBox(height: 50),
              Image.network(widget.weather.weatherInfo['icon']),
              const SizedBox(height: 50),
              Text(widget.weather.weatherInfo['description'].toUpperCase(),
                  style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: [
                      Text('min', style: Styles.headline3),
                      Text(widget.weather.weatherInfo['minTemp']),
                    ],
                  ),
                  Text('${widget.weather.weatherInfo['temp']}',
                      style: const TextStyle(fontSize: 40)),
                  Column(
                    children: [
                      Text('max', style: Styles.headline3),
                      Text(widget.weather.weatherInfo['minTemp']),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(children: [
                  Text('humidity', style: Styles.headline2),
                  const SizedBox(height: 5),
                  Text(widget.weather.weatherInfo['humidity'])
                ]),
                Column(children: [
                  Text('pressure', style: Styles.headline2),
                  const SizedBox(height: 5),
                  Text(widget.weather.weatherInfo['pressure'])
                ]),
                Column(children: [
                  Text('wind', style: Styles.headline2),
                  const SizedBox(height: 5),
                  Text(widget.weather.weatherInfo['wind'])
                ]),
              ]),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: widget.toUpdate, child: const Text('Refresh')),
            ]),
          ),
        ]),
      ),
    );
  }
}
