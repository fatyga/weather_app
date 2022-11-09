class SinglePollution {
  final int aqi;

  SinglePollution({required this.aqi});

  factory SinglePollution.fromMap(Map<String, dynamic> map) {
    return SinglePollution(aqi: map['list'][0]['aqi']);
  }
}
