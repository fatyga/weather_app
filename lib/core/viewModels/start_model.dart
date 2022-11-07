import 'package:flutter/material.dart';
import 'package:weather_app/core/enums/view_state.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/services/location.dart';
import 'package:weather_app/core/viewModels/base_model.dart';

class StartModel extends BaseModel {
  Failure? _failure;
  Failure? get failure => _failure;
  void setFailure(Failure f) {
    _failure = f;
    notifyListeners();
  }

  Future<bool> checkPermissions() async {
    setViewState(ViewState.busy);
    try {
      final permission = await LocationService.checkPermissions();
      return permission;
    } on Failure catch (f) {
      setFailure(f);
    }

    setViewState(ViewState.idle);
    return false;
  }
}
