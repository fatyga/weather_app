import 'package:weather_app/core/models/single_weather.dart';
import 'package:weather_app/core/models/single_location.dart';
import 'package:http/http.dart';
import 'dart:convert';

class WeatherService {
  Future<SingleWeather> getWeather(SingleLocation location) async {
    Response weatherResponse = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=1ba4d9aff1b4abdd1c75871989db2ded&units=metric'));
    return SingleWeather.fromMap(jsonDecode(weatherResponse.body), location);
  }
}
