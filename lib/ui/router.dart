import 'package:flutter/material.dart';
import 'package:weather_app/core/models/single_weather.dart';
import 'package:weather_app/ui/views/home_view.dart';

class MyRouter {
  static Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => HomeView());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                    body: Center(
                  child: Text('No route defined for ${settings.name}'),
                )));
    }
  }
}
