import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/enums.dart';
import 'package:weather_app/core/models/single_pollution.dart';
import 'package:weather_app/ui/screens/home/components/pollution_components_overview.dart';

class AirPollutionForecast extends StatefulWidget {
  const AirPollutionForecast({super.key, required this.forecast});
  final List<SinglePollution> forecast;

  @override
  State<AirPollutionForecast> createState() => _AirPollutionForecastState();
}

class _AirPollutionForecastState extends State<AirPollutionForecast> {
  late List<bool> items =
      List.generate(widget.forecast.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        children: [
          ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  items[index] = !items[index];
                });
              },
              children: widget.forecast.take(24).map<ExpansionPanel>((e) {
                return ExpansionPanel(
                    isExpanded: items[widget.forecast.indexOf(e)],
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                          title: Row(
                        children: [
                          Text(SinglePollution.descriptions[e.aqi]),
                        ],
                      ));
                    },
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AirComponentsOverview(
                          size: AirComponentSize.small,
                          airComponents: e.airComponents.components),
                    ));
              }).toList())
        ],
      ),
    );
  }
}
