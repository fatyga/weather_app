import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/bloc/bloc.dart';

class ThemeBloc implements Bloc {
  final StreamController<ThemeMode> _themeController =
      StreamController<ThemeMode>();

  Stream<ThemeMode> get themeStream => _themeController.stream;

  void toggleTheme(bool isDark) async {
    isDark
        ? _themeController.add(ThemeMode.dark)
        : _themeController.add(ThemeMode.light);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkTheme', isDark);
  }

  @override
  void dispose() {
    _themeController.close();
  }
}
