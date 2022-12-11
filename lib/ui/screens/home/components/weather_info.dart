import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/bloc_provider.dart';
import 'package:weather_app/ui/shared/app_styles.dart';

class WeatherInfo extends StatelessWidget {
  WeatherInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).weatherInfoBloc;

    return SafeArea(
      child: Scaffold(
          body: StreamBuilder<Object>(
              stream: bloc.info,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());

                return Column(
                  children: [
                    Row(children: <Widget>[
                      Expanded(
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [],
                          ),
                          const SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  width: 35,
                                  height: 35,
                                  'icons/flags/png/${snapshot.data.location.countryCode.toLowerCase()}.png',
                                  package: 'country_icons'),
                              const SizedBox(width: 10),
                              Text(snapshot.data.location.name,
                                  style: Styles.headline1),
                            ],
                          ),
                          Text(snapshot.data.time.toString()),
                          const SizedBox(height: 50),
                          Image.network(snapshot.data.iconUrl),
                          const SizedBox(height: 50),
                          Text(snapshot.data.description,
                              style: TextStyle(color: Colors.grey[600])),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  Text('min', style: Styles.headline3),
                                  Text(snapshot.data.minTemp.toString()),
                                ],
                              ),
                              Text(snapshot.data.temp.toString(),
                                  style: const TextStyle(fontSize: 40)),
                              Column(
                                children: [
                                  Text('max', style: Styles.headline3),
                                  Text(snapshot.data.maxTemp.toString()),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(children: [
                                  Text('humidity', style: Styles.headline2),
                                  const SizedBox(height: 5),
                                  Text(snapshot.data.humidity.toString())
                                ]),
                                Column(children: [
                                  Text('pressure', style: Styles.headline2),
                                  const SizedBox(height: 5),
                                  Text(snapshot.data.pressure.toString())
                                ]),
                                Column(children: [
                                  Text('wind', style: Styles.headline2),
                                  const SizedBox(height: 5),
                                  Text(snapshot.data.wind.toString())
                                ]),
                              ]),
                        ]),
                      ),
                    ])
                  ],
                );
              })),
    );
  }
}
