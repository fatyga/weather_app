// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'dart:convert';

class SinglePollution {
  static List descriptions = <String>[
    'Good',
    'Fair',
    'Moderate',
    'Poor',
    'Very Poor'
  ];

  static List icons = <IconData>[
    Icons.mood,
    Icons.mood,
    Icons.sentiment_neutral_outlined,
    Icons.mood_bad_outlined,
    Icons.sentiment_very_dissatisfied_outlined,
  ];

  static List colors = <Color>[
    Colors.green,
    Colors.lightGreen,
    Colors.amber,
    Colors.orange,
    Colors.red,
  ];

  final int aqi;
  final Components airComponents;
  final DateTime time;
  final int utcOffset;

  SinglePollution(
      {required this.aqi,
      required this.airComponents,
      required this.time,
      required this.utcOffset});

  factory SinglePollution.fromMap(int utcOffset, Map<String, dynamic> map) {
    var time = map['dt'] + utcOffset;
    return SinglePollution(
        utcOffset: utcOffset,
        aqi: (map['main']['aqi'] - 1),
        time: DateTime.fromMillisecondsSinceEpoch(time * 1000),
        airComponents: Components.fromJson(map['components']));
  }
}

class Components {
  List<Component> components;

  Components({required this.components});

  factory Components.fromJson(Map<String, dynamic> json) {
    final componentsList = <Component>[];
    final filteredComponents = Map.from(json)
      ..removeWhere((key, value) => !Component.ranges.containsKey(key));

    filteredComponents
        .forEach((k, v) => componentsList.add(Component(k, v.toDouble())));

    return Components(components: componentsList);
  }
}

class Component {
  String name;
  double value;
  late int index;
  late Color color;

  Component(this.name, this.value) {
    obtainIndex(name, value);
  }

  static Map ranges = {
    'no2': [50, 100, 200, 400],
    'pm10': [25, 50, 90, 180],
    'o3': [60, 120, 180, 240],
    'pm2_5': [15, 30, 55, 110],
  };

  void obtainIndex(String name, double value) {
    final range = ranges[name];
    int i = 0;
    while (value > range[i]) {
      i++;
      if (i == ranges.length) {
        break;
      }
    }
    index = i;

    color = SinglePollution.colors[index];
  }
}
