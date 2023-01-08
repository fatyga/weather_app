import 'package:weather_app/core/models/location_timezone.dart';

class SingleLocation {
  double latitude;
  double longitude;
  String name;
  String countryCode;
  String? state;
  bool autoDetected;
  LocationTimezone timezone;

  SingleLocation(
      {required this.latitude,
      required this.longitude,
      required this.name,
      required this.countryCode,
      this.autoDetected = false,
      this.state,
      required this.timezone});

  factory SingleLocation.fromMap(
      Map<String, dynamic> map, LocationTimezone timezone) {
    return SingleLocation(
        latitude: map['lat'],
        longitude: map['lon'],
        name: map['name'],
        countryCode: map['country'],
        state: map['state'],
        timezone: timezone);
  }

  SingleLocation copyWith(
      {double? latitude,
      double? longitude,
      String? name,
      String? countryCode,
      bool? autoDetected,
      LocationTimezone? timezone}) {
    return SingleLocation(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.latitude,
        name: name ?? this.name,
        countryCode: countryCode ?? this.countryCode,
        timezone: timezone ?? this.timezone);
  }
}
