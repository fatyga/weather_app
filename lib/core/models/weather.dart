import 'single_location.dart';
import 'single_weather.dart';

class Weather {
  final SingleWeather currentWeather;
  final List<SingleWeather> nextHoursWeather;
  final SingleLocation location;

  const Weather(
      {required this.currentWeather,
      required this.nextHoursWeather,
      required this.location});

  factory Weather.fromMaps(Map<String, dynamic> currentWeather,
      List<dynamic> nextHoursWeather, SingleLocation location) {
    return Weather(
        currentWeather: SingleWeather.fromMap(currentWeather, true),
        nextHoursWeather: nextHoursWeather
            .map((e) => SingleWeather.fromMap(e, false))
            .toList(),
        location: location);
  }
}
