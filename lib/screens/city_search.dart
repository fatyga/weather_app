import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CitySearch extends StatefulWidget {
  const CitySearch({super.key});

  @override
  State<CitySearch> createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {
  final cityNameController = TextEditingController();
  String errors = '';

  Future<Map> _getCoordinatesFromName(String cityName) async {
    try {
      Response response = await get(Uri.parse(
          'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=1ba4d9aff1b4abdd1c75871989db2ded'));

      if (response.statusCode == 200) {
        List result = jsonDecode(response.body);
        return result[0];
      } else {
        return Future.error('Error');
      }
    } catch (e) {
      setState(() {
        errors = "A problem occured. Check name and try again";
      });
    }
    throw 'error';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Find out city')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: cityNameController,
              decoration:
                  const InputDecoration(filled: true, labelText: 'City'),
            ),
            const SizedBox(height: 12),
            Text(errors, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    errors = '';
                  });

                  var result =
                      await _getCoordinatesFromName(cityNameController.text);

                  Navigator.of(context).pop(
                      {'latitude': result['lat'], 'longitude': result['lon']});
                },
                child: const Text('Search'))
          ],
        ),
      ),
    );
  }
}
