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
            child: Column(
              children: [
                TextField(
                  controller: cityNameController,
                  decoration:
                      const InputDecoration(filled: true, labelText: 'City'),
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
                const Text('Recent locations',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                Flexible(
                  child: ListView.builder(
                      itemCount: bloc.recentLocations.length,
                      itemBuilder: (context, index) {
                        final title = bloc.recentLocations[index].autoDetected
                            ? Row(children: [
                                Text(bloc.recentLocations[index].name),
                                Icon(Icons.location_on)
                              ])
                            : Text(bloc.recentLocations[index].name);

                        return ListTile(
                            title: title,
                            onTap: () {
                              bloc.getLocation(bloc.recentLocations[index]);
                              Navigator.of(context).pop();
                            });
                      }),
                )
              ],
            )));
  }
}
