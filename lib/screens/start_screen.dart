import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  var instance = Weather();
  late var value;

  @override
  void initState() {
    value = instance.setupWeather(() {
      Navigator.pushReplacementNamed(context, '/weather', arguments: {
        'data': instance.weatherInfo,
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Weather App', style: TextStyle(fontSize: 26)),
            const SizedBox(height: 20),
            FutureBuilder(
                future: value,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Column(
                        children: <Widget>[
                          Text(snapshot.error.toString()),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  value = instance.setupWeather(() {
                                    Navigator.pushReplacementNamed(
                                        context, '/weather',
                                        arguments: {
                                          'data': instance.weatherInfo,
                                        });
                                  });
                                });
                              },
                              child: const Text('Try again'))
                        ],
                      );
                    }
                  }
                  return CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }
}
