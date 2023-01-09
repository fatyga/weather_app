import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/bloc_provider.dart';
import 'package:weather_app/core/models/single_location.dart';
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
  bool isSearching = false;
  late Future<List<SingleLocation>?> searchResults;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).locationSearchBloc;
    return Scaffold(
        body: Column(
      children: [
        TextField(
          onChanged: (value) {
            if (isSearching == false) {
              setState(() {
                isSearching = !isSearching;
              });
            }

            if (value.isNotEmpty) {
              setState(() {
                searchResults = bloc.searchLocationsByName(value);
              });
            } else {
              setState(() {
                isSearching = !isSearching;
              });
            }
          },
          controller: cityNameController,
          decoration:
              const InputDecoration(filled: true, hintText: 'Start typing...'),
        ),
        const SizedBox(height: 8),
        Text(errors, style: const TextStyle(color: Colors.red)),
        const SizedBox(height: 20),
        isSearching
            ? SearchResult(
                result: searchResults,
                onTap: (SingleLocation location) {
                  bloc.getLocation(location);
                  if (!bloc.recentLocations.any(
                      (element) => element.name == location.autoDetected)) {
                    bloc.recentLocations.add(location);
                  }
                  widget.backToWeather();
                })
            : RecentLocations(
                locations: bloc.recentLocations,
                onTap: (index) {
                  bloc.getLocation(bloc.recentLocations[index]);
                  widget.backToWeather();
                })
      ],
    ));
  }
}

class RecentLocations extends StatelessWidget {
  const RecentLocations(
      {super.key, required this.locations, required this.onTap});
  final List<SingleLocation> locations;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text('Recent locations',
              style: Theme.of(context).textTheme.subtitle2),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  final title = locations[index].autoDetected
                      ? Row(children: [
                          const Icon(Icons.location_on_outlined, size: 20),
                          Text(locations[index].name),
                        ])
                      : Text(locations[index].name);

                  return ListTile(
                    title: Row(children: [
                      (locations[index].autoDetected)
                          ? Icon(Icons.location_on_outlined)
                          : Container(),
                      Text(locations[index].name),
                      Text(
                          ', ${CountryCodes.detailsForLocale(Locale('en', locations[index].countryCode)).localizedName!}',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: Colors.grey)),
                    ]),
                    onTap: () {
                      onTap(index);
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  const SearchResult({super.key, required this.result, required this.onTap});
  final Future<List<SingleLocation>?> result;
  final Function(SingleLocation) onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
        Text('Searched locations',
            style: Theme.of(context).textTheme.subtitle2),
        const SizedBox(height: 16),
        FutureBuilder(
            future: result,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error occured');
                } else {
                  if (snapshot.hasData) {
                    return Flexible(
                      child: ListView(
                          children: snapshot.data!
                              .map((location) => ListTile(
                                    onTap: () {
                                      onTap(location);
                                    },
                                    title: Row(
                                      children: [
                                        Text(location.name),
                                        Text(
                                            ', ${CountryCodes.detailsForLocale(Locale('en', location.countryCode)).localizedName!}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(color: Colors.grey)),
                                      ],
                                    ),
                                    subtitle: Text(location.state ?? ''),
                                  ))
                              .toList()),
                    );
                  } else {
                    return const Text('0 locations found');
                  }
                }
              }
              return Container();
            })
      ]),
    );
  }
}
