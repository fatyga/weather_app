import 'package:weather_app/core/models/single_pollution.dart';

class Pollution {
  final SinglePollution currentPollution;
  final List<SinglePollution> nextHoursPollution;

  Pollution({required this.currentPollution, required this.nextHoursPollution});

  factory Pollution.fromMaps(int utcOffset,
      Map<String, dynamic> currentPollution, List<dynamic> nextHoursPollution) {
    return Pollution(
        currentPollution: SinglePollution.fromMap(utcOffset, currentPollution),
        nextHoursPollution: nextHoursPollution
            .map((e) => SinglePollution.fromMap(utcOffset, e))
            .toList());
  }
}
