import 'package:flutter/material.dart';
import 'package:weather_app/core/enums/view_state.dart';

class StartView extends ChangeNotifier {
  final ViewState _state = ViewState.idle;
  ViewState get state => _state;
}
