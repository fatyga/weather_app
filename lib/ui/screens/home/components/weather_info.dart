import 'package:flutter/material.dart';

import 'package:weather_app/core/services/location_service.dart';

import 'package:weather_app/ui/screens/city_search/city_search.dart';
import 'package:weather_app/core/services/weather_service.dart';
import 'package:weather_app/ui/shared/app_styles.dart';

class WeatherInfo extends StatefulWidget {
  WeatherInfo({Key? key}) : super(key: key);

  @override
  _WeatherInfoState createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Row(children: <Widget>[
            Expanded(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //     width: 35,
                    //     height: 35,
                    //     'icons/flags/png/.png',
                    //     package: 'country_icons'),
                    const SizedBox(width: 10),
                    Text('location', style: Styles.headline1),
                  ],
                ),
                Text('time'),
                const SizedBox(height: 50),
                //Image.network(model.weather!.iconUrl),
                const SizedBox(height: 50),
                Text('description', style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: [
                        Text('min', style: Styles.headline3),
                        Text('minTemp'),
                      ],
                    ),
                    Text('temp', style: const TextStyle(fontSize: 40)),
                    Column(
                      children: [
                        Text('max', style: Styles.headline3),
                        Text('maxtemp'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(children: [
                        Text('humidity', style: Styles.headline2),
                        const SizedBox(height: 5),
                        Text('humidity')
                      ]),
                      Column(children: [
                        Text('pressure', style: Styles.headline2),
                        const SizedBox(height: 5),
                        Text('pressure')
                      ]),
                      Column(children: [
                        Text('wind', style: Styles.headline2),
                        const SizedBox(height: 5),
                        Text('wind')
                      ]),
                    ]),
                ElevatedButton(
                    onPressed: () {
                      // model.getWeather();
                    },
                    child: Text('Refresh'))
              ]),
            ),
          ])
        ],
      )),
    );
  }
}
