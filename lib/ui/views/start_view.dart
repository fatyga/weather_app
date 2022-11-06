import 'package:flutter/material.dart';
import 'package:weather_app/core/enums/view_state.dart';
import 'package:weather_app/core/viewModels/start_model.dart';
import 'package:weather_app/ui/components/pollution.dart';
import 'package:weather_app/core/services/weather.dart';
import 'package:weather_app/ui/views/base_view.dart';
import 'package:weather_app/ui/views/weather_info.dart';
import 'package:weather_app/ui/shared/app_styles.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<StartModel>(builder: (context, value, child) {
      return Scaffold(
          body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Weather App'),
          (value.state == ViewState.busy)
              ? CircularProgressIndicator()
              : Text('Success')
        ]),
      ));
    });
  }
}

// class StartScreen extends StatefulWidget {
//   const StartScreen({super.key});

//   @override
//   _StartScreenState createState() => _StartScreenState();
// }

// class _StartScreenState extends State<StartScreen> {
//   var instance = Weather();
//   late var value;

//   @override
//   void initState() {
//     value = instance.getWeather();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: SafeArea(
//           child: FutureBuilder(
//               future: value,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   if (snapshot.hasError) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           const Text('Weather App',
//                               style: TextStyle(fontSize: 25)),
//                           const SizedBox(height: 15),
//                           Text(snapshot.error.toString(), style: Styles.error),
//                           const SizedBox(height: 15),
//                           ElevatedButton(
//                               onPressed: () {
//                                 var refreshedInfo = instance.getWeather();
//                                 setState(() {
//                                   value = refreshedInfo;
//                                 });
//                               },
//                               child: const Text('Try again'))
//                         ],
//                       ),
//                     );
//                   } else {
//                     return Column(
//                       children: [
//                         const SizedBox(height: 20),
//                         WeatherView(
//                             weather: instance,
//                             toUpdate: () {
//                               var refreshedInfo = instance.getWeather();
//                               setState(() {
//                                 value = refreshedInfo;
//                               });
//                             }),
//                         const SizedBox(height: 20),
//                         PollutionView(
//                           weather: instance,
//                         ),
//                         const SizedBox(height: 20),
//                         ElevatedButton(
//                             onPressed: () {
//                               var refreshedInfo = instance.getWeather();
//                               setState(() {
//                                 value = refreshedInfo;
//                               });
//                             },
//                             child: const Text('Refresh')),
//                       ],
//                     );
//                   }
//                 }
//                 return Center(
//                     child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Text('Weather App', style: TextStyle(fontSize: 25)),
//                     SizedBox(height: 15),
//                     CircularProgressIndicator(),
//                   ],
//                 ));
//               }),
//         ),
//       ),
//     );
//   }
// }
