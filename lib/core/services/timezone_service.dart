import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/core/models/location_timezone.dart';

import '../models/single_location.dart';

class TimezoneService {
  Future<LocationTimezone> getTimezoneFromCoordinates(
      double latitude, double longitude) async {
    Response response = await get(Uri.parse(
        'https://www.timeapi.io/api/TimeZone/coordinate?latitude=${latitude}&longitude=${longitude}'));
    return LocationTimezone.fromMap(jsonDecode(response.body));
  }
}
