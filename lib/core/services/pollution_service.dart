// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/models/pollution.dart';
import 'package:weather_app/core/models/single_location.dart';
import 'package:weather_app/core/models/single_pollution.dart';

class PollutionService {
  Future<Pollution> getPollutionInfo(SingleLocation location) async {
    try {
      Response currentPollutionResponse = await get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/air_pollution?lat=${location.latitude}&lon=${location.longitude}&appid=1ba4d9aff1b4abdd1c75871989db2ded'));

      Response nextHoursPollutionResponse = await get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=1ba4d9aff1b4abdd1c75871989db2ded'));
      return Pollution.fromMaps(
          location.timezone.utcOffset,
          jsonDecode(currentPollutionResponse.body)['list'][0],
          jsonDecode(nextHoursPollutionResponse.body)['list']);
    } on SocketException {
      throw const Failure(message: 'Check your internet connection');
    } on HttpException {
      throw const Failure(message: 'Couldn\'t fetch pollution report');
    } on FormatException {
      throw const Failure(message: 'Bad response format');
    }
  }
}
