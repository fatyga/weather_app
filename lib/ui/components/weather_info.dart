import 'package:flutter/material.dart';
import 'package:weather_app/core/enums/view_state.dart';
import 'package:weather_app/core/models/single_location.dart';
import 'package:weather_app/core/models/single_weather.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/core/viewModels/weather_info_model.dart';
import 'package:weather_app/ui/views/base_view.dart';
import 'package:weather_app/ui/views/city_search.dart';
import 'package:weather_app/core/services/weather_service.dart';
import 'package:weather_app/ui/shared/app_styles.dart';

class WeatherInfo extends StatefulWidget {
  WeatherInfo({Key? key}) : super(key: key);

  @override
  _WeatherInfoState createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  @override
  Widget build(BuildContext context) {
    return BaseView<WeatherInfoModel>(onModelReady: (model) {
      if (model.firstInfoFetch) {
        model.getWeather();
      }
    }, builder: ((context, model, child) {
      return SafeArea(
        child: Scaffold(
            body: (model.state == ViewState.busy || model.weather == null)
                ? Column(
                    children: [
                      const Center(child: CircularProgressIndicator()),
                      ElevatedButton(
                          onPressed: () async {
                            model.getWeather();
                          },
                          child: Text('fafsad'))
                    ],
                  )
                : (model.failure != null)
                    ? Column(
                        children: [
                          Text(model.failure.toString()),
                          ElevatedButton(
                              onPressed: () => model.getWeather(),
                              child: Text('Try again'))
                        ],
                      )
                    : Row(children: <Widget>[
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
                                    'icons/flags/png/${model.weather!.location.countryCode.toLowerCase()}.png',
                                    package: 'country_icons'),
                                const SizedBox(width: 10),
                                Text(model.weather!.location.name.toUpperCase(),
                                    style: Styles.headline1),
                              ],
                            ),
                            Text(model.weather!.time.toString().toUpperCase()),
                            const SizedBox(height: 50),
                            Image.network(model.weather!.iconUrl),
                            const SizedBox(height: 50),
                            Text(model.weather!.description.toUpperCase(),
                                style: TextStyle(color: Colors.grey[600])),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Text('min', style: Styles.headline3),
                                    Text(model.weather!.minTemp.toString()),
                                  ],
                                ),
                                Text('${model.weather!.temp}',
                                    style: const TextStyle(fontSize: 40)),
                                Column(
                                  children: [
                                    Text('max', style: Styles.headline3),
                                    Text(model.weather!.maxTemp.toString()),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(children: [
                                    Text('humidity', style: Styles.headline2),
                                    const SizedBox(height: 5),
                                    Text(model.weather!.humidity.toString())
                                  ]),
                                  Column(children: [
                                    Text('pressure', style: Styles.headline2),
                                    const SizedBox(height: 5),
                                    Text(model.weather!.pressure.toString())
                                  ]),
                                  Column(children: [
                                    Text('wind', style: Styles.headline2),
                                    const SizedBox(height: 5),
                                    Text(model.weather!.wind.toString())
                                  ]),
                                ]),
                            ElevatedButton(
                                onPressed: () {
                                  model.getWeather();
                                },
                                child: Text('Refresh'))
                          ]),
                        ),
                      ])),
      );
    }));
  }
}
