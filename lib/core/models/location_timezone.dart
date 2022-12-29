class LocationTimezone {
  DateTime localTime;
  int utcOffset;

  LocationTimezone({required this.localTime, required this.utcOffset});

  factory LocationTimezone.fromMap(Map<String, dynamic> map) {
    var localTime = DateTime.parse(map['currentLocalTime']);
    return LocationTimezone(
        localTime: localTime, utcOffset: map['standardUtcOffset']['seconds']);
  }
}
