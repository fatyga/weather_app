import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/core/bloc/bloc_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(children: [
        ListTile(
          title: Text('Dark Theme'),
          trailing: Switch(
              onChanged: (newValue) {
                BlocProvider.of(context).themeBloc.toggleTheme(newValue);
              },
              value: Theme.of(context).brightness == Brightness.dark),
        )
      ]),
    );
  }
}
