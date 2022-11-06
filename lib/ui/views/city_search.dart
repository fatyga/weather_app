import 'package:flutter/material.dart';
import 'package:weather_app/core/services/location.dart';
import 'package:weather_app/core/services/single_location.dart';
import 'package:weather_app/core/services/weather.dart';

class CitySearch extends StatefulWidget {
  const CitySearch({super.key, required this.weatherInstance});
  final Weather weatherInstance;

  @override
  State<CitySearch> createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {
  final cityNameController = TextEditingController();
  String errors = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Find out city')),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TextField(
                      controller: cityNameController,
                      decoration: const InputDecoration(
                          filled: true, labelText: 'City'),
                    ),
                    const SizedBox(height: 8),
                    Text(errors, style: const TextStyle(color: Colors.red)),
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            errors = '';
                          });

                          if (cityNameController.text.isNotEmpty) {
                            List locationNames = widget
                                .weatherInstance.locations
                                .map((location) => location.name.toLowerCase())
                                .toList();

                            if (locationNames.contains(
                                cityNameController.text.toLowerCase())) {
                              Navigator.of(context).pop(locationNames.indexOf(
                                  cityNameController.text.toLowerCase()));
                            } else {
                              var result =
                                  await LocationService.getCoordinatesFromName(
                                      cityNameController.text);

                              Navigator.of(context).pop(result);
                            }
                          } else {
                            Navigator.of(context).pop(null);
                          }
                        },
                        child: const Text('Search')),
                    const SizedBox(height: 20),
                    if (widget.weatherInstance.locations.isNotEmpty)
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Recently searched',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount:
                                    widget.weatherInstance.locations.length,
                                itemBuilder: (_, index) {
                                  SingleLocation currentLocation =
                                      widget.weatherInstance.locations[index];

                                  return Card(
                                    child: ListTile(
                                        onTap: () {
                                          Navigator.of(context).pop(index);
                                        },
                                        leading: currentLocation.autoDetected
                                            ? const Icon(Icons.gps_fixed)
                                            : Image.asset(
                                                width: 25,
                                                height: 25,
                                                'icons/flags/png/${currentLocation.countryCode.toLowerCase()}.png',
                                                package: 'country_icons'),
                                        title: currentLocation.autoDetected
                                            ? const Text('Detect your location')
                                            : Row(children: [
                                                Text(currentLocation.name
                                                    .toString()),
                                              ])),
                                  );
                                })
                          ]),
                  ],
                );
              }),
        ));
  }
}
