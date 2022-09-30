import 'package:flutter/material.dart';
import 'package:weather_app/screens/start_screen.dart';
import 'package:weather_app/screens/weather_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => StartScreen(),
          '/weather': (context) => WeatherInfo()
        });
  }
}
