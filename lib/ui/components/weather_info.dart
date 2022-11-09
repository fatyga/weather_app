import 'package:flutter/material.dart';
import 'package:weather_app/core/enums/view_state.dart';
import 'package:weather_app/core/models/single_weather.dart';
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
    return BaseView<WeatherInfoModel>(
        onModelReady: (model) => model.getWeather(),
        builder: ((context, model, child) {
          return SafeArea(
            child: Scaffold(
                body: (model.state == ViewState.busy)
                    ? Center(child: CircularProgressIndicator())
                    : Row(children: <Widget>[
                        Expanded(
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text('units:'),
                                const SizedBox(width: 5),
                                // InkWell(
                                //     onTap: () {
                                //       // widget.weather.measurement = 'metric';
                                //       // widget.toUpdate();
                                //     },
                                //     child: Text('metric',
                                //         // style: (widget.weather.measurement == 'metric')
                                //         //     ? Styles.activeUnitButton
                                //         //     : const TextStyle(color: Colors.grey)
                                //         )
                                //             ),
                                // Container(
                                //   width: 1,
                                //   height: 15,
                                //   margin: const EdgeInsets.symmetric(horizontal: 5),
                                //   color: Colors.grey,
                                // ),
                                // InkWell(
                                //     onTap: () {
                                //       // widget.weather.measurement = 'imperial';
                                //       // widget.toUpdate();
                                //     },
                                //     child: Text('imperial',
                                //         style: (widget.weather.measurement == 'imperial')
                                //             ? Styles.activeUnitButton
                                //             : const TextStyle(color: Colors.grey))),
                              ],
                            ),
                            const SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    width: 35,
                                    height: 35,
                                    'icons/flags/png/${model.weather.location.countryCode.toLowerCase()}.png',
                                    package: 'country_icons'),
                                const SizedBox(width: 10),
                                Text(model.weather.location.name.toUpperCase(),
                                    style: Styles.headline1),
                                // IconButton(
                                //     onPressed: () async {
                                //       var result = await Navigator.of(context)
                                //           .push(MaterialPageRoute(builder: (context) {
                                //         return CitySearch(weatherInstance: widget.weather);
                                //       }));

                                //       if (result != null) {
                                //         if (result.runtimeType == int) {
                                //           widget.weather.currentLocationIndex = result;
                                //         } else {
                                //           widget.weather.locations.add(result);
                                //           widget.weather.currentLocationIndex =
                                //               widget.weather.locations.length - 1;
                                //         }

                                //         widget.toUpdate();
                                //       }
                                //     },
                                //     icon: const Icon(Icons.edit, size: 20)),
                              ],
                            ),
                            Text(model.weather.time.toString().toUpperCase()),
                            const SizedBox(height: 50),
                            Image.network(model.weather.iconUrl),
                            const SizedBox(height: 50),
                            Text(model.weather.description.toUpperCase(),
                                style: TextStyle(color: Colors.grey[600])),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Text('min', style: Styles.headline3),
                                    Text(model.weather.minTemp.toString()),
                                  ],
                                ),
                                Text('${model.weather.temp}',
                                    style: const TextStyle(fontSize: 40)),
                                Column(
                                  children: [
                                    Text('max', style: Styles.headline3),
                                    Text(model.weather.maxTemp.toString()),
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
                                    Text(model.weather.humidity.toString())
                                  ]),
                                  Column(children: [
                                    Text('pressure', style: Styles.headline2),
                                    const SizedBox(height: 5),
                                    Text(model.weather.pressure.toString())
                                  ]),
                                  Column(children: [
                                    Text('wind', style: Styles.headline2),
                                    const SizedBox(height: 5),
                                    Text(model.weather.wind.toString())
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
// class _WeatherViewState extends State<WeatherView> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(children: <Widget>[
//       Expanded(
//         child: Column(children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               const Text('units:'),
//               const SizedBox(width: 5),
//               InkWell(
//                   onTap: () {
//                     widget.weather.measurement = 'metric';
//                     widget.toUpdate();
//                   },
//                   child: Text('metric',
//                       style: (widget.weather.measurement == 'metric')
//                           ? Styles.activeUnitButton
//                           : const TextStyle(color: Colors.grey))),
//               Container(
//                 width: 1,
//                 height: 15,
//                 margin: const EdgeInsets.symmetric(horizontal: 5),
//                 color: Colors.grey,
//               ),
//               InkWell(
//                   onTap: () {
//                     widget.weather.measurement = 'imperial';
//                     widget.toUpdate();
//                   },
//                   child: Text('imperial',
//                       style: (widget.weather.measurement == 'imperial')
//                           ? Styles.activeUnitButton
//                           : const TextStyle(color: Colors.grey))),
//             ],
//           ),
//           const SizedBox(height: 50),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                   width: 35,
//                   height: 35,
//                   'icons/flags/png/${widget.weather.locations[widget.weather.currentLocationIndex].countryCode.toLowerCase()}.png',
//                   package: 'country_icons'),
//               const SizedBox(width: 10),
//               Text(
//                   '${widget.weather.weatherInfo['locationName']}'.toUpperCase(),
//                   style: Styles.headline1),
//               IconButton(
//                   onPressed: () async {
//                     var result = await Navigator.of(context)
//                         .push(MaterialPageRoute(builder: (context) {
//                       return CitySearch(weatherInstance: widget.weather);
//                     }));

//                     if (result != null) {
//                       if (result.runtimeType == int) {
//                         widget.weather.currentLocationIndex = result;
//                       } else {
//                         widget.weather.locations.add(result);
//                         widget.weather.currentLocationIndex =
//                             widget.weather.locations.length - 1;
//                       }

//                       widget.toUpdate();
//                     }
//                   },
//                   icon: const Icon(Icons.edit, size: 20)),
//             ],
//           ),
//           Text(widget.weather.weatherInfo['time'].toUpperCase()),
//           const SizedBox(height: 50),
//           Image.network(widget.weather.weatherInfo['icon']),
//           const SizedBox(height: 50),
//           Text(widget.weather.weatherInfo['description'].toUpperCase(),
//               style: TextStyle(color: Colors.grey[600])),
//           const SizedBox(height: 15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Column(
//                 children: [
//                   Text('min', style: Styles.headline3),
//                   Text(widget.weather.weatherInfo['minTemp']),
//                 ],
//               ),
//               Text('${widget.weather.weatherInfo['temp']}',
//                   style: const TextStyle(fontSize: 40)),
//               Column(
//                 children: [
//                   Text('max', style: Styles.headline3),
//                   Text(widget.weather.weatherInfo['maxTemp']),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 25),
//           Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//             Column(children: [
//               Text('humidity', style: Styles.headline2),
//               const SizedBox(height: 5),
//               Text(widget.weather.weatherInfo['humidity'])
//             ]),
//             Column(children: [
//               Text('pressure', style: Styles.headline2),
//               const SizedBox(height: 5),
//               Text(widget.weather.weatherInfo['pressure'])
//             ]),
//             Column(children: [
//               Text('wind', style: Styles.headline2),
//               const SizedBox(height: 5),
//               Text(widget.weather.weatherInfo['wind'])
//             ]),
//           ]),
//         ]),
//       ),
//     ]);
//   }
// }
