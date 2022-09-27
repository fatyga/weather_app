import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Weather {
  late Position userPosition;
  late Map weatherInfo;

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    userPosition = await Geolocator.getCurrentPosition();
  }

  get determinePosition => _determinePosition;

  Future<void> _getWeather() async {
    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${userPosition.latitude}&lon=${userPosition.longitude}&appid=1ba4d9aff1b4abdd1c75871989db2ded&units=metric'));

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      updateWeatherInfo(data);
    } else {
      return Future.error("Can't fetch weather informations.");
    }
  }

  get getWeather => _getWeather;

  Future<void> _setupWeather(Function fn) async {
    await determinePosition();
    await getWeather();
    fn();
  }

  get setupWeather => _setupWeather;

  void updateWeatherInfo(info) {
    weatherInfo = {
      'icon':
          'http://openweathermap.org/img/wn/${info["weather"][0]["icon"]}@2x.png',
      'description': info['weather'][0]['description'],
      'temp': '${info['main']['temp']}℃',
      'minTemp': '${info['main']['temp_min']}℃',
      'maxTemp': '${info['main']['temp_max']}℃',
      'feelsLike': '${info['main']['feels_like']}℃',
      'pressure': '${info['main']['pressure']}hPa',
      'wind': '${info['wind']['speed']}m/s',
      'humidity': '${info['main']['humidity']}%',
      'locationName': info['name']
    };
  }
}
