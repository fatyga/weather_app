import 'package:weather_app/core/services/location.dart';
import 'package:weather_app/core/services/single_location.dart';
import 'package:weather_app/ui/shared/app_styles.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class Weather {
  late Map weatherInfo;
  late Map pollutionInfo;

  List<SingleLocation> locations = [];

  int currentLocationIndex = 0;

  String measurement = 'metric';

  List airPollutionDescriptions = [
    {
      'aqi': 1,
      'evaluation': 'Very Poor',
      'bgColor': Styles.aqi1bgColor,
    },
    {
      'aqi': 2,
      'evaluation': 'Poor',
      'bgColor': Styles.aqi2bgColor,
    },
    {
      'aqi': 3,
      'evaluation': 'Moderate',
      'bgColor': Styles.aqi3bgColor,
    },
    {
      'aqi': 4,
      'evaluation': 'Fair',
      'bgColor': Styles.aqi4bgColor,
    },
    {
      'aqi': 5,
      'evaluation': 'Good',
      'bgColor': Styles.aqi5bgColor,
    },
  ];

  Future<void> _getWeather() async {
    if (locations.isEmpty) {
      locations.add(await LocationService.determinePosition());
    }

    if (locations[currentLocationIndex].autoDetected) {
      locations[currentLocationIndex] =
          await LocationService.determinePosition();
    }

    Response weatherResponse = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${locations[currentLocationIndex].latitude}&lon=${locations[currentLocationIndex].longitude}&appid=1ba4d9aff1b4abdd1c75871989db2ded&units=$measurement'));
    Response pollutionResponse = await get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=${locations[currentLocationIndex].latitude}&lon=${locations[currentLocationIndex].longitude}&appid=1ba4d9aff1b4abdd1c75871989db2ded'));

    if (weatherResponse.statusCode == 200 &&
        pollutionResponse.statusCode == 200) {
      Map weatherData = jsonDecode(weatherResponse.body);
      Map pollutionData = jsonDecode(pollutionResponse.body);

      updateWeatherInfo(weatherData, measurement);
      updatePollutionInfo(pollutionData);
    } else {
      return Future.error("Can't fetch weather informations.");
    }
  }

  get getWeather => _getWeather;

  String _formatTime(int unixTime, int timezone) {
    var date = DateTime.fromMillisecondsSinceEpoch(
        unixTime * 1000 + timezone * 1000,
        isUtc: true);
    return DateFormat.EEEE().add_jm().format(date);
  }

  void updateWeatherInfo(Map info, measurement) {
    var temp = measurement == 'metric' ? '°C' : '°F';
    var windSpeed = measurement == 'metric' ? 'm/s' : 'mph';

    weatherInfo = {
      'time': _formatTime(info['dt'], info['timezone']),
      'icon':
          'http://openweathermap.org/img/wn/${info["weather"][0]["icon"]}@2x.png',
      'description': info['weather'][0]['description'],
      'temp': '${info['main']['temp']}$temp',
      'minTemp': '${info['main']['temp_min']}$temp',
      'maxTemp': '${info['main']['temp_max']}$temp',
      'feelsLike': '${info['main']['feels_like']}$temp',
      'pressure': '${info['main']['pressure']}hPa',
      'wind': '${info['wind']['speed']}$windSpeed',
      'humidity': '${info['main']['humidity']}%',
      'locationName': locations[currentLocationIndex].name,
      'locationCountry': locations[currentLocationIndex].countryCode
    };
  }

  void updatePollutionInfo(Map info) {
    pollutionInfo =
        airPollutionDescriptions[info['list'][0]['main']['aqi'] - 1];
  }
}
