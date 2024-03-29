import 'package:flutter/material.dart';
import 'package:weather_app/ui/screens/home/home_page.dart';
import 'package:weather_app/ui/shared/theme/dark_theme.dart';
import 'package:weather_app/ui/shared/theme/light_theme.dart';

import 'core/bloc/bloc_provider.dart';
import 'core/bloc/theme_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.savedDarkTheme});
  final bool? savedDarkTheme;

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    if (savedDarkTheme != null) {
      themeBloc.toggleTheme(savedDarkTheme!);
    }

    return StreamBuilder(
      stream: themeBloc.themeStream,
      builder: (context, themeMode) => MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode.data,
          title: 'Weather App',
          debugShowCheckedModeBanner: false,
          home: const HomePage()),
    );
  }
}
