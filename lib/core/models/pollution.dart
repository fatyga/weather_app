import 'package:weather_app/core/models/single_pollution.dart';

class Pollution {
  final SinglePollution currentPollution;
  final List<SinglePollution> nextHoursPollution;
  int utcOffset;

  Pollution(
      {required this.utcOffset,
      required this.currentPollution,
      required this.nextHoursPollution});

  factory Pollution.fromMaps(int utcOffset,
      Map<String, dynamic> currentPollution, List<dynamic> nextHoursPollution) {
    return Pollution(
        utcOffset: utcOffset,
        currentPollution: SinglePollution.fromMap(utcOffset, currentPollution),
        nextHoursPollution: nextHoursPollution
            .map((e) => SinglePollution.fromMap(utcOffset, e))
            .toList());
  }
}
