import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({super.key, required this.iconCode, required this.size});
  final String iconCode;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/svg/$iconCode.svg',
        width: size,
        height: size,
        color: Theme.of(context).colorScheme.inverseSurface);
  }
}
