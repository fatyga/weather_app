import 'package:flutter/material.dart';
import 'package:weather_app/ui/screens/home/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App', debugShowCheckedModeBanner: false, home: Home());
  }
}
