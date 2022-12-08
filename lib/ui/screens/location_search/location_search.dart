import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/bloc_provider.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/core/services/weather_service.dart';

class LocationSearch extends StatefulWidget {
  const LocationSearch({super.key});
  // final Weather weatherInstance;

  @override
  State<LocationSearch> createState() => _CitySearchState();
}

class _CitySearchState extends State<LocationSearch> {
  final cityNameController = TextEditingController();
  String errors = '';

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).locationSearchBloc;
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
                            bloc.getLocationFromName(cityNameController.text);
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Search')),
                    const SizedBox(height: 20),
                    // if (widget.weatherInstance.locations.isNotEmpty)
                    //   Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         const Text('Recently searched',
                    //             style: TextStyle(
                    //                 fontSize: 20, fontWeight: FontWeight.bold)),
                    //         const SizedBox(height: 10),
                    //         ListView.builder(
                    //             shrinkWrap: true,
                    //             physics: ClampingScrollPhysics(),
                    //             itemCount:
                    //                 widget.weatherInstance.locations.length,
                    //             itemBuilder: (_, index) {
                    //               SingleLocation currentLocation =
                    //                   widget.weatherInstance.locations[index];

                    //               return Card(
                    //                 child: ListTile(
                    //                     onTap: () {
                    //                       Navigator.of(context).pop(index);
                    //                     },
                    //                     leading: currentLocation.autoDetected
                    //                         ? const Icon(Icons.gps_fixed)
                    //                         : Image.asset(
                    //                             width: 25,
                    //                             height: 25,
                    //                             'icons/flags/png/${currentLocation.countryCode.toLowerCase()}.png',
                    //                             package: 'country_icons'),
                    //                     title: currentLocation.autoDetected
                    //                         ? const Text('Detect your location')
                    //                         : Row(children: [
                    //                             Text(currentLocation.name
                    //                                 .toString()),
                    //                           ])),
                    //               );
                    //             })
                    //       ]),
                  ],
                );
              }),
        ));
  }
}
