import 'package:flutter/material.dart';

ThemeData get darkTheme => ThemeData.dark().copyWith(
      appBarTheme:
          AppBarTheme(elevation: 0, backgroundColor: Colors.transparent),
    );
