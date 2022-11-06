import 'package:flutter/material.dart';
import 'package:weather_app/core/enums/view_state.dart';
import 'package:weather_app/core/services/location.dart';
import 'package:weather_app/core/viewModels/base_model.dart';

class StartModel extends BaseModel {
  void checkPermissions() async {
    setViewState(ViewState.busy);
    try {
      final permission = await LocationService.checkPermissions();
    } catch (e) {
      print(e);
    }
    setViewState(ViewState.idle);
  }
}
