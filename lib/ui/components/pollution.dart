import 'package:flutter/material.dart';
import 'package:weather_app/core/services/weather.dart';

class PollutionView extends StatelessWidget {
  final Weather weather;
  const PollutionView({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  Text(weather.pollutionInfo['aqi'].toString(),
                      style:
                          const TextStyle(fontSize: 40, color: Colors.white)),
                  Text('/5',
                      style: TextStyle(
                          fontSize: 40, color: Colors.white.withOpacity(0.5)))
                ],
              ),
              Text(weather.pollutionInfo['evaluation'],
                  style: const TextStyle(fontSize: 20, color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}