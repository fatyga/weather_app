import 'package:flutter/material.dart';
import 'package:weather_app/core/models/single_weather.dart';
import 'package:weather_app/ui/components/pollution.dart';
import 'package:weather_app/ui/components/weather_info.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.weather});

  final SingleWeather weather;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 0;
  dynamic tabs = [];

  @override
  void initState() {
    tabs.add(WeatherInfo(weather: widget.weather));
    tabs.add(PollutionInfo());
    super.initState();
  }

  void setIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[index],
      bottomNavigationBar:
          BottomNavigationBar(currentIndex: index, onTap: setIndex, items: [
        const BottomNavigationBarItem(
            icon: Icon(Icons.cloud), label: 'Weather'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.public_outlined), label: 'Air Pollution')
      ]),
    );
  }
}
