import 'package:flutter/material.dart';
import 'package:weather_app/core/services/weather_service.dart';

class PollutionInfo extends StatelessWidget {
  //final Weather weather;
  const PollutionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
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
                        Text('aqi',
                            style: const TextStyle(
                                fontSize: 40, color: Colors.white)),
                        Text('/5',
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white.withOpacity(0.5)))
                      ],
                    ),
                    // Text(model.pollutionInfo['evaluation'],
                    //     style: const TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}