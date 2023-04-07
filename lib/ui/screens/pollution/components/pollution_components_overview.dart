import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/enums.dart';
import 'package:weather_app/core/models/single_pollution.dart';

class AirComponentsOverview extends StatelessWidget {
  const AirComponentsOverview(
      {super.key, required this.airComponents, required this.size});
  final List<Component> airComponents;
  final AirComponentSize size;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: airComponents
            .map<Widget>((element) => Column(
                  children: [
                    customizeAirComponentName(element.name, context),
                    const SizedBox(height: 8),
                    Container(
                        width: (size == AirComponentSize.standard) ? 54 : 44,
                        height: (size == AirComponentSize.standard) ? 54 : 44,
                        decoration: BoxDecoration(
                            color: element.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Text(element.value.toString(),
                              style: TextStyle(
                                  fontSize: (size == AirComponentSize.standard)
                                      ? 14
                                      : 12,
                                  fontWeight: FontWeight.bold,
                                  color: element.color)),
                        ))
                  ],
                ))
            .toList());
  }

  Widget customizeAirComponentName(String name, BuildContext context) {
    final chunks = name.toUpperCase().replaceAll('_', '').split("");
    final charCodes = [
      '\u2080',
      '\u2081',
      '\u2082',
      '\u2083',
      '\u2084',
      '\u2085',
      '\u2086',
      '\u2087',
      '\u2088',
      '\u2089'
    ];

    return RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style.copyWith(
                fontSize: size == AirComponentSize.standard ? 16 : 12),
            children: chunks.map((e) {
              if (num.tryParse(e) == null) {
                return TextSpan(
                  text: e,
                );
              } else {
                final charNum = int.parse(e);
                return TextSpan(
                  text: charCodes[charNum],
                );
              }
            }).toList()));
  }
}
