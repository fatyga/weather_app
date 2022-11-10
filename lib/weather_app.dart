import 'package:flutter/material.dart';
import 'package:weather_app/ui/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: MyRouter.generateRoutes,
    );
  }
}
