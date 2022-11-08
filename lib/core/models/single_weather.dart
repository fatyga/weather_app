class SingleWeather {
  final int time;
  final String iconUrl;
  final String description;
  final double temp;
  final double minTemp;
  final double feelsLike;
  final double maxTemp;
  final int pressure;
  final double wind;
  final int humidity;

  const SingleWeather(
      {required this.time,
      required this.iconUrl,
      required this.description,
      required this.temp,
      required this.minTemp,
      required this.feelsLike,
      required this.maxTemp,
      required this.humidity,
      required this.wind,
      required this.pressure});

  factory SingleWeather.fromMap(Map<String, dynamic> map) {
    return SingleWeather(
      time: map['dt'],
      description: map['weather'][0]['description'],
      temp: map['main']['temp'],
      minTemp: map['main']['temp_min'],
      maxTemp: map['main']['temp_max'],
      feelsLike: map['main']['feels_like'],
      pressure: map['main']['pressure'],
      wind: map['wind']['speed'],
      humidity: map['main']['humidity'],
      iconUrl:
          'http://openweathermap.org/img/wn/${map["weather"][0]["icon"]}@2x.png',
    );
  }
}
