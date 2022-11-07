import 'package:flutter/material.dart';
import 'package:weather_app/ui/views/start_view.dart';
import 'package:weather_app/ui/views/weather_info.dart';

class MyRouter {
  static Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => StartView());
      case '/weatherInfo':
        return MaterialPageRoute(builder: (context) => WeatherView());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                    body: Center(
                  child: Text('No route defined for ${settings.name}'),
                )));
    }
  }
}
