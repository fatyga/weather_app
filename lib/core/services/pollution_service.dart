import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/models/single_location.dart';
import 'package:weather_app/core/models/single_pollution.dart';

class PollutionService {
  Future<SinglePollution> getPollutionInfo(SingleLocation location) async {
    try {
      Response pollutionResponse = await get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/air_pollution?lat=${location.latitude}&lon=${location.longitude}&appid=1ba4d9aff1b4abdd1c75871989db2ded'));

      return SinglePollution.fromMap(jsonDecode(pollutionResponse.body));
    } on SocketException {
      throw const Failure(message: 'Check your internet connection');
    } on HttpException {
      throw const Failure(message: 'Couldn\'t fetch pollution report');
    } on FormatException {
      throw const Failure(message: 'Bad response format');
    }
  }
}
