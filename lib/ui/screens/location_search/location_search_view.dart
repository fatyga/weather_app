import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/bloc_provider.dart';
import 'package:weather_app/core/models/single_location.dart';

import '../../../core/bloc/location_search_bloc.dart';

class LocationSearchView extends StatefulWidget {
  const LocationSearchView({super.key, required this.backToWeather});
  final Function() backToWeather;

  @override
  State<LocationSearchView> createState() => _CitySearchState();
}

class _CitySearchState extends State<LocationSearchView> {
  final cityNameController = TextEditingController();
  String errors = '';
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LocationSearchBloc>(context);
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
              bloc.searchByLocationName(value);
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
            ? SearchResult(bloc, widget.backToWeather)
            : RecentLocations(
                locations: bloc.recentLocations,
                onTap: (index) {
                  bloc.setLocation(bloc.recentLocations[index]);
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
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(children: [
                      (locations[index].autoDetected)
                          ? const Icon(Icons.location_on_outlined)
                          : Container(),
                      Text(locations[index].name),
                      Text(
                          ', ${CountryCodes.detailsForLocale(Locale('en', locations[index].countryCode)).localizedName!}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
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
  const SearchResult(this.bloc, this.backToWeather, {super.key});
  final LocationSearchBloc bloc;
  final VoidCallback backToWeather;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
        Text('Searched locations',
            style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 16),
        StreamBuilder(
            stream: bloc.searchLocation,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const CircularProgressIndicator();
              } else if (snapshot.data!.isEmpty) {
                return const Text('0 results. Try correcting location name.');
              } else {
                return Flexible(
                  child: ListView(
                      children: snapshot.data!
                          .map((location) => ListTile(
                                onTap: () {
                                  bloc.setLocation(location);

                                  backToWeather();
                                },
                                title: Row(
                                  children: [
                                    Text(location.name),
                                    Text(
                                        ', ${CountryCodes.detailsForLocale(Locale('en', location.countryCode)).localizedName!}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(color: Colors.grey)),
                                  ],
                                ),
                                subtitle: Text(location.state ?? ''),
                              ))
                          .toList()),
                );
              }
            })
      ]),
    );
  }
}
