import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/bloc_provider.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/core/services/weather_service.dart';

class LocationSearch extends StatefulWidget {
  const LocationSearch({super.key, required this.backToWeather});
  final Function() backToWeather;

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
        body: Column(
      children: [
        TextField(
          controller: cityNameController,
          decoration: const InputDecoration(filled: true, labelText: 'City'),
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
                widget.backToWeather();
              }
            },
            child: const Text('Search')),
        const SizedBox(height: 20),
        Text('Recent locations', style: Theme.of(context).textTheme.subtitle2),
        Flexible(
          child: ListView.builder(
              itemCount: bloc.recentLocations.length,
              itemBuilder: (context, index) {
                final title = bloc.recentLocations[index].autoDetected
                    ? Row(children: [
                        const Icon(Icons.location_on_outlined, size: 20),
                        Text(bloc.recentLocations[index].name),
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
    ));
  }
}
