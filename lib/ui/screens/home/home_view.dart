import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/bloc_provider.dart';
import 'package:weather_app/core/models/status.dart';
import 'package:weather_app/ui/screens/home/components/status_bar.dart';
import 'package:weather_app/ui/screens/pollution/pollution_page.dart';
import 'package:weather_app/ui/screens/settings/settings.dart';
import 'package:weather_app/ui/screens/weather/weather_page.dart';

import '../../../core/bloc/home_bloc.dart';
import '../location_search/location_search_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 0;

  late List<Widget> pages;

  @override
  void initState() {
    pages = [
      const WeatherPage(),
      const PollutionPage(),
      LocationSearchPage(backToWeather: () => setIndex(0))
    ];
    super.initState();
  }

  void setIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
            stream: bloc.status,
            initialData: Status(StatusState.fetching, ''),
            builder: (context, snapshot) {
              return StatusBar(status: snapshot.data!);
            }),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Settings()));
              },
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
        child: pages[index],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: setIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Weather'),
            BottomNavigationBarItem(
                icon: Icon(Icons.public_outlined), label: 'Air Pollution'),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_city), label: 'Locations')
          ]),
    );
  }
}
