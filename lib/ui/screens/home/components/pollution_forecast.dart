import 'package:flutter/material.dart';
import 'package:weather_app/core/models/single_pollution.dart';

class AirPollutionForecast extends StatefulWidget {
  const AirPollutionForecast(
      {super.key, required this.forecast, required this.fn});
  final List<SinglePollution> forecast;
  final Function(String name, BuildContext context) fn;

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
                        title: Text(SinglePollution.descriptions[e.aqi]));
                  },
                  body: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:
                          e.airComponents.components.map<Widget>((element) {
                        return Flexible(
                          child: Column(
                            children: [
                              widget.fn(element.name, context),
                              const SizedBox(height: 8),
                              Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                      color: element.color,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: Text(element.value.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: element.color)),
                                  ))
                            ],
                          ),
                        );
                      }).toList()),
                );
              }).toList())
        ],
      ),
    );
  }
}
