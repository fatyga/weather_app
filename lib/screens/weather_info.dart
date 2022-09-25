import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text('Weather App')),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Row(children: <Widget>[
          Expanded(
            child: Column(children: [
              Text('${data['data']['locationName']}'),
              Image.network(data['data']['icon']),
              Text(data['data']['description']),
              Text('Temperature: ${data['data']['temp']}'),
              Text('Min. Temperature: ${data['data']['minTemp']}'),
              Text('Feels like Temperature: ${data['data']['feelsLike']}'),
              Text('Max. Temperature: ${data['data']['minTemp']}'),
              Text('Humidity: ${data['data']['humidity']}'),
              Text('Pressure: ${data['data']['pressure']}'),
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
