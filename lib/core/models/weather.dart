import 'single_location.dart';
import 'single_weather.dart';

class Weather {
  final SingleWeather currentWeather;
  final List<SingleWeather> nextHoursWeather;

  const Weather({
    required this.currentWeather,
    required this.nextHoursWeather,
  });

  factory Weather.fromMaps(
      Map<String, dynamic> currentWeather, List<dynamic> nextHoursWeather) {
    return Weather(
      currentWeather: SingleWeather.fromMap(currentWeather, true),
      nextHoursWeather:
          nextHoursWeather.map((e) => SingleWeather.fromMap(e, false)).toList(),
    );
  }
}
