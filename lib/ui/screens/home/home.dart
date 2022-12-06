import 'package:flutter/material.dart';
import 'package:weather_app/ui/screens/home/components/pollution_info.dart';
import 'package:weather_app/ui/screens/home/components/weather_info.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  List<Widget> pages = [
    WeatherInfo(key: PageStorageKey('weatherInfo')),
    PollutionInfo(key: PageStorageKey('pollutionInfo'))
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  void setIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  Widget _bottomNavigatonBar(int index) =>
      BottomNavigationBar(currentIndex: index, onTap: setIndex, items: [
        const BottomNavigationBarItem(
            icon: Icon(Icons.cloud), label: 'Weather'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.public_outlined), label: 'Air Pollution')
      ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: pages[index],
        bucket: bucket,
      ),
      bottomNavigationBar: _bottomNavigatonBar(index),
    );
  }
}
