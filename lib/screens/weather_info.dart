import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
        child: Row(children: <Widget>[
          Expanded(
            child: Column(children: [
              Text('${data['data']['locationName']}'.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold)),
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
                      Text('min',
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[600])),
                      Text(data['data']['minTemp']),
                    ],
                  ),
                  Text('${data['data']['temp']}',
                      style: const TextStyle(fontSize: 40)),
                  Column(
                    children: [
                      Text('max',
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[600])),
                      Text(data['data']['minTemp']),
                    ],
                  ),
                ],
              ),
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
