import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/utils/app_styles.dart';

class WeatherInfo extends StatefulWidget {
  @override
  _WeatherInfoState createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
        child: Row(children: <Widget>[
          Expanded(
            child: Column(children: [
              const SizedBox(height: 50),
              Text('${data['data']['locationName']}'.toUpperCase(),
                  style: Styles.headline1),
              Text(data['data']['time'].toUpperCase()),
              const SizedBox(height: 50),
              Image.network(data['data']['icon']),
              const SizedBox(height: 50),
              Text(data['data']['description'].toUpperCase(),
                  style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: [
                      Text('min', style: Styles.headline3),
                      Text(data['data']['minTemp']),
                    ],
                  ),
                  Text('${data['data']['temp']}',
                      style: const TextStyle(fontSize: 40)),
                  Column(
                    children: [
                      Text('max', style: Styles.headline3),
                      Text(data['data']['minTemp']),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(children: [
                  Text('humidity', style: Styles.headline2),
                  const SizedBox(height: 5),
                  Text(data['data']['humidity'])
                ]),
                Column(children: [
                  Text('pressure', style: Styles.headline2),
                  const SizedBox(height: 5),
                  Text(data['data']['pressure'])
                ]),
                Column(children: [
                  Text('wind', style: Styles.headline2),
                  const SizedBox(height: 5),
                  Text(data['data']['wind'])
                ]),
              ]),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: const Text('Refresh')),
            ]),
          ),
        ]),
      ),
    );
  }
}
