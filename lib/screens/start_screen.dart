import 'package:flutter/material.dart';
import 'package:weather_app2/services/weather.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Future<void> setupWeather() async {
    var instance = Weather();
    await instance.determinePosition();
    await instance.getWeather();
    Navigator.pushReplacementNamed(context, '/weather', arguments: {
      'data': instance.weatherInfo,
    });
  }

  @override
  void initState() {
    setupWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: const <Widget>[
                Text('Weather App', style: TextStyle(fontSize: 26)),
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
