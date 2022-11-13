import 'package:flutter/material.dart';
import 'package:weather_app/core/enums/view_state.dart';
import 'package:weather_app/core/services/weather_service.dart';
import 'package:weather_app/core/viewModels/pollution_info_model.dart';
import 'package:weather_app/ui/views/base_view.dart';

class PollutionInfo extends StatelessWidget {
  //final Weather weather;
  const PollutionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<PollutionInfoModel>(onModelReady: (model) {
      if (model.firstInfoFetch) {
        model.getPollutionInfo();
      }
    }, builder: (context, model, child) {
      return SafeArea(
        child: Scaffold(
            body: (model.state == ViewState.busy || model.pollution == null)
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            const Text('Air Pollution Report',
                                style: TextStyle(color: Colors.white)),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Text(model.pollution!.aqi.toString(),
                                        style: const TextStyle(
                                            fontSize: 40, color: Colors.white)),
                                    Text('/5',
                                        style: TextStyle(
                                            fontSize: 40,
                                            color:
                                                Colors.white.withOpacity(0.5)))
                                  ],
                                ),
                                // Text(model.pollutionInfo['evaluation'],
                                //     style: const TextStyle(fontSize: 20, color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
      );
    });
  }
}
