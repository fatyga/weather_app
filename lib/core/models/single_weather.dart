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

  factory SingleWeather.fromJSON(Map<String, dynamic> json) {
    return SingleWeather(
      time: json['dt'],
      description: json['weather'][0]['description'],
      temp: json['main']['temp'],
      minTemp: json['main']['temp_min'],
      maxTemp: json['main']['temp_max'],
      feelsLike: json['main']['feels_like'],
      pressure: json['main']['pressure'],
      wind: json['wind']['speed'],
      humidity: json['main']['humidity'],
      iconUrl:
          'http://openweathermap.org/img/wn/${json["weather"][0]["icon"]}@2x.png',
    );
  }
}
