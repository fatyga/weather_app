import 'package:flutter/material.dart';
import 'package:weather_app/core/bloc/repository.dart';

class ThemeBloc {
  Repository _repository;
  ThemeBloc(this._repository);

  Stream<ThemeMode> get theme => _repository.theme;

  void toggleTheme(bool isDark) => _repository.toggleTheme(isDark);
}
