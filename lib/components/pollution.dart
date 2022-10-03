import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utils/app_styles.dart';

class PollutionView extends StatelessWidget {
  Weather weather;
  PollutionView({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    print(weather.pollutionInfo);
    return Container(
      decoration: BoxDecoration(
        color: weather.pollutionInfo['bgColor'],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const Text('Air Pollution Report',
              style: TextStyle(color: Colors.white)),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(weather.pollutionInfo['aqi'].toString(),
                  style: const TextStyle(fontSize: 40, color: Colors.white)),
              Column(
                children: [
                  Text(weather.pollutionInfo['evaluation'],
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                  const SizedBox(height: 10),
                  Text('Description will be here',
                      style: const TextStyle(fontSize: 16, color: Colors.white))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
