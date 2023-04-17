import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/bloc/bloc_provider.dart';
import 'package:weather_app/core/constants/enums.dart';
import 'package:weather_app/core/models/single_pollution.dart';
import 'package:weather_app/ui/screens/pollution/components/pollution_components_overview.dart';
import 'package:weather_app/ui/screens/pollution/components/pollution_forecast.dart';

import '../../../core/bloc/pollution_info_bloc.dart';

class PollutionView extends StatelessWidget {
  const PollutionView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PollutionInfoBloc>(context);

    return StreamBuilder<Object>(
        stream: bloc.info,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            return Column(
              children: [
                Row(
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    (bloc.currentLocation.autoDetected)
                        ? const Icon(Icons.location_on_outlined, size: 20)
                        : Container(),
                    Text(bloc.currentLocation.name,
                        style: Theme.of(context).textTheme.headlineSmall),
                    Text(
                        ', ${CountryCodes.detailsForLocale(Locale('en', bloc.currentLocation.countryCode)).localizedName}',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  DateFormat.yMMMEd()
                      .add_Hm()
                      .format(snapshot.data.currentPollution.time),
                ),
                const SizedBox(height: 32),
                Icon(
                  SinglePollution.icons[snapshot.data.currentPollution.aqi],
                  size: 64,
                ),
                const SizedBox(height: 32),
                Text(
                    SinglePollution
                        .descriptions[snapshot.data.currentPollution.aqi],
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: SinglePollution
                            .colors[snapshot.data.currentPollution.aqi])),
                const SizedBox(height: 32),
                AirComponentsOverview(
                    size: AirComponentSize.standard,
                    airComponents: snapshot
                        .data.currentPollution.airComponents.components),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Next hours',
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                ),
                AirPollutionForecast(
                  forecast: snapshot.data.nextHoursPollution,
                )
              ],
            );
          }
        });
  }
}
