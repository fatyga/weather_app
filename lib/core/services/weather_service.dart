import 'package:weather_app/core/models/single_location.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:weather_app/core/models/weather.dart';

class WeatherService {
  Future<Weather> getWeather(SingleLocation location) async {
    Response weatherResponse = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=1ba4d9aff1b4abdd1c75871989db2ded&units=metric'));

    Response nextHoursWeatherrEsponse = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&cnt=5&appid=1ba4d9aff1b4abdd1c75871989db2ded&units=metric'));
    return Weather.fromMaps(
        location.timezone.utcOffset,
        jsonDecode(weatherResponse.body),
        jsonDecode(nextHoursWeatherrEsponse.body)['list']);
  }
}
