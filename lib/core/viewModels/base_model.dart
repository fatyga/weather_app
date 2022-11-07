import 'package:flutter/material.dart';
import 'package:weather_app/core/enums/view_state.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  void setViewState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
}