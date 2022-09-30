import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/screens/weather_info.dart';
import 'package:weather_app/utils/app_styles.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  var instance = Weather();
  late var value;

  @override
  void initState() {
    value = instance.setupWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Weather App', style: TextStyle(fontSize: 25)),
                      const SizedBox(height: 15),
                      Text(snapshot.error.toString(), style: Styles.error),
                      const SizedBox(height: 15),
                      ElevatedButton(
                          onPressed: () {
                            var refreshedInfo = instance.setupWeather();
                            setState(() {
                              value = refreshedInfo;
                            });
                          },
                          child: const Text('Try again'))
                    ],
                  ),
                );
              } else {
                return WeatherView(
                    weather: instance,
                    toUpdate: () {
                      var refreshedInfo = instance.setupWeather();
                      setState(() {
                        value = refreshedInfo;
                      });
                    });
              }
            }
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Weather App', style: TextStyle(fontSize: 25)),
                SizedBox(height: 15),
                CircularProgressIndicator(),
              ],
            ));
          }),
    );
  }
}
