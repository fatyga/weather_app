import 'package:intl/intl.dart';

class SingleWeather {
  final String iconUrl;
  final String? description;
  final String temp;
  final String? pressure;
  final String? wind;
  final String? windDegree;
  final String? humidity;
  final DateTime time;

  const SingleWeather({
    required this.iconUrl,
    this.description,
    required this.temp,
    this.humidity,
    this.wind,
    this.windDegree,
    this.pressure,
    required this.time,
  });

  factory SingleWeather.fromMap(
      int utcOffset, Map<String, dynamic> weather, bool fullInfo) {
    if (fullInfo) {
      var time = weather['dt'] + utcOffset;
      return SingleWeather(
        description: weather['weather'][0]['description'],
        temp: '${weather['main']['temp']}℃',
        pressure: '${weather['main']['pressure']} hPa',
        wind: '${weather['wind']['speed']} m/s',
        windDegree: '${weather['wind']['deg']}',
        humidity: '${weather['main']['humidity']}%',
        time: DateTime.fromMillisecondsSinceEpoch(time * 1000),
        iconUrl:
            'http://openweathermap.org/img/wn/${weather["weather"][0]["icon"]}@2x.png',
      );
    } else {
      return SingleWeather(
        temp: '${weather['main']['temp']}℃',
        time: DateTime.parse(weather['dt_txt']),
        iconUrl:
            'http://openweathermap.org/img/wn/${weather["weather"][0]["icon"]}@2x.png',
      );
    }
  }
}
