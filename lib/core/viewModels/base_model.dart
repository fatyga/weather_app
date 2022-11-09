import 'package:flutter/material.dart';
import 'package:weather_app/core/enums/view_state.dart';
import 'package:weather_app/core/failure.dart';

class BaseModel extends ChangeNotifier {
  Failure? _failure;
  Failure? get failure => _failure;

  void setFailure(Failure f) {
    _failure = f;
  }

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  void setViewState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
}
