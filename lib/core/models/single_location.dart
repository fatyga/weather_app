class SingleLocation {
  double latitude;
  double longitude;
  String name;
  String countryCode;
  bool autoDetected;

  SingleLocation(
      {required this.latitude,
      required this.longitude,
      required this.name,
      required this.countryCode,
      this.autoDetected = false});

  factory SingleLocation.fromMap(Map<String, dynamic> map) {
    return SingleLocation(
        latitude: map['lat'],
        longitude: map['lon'],
        name: map['name'],
        countryCode: map['country']);
  }
}
