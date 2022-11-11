import 'package:weather_app/core/enums/view_state.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/models/single_pollution.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/core/services/pollution_service.dart';
import 'package:weather_app/core/viewModels/base_model.dart';

class PollutionInfoModel extends BaseModel {
  PollutionService pollutionService = PollutionService();
  SinglePollution? pollution;

  void getPollutionInfo() async {
    setViewState(ViewState.busy);
    try {
      final userLocation = await LocationService.determinePosition();
      pollution = await pollutionService.getPollutionInfo(userLocation);
    } on Failure catch (f) {
      setFailure(f);
    }

    setViewState(ViewState.idle);
  }
}
