import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/bloc_provider.dart';
import 'package:weather_app/core/models/status.dart';
import 'package:weather_app/ui/screens/home/components/status_bar.dart';
import 'package:weather_app/ui/screens/location_search/location_search.dart';
import 'package:weather_app/ui/screens/home/components/pollution_info.dart';
import 'package:weather_app/ui/screens/home/components/weather_info.dart';
import 'package:weather_app/ui/screens/settings/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  late List<Widget> pages;

  @override
  void initState() {
    pages = [
      WeatherInfo(),
      PollutionInfo(),
      LocationSearch(backToWeather: () => setIndex(0))
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
    final bloc = BlocProvider.of(context).homeBloc;
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
